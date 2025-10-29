import 'package:clover/clover.dart';
import 'package:connectivity_manager/connectivity_manager.dart';
import 'package:connectivity_manager_example/models.dart';
import 'package:connectivity_manager_example/util.dart';
import 'package:logging/logging.dart';

class HomeViewModel extends ViewModel {
  final ConnectivityManager _connectivityManager;
  final Map<String, NetworkModel> _wifiModels;
  final Map<String, NetworkModel> _ethernetModels;

  late final ConnectivityManagerNetworkCallback _wifiCallback;
  late final ConnectivityManagerNetworkCallback _ethernetCallback;

  Logger get logger => Logger('HomeViewModel');

  Map<String, NetworkModel> get wifiModels => _wifiModels;
  Map<String, NetworkModel> get ethernetModels => _ethernetModels;

  HomeViewModel()
    : _connectivityManager = ConnectivityManager(),
      _wifiModels = {},
      _ethernetModels = {} {
    final wr = NetworkRequest(transportTypes: [TransportType.wifi]);
    final er = NetworkRequest(transportTypes: [TransportType.ethernet]);
    _wifiCallback = ConnectivityManagerNetworkCallback(
      onAvailable: (network) async {
        logger.info('wifi onAvailable $network');
        final linkProperties = await _connectivityManager.getLinkProperties(
          network,
        );
        if (linkProperties == null) {
          logger.warning('wifi linkProperties is null');
          return;
        }
        final wifiModel = await linkProperties.getNetworkModel();
        if (wifiModel == null) {
          logger.warning('wifi model is null');
          return;
        }
        _wifiModels[wifiModel.iface] = wifiModel;
        notifyListeners();
      },
      onLosing: (network, maxMsToLive) {
        logger.info('wifi onLosing $network, $maxMsToLive');
      },
      onLost: (network) async {
        logger.info('wifi onLost $network');
        _wifiModels.clear();
        notifyListeners();
      },
    );
    _ethernetCallback = ConnectivityManagerNetworkCallback(
      onAvailable: (network) async {
        logger.info('ethernet onAvailable $network');
        final linkProperties = await _connectivityManager.getLinkProperties(
          network,
        );
        if (linkProperties == null) {
          logger.warning('ethernet linkProperties is null');
          return;
        }
        final model = await linkProperties.getNetworkModel();
        if (model == null) {
          logger.warning('ethernet model is null');
          return;
        }
        _ethernetModels[model.iface] = model;
        notifyListeners();
      },
      onLosing: (network, maxMsToLive) {
        logger.info('ethernet onLosing $network, $maxMsToLive');
      },
      onLost: (network) async {
        logger.info('ethernet onLost $network');
        _ethernetModels.clear();
        notifyListeners();
      },
    );
    _connectivityManager.registerNetworkCallback(wr, _wifiCallback);
    _connectivityManager.registerNetworkCallback(er, _ethernetCallback);
  }

  @override
  void dispose() {
    _connectivityManager.unregisterNetworkCallback(_wifiCallback);
    _connectivityManager.unregisterNetworkCallback(_ethernetCallback);
    super.dispose();
  }
}

extension on LinkProperties {
  Future<NetworkModel?> getNetworkModel() async {
    final iface = await getInterfaceName();
    if (iface == null) return null;
    final inetAddresses = await getAddressModels();
    final inetAddress = inetAddresses.firstOrNull;
    final gateway = await getGatewayModel();
    final dnsServers = await getDnsServerModels();
    return NetworkModel(
      iface: iface,
      ipAddress: inetAddress?.$1,
      subnetMask: inetAddress?.$2,
      gateway: gateway,
      dnsServers: dnsServers,
    );
  }

  Future<List<(String, String)>> getAddressModels() {
    return getLinkAddresses()
        .asStream()
        .expand((e) => e)
        .asyncMap((e) async {
          final inetAddress = await e.getAddress();
          if (inetAddress is! Inet4Address) return null;
          final ipAddress = await inetAddress.getHostAddress();
          if (ipAddress == null) return null;
          final prefixLength = await e.getPrefixLength();
          final subnetMask = NetworkUtil.getPrefixMask(prefixLength);
          return (ipAddress, subnetMask);
        })
        .toList()
        .then((e) => e.whereType<(String, String)>().toList());
  }

  Future<String?> getGatewayModel() {
    return getRoutes()
        .asStream()
        .expand((e) => e)
        .asyncMap((e) async {
          final isDefault = await e.isDefaultRoute();
          if (isDefault) {
            final inetGateway = await e.getGateway();
            if (inetGateway is! Inet4Address) return null;
            final gateway = await inetGateway.getHostAddress();
            return gateway;
          } else {
            return null;
          }
        })
        .toList()
        .then((e) => e.whereType<String>().toList().firstOrNull);
  }

  Future<List<String>> getDnsServerModels() async {
    return getDnsServers()
        .asStream()
        .expand((e) => e)
        .asyncMap((e) => e is Inet4Address ? e.getHostAddress() : null)
        .toList()
        .then((e) => e.whereType<String>().toList());
  }
}
