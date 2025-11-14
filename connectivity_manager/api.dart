// Run with `dart run pigeon --input api.dart`.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/connectivity_manager_api.g.dart',
    kotlinOut:
        'android/src/main/kotlin/dev/zeekr/connectivity_manager/ConnectivityManagerApi.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'dev.zeekr.connectivity_manager',
      errorClassName: 'ConnectivityManagerError',
    ),
  ),
)
enum NetworkTypeApi {
  mobile, // 0
  wifi, // 1
  mobileMms, // 2
  mobileSupl, // 3
  mobileDun, // 4
  mobileHipri, // 5
  wimax, // 6
  bluetooth, // 7
  dummy, // 8
  ethernet, // 9
  vpn, // 17
}

enum NetworkCapabilityApi {
  mms, // 0
  supl, // 1
  dun, // 2
  fota, // 3
  ims, // 4
  cbs, // 5
  wifiP2p, // 6
  ia, // 7
  rcs, // 8
  xcap, // 9
  eims, // 10
  notMetered, // 11
  internet, // 12
  notRestricted, // 13
  trusted, // 14
  notVpn, // 15
  validated, // 16
  captivePortal, // 17
  notRoaming, // 18
  foreground, // 19
  notCongested, // 20
  notSuspended, // 21
  mcx, // 23
  temporarilyNotMetered, // 25
  enterprise, // 29
  headUnit, // 32
  mmtel, // 33
  prioritizeLatency, // 34
  prioritizeBandwidth, // 35
  localNetwork, // 36
  notBandwidthConstrained, // 37
}

enum TransportTypeApi {
  cellular, // 0
  wifi, // 1
  bluetooth, // 2
  ethernet, // 3
  vpn, // 4
  wifiAware, // 5
  lowpan, // 6
  usb, // 8
  thread, // 9
  satellite, // 10
}

enum RouteTypeApi {
  unicast, // 1
  unreachable, // 7
  throws, // 9
}

enum RestrictBackgroundStatusApi {
  disabled, // 1
  whitelisted, // 2
  enabled, // 3
}

enum ConnectivityManagerNetworkCallbackFlagApi { includeLocationInfo }

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.ConnectivityManager',
  ),
)
abstract class ConnectivityManagerProxyApi {
  @static
  late final ConnectivityManagerProxyApi instance;

  @static
  NetworkProxyApi? getProcessDefaultNetwork();
  @static
  bool isNetworkTypeValid(NetworkTypeApi networkType);
  @static
  bool setProcessDefaultNetwork(NetworkProxyApi network);

  void addDefaultNetworkActiveListener(
    ConnectivityManagerOnNetworkActiveListenerProxyApi listener,
  );
  void removeDefaultNetworkActiveListener(
    ConnectivityManagerOnNetworkActiveListenerProxyApi listener,
  );

  void registerBestMatchingNetworkCallback(
    NetworkRequestProxyApi request,
    ConnectivityManagerNetworkCallbackProxyApi networkCallback,
  );
  void registerDefaultNetworkCallback(
    ConnectivityManagerNetworkCallbackProxyApi networkCallback,
  );
  void registerNetworkCallback(
    NetworkRequestProxyApi request,
    ConnectivityManagerNetworkCallbackProxyApi networkCallback,
  );
  void unregisterNetworkCallback(
    ConnectivityManagerNetworkCallbackProxyApi networkCallback,
  );

  bool bindProcessToNetwork(NetworkProxyApi network);
  SocketKeepaliveProxyApi createSocketKeepalive(
    NetworkProxyApi network,
    IpSecManagerUdpEncapsulationSocketProxyApi socket,
    InetAddressProxyApi source,
    InetAddressProxyApi destination,
    SocketKeepaliveCallbackProxyApi callback,
  );
  NetworkProxyApi? getActiveNetwork();
  NetworkInfoProxyApi? getActiveNetworkInfo();
  List<NetworkInfoProxyApi> getAllNetworkInfo();
  List<NetworkProxyApi> getAllNetworks();
  bool getBackgroundDataSetting();
  NetworkProxyApi? getBoundNetworkForProcess();
  int getConnectionOwnerUid(
    int protocol,
    InetSocketAddressProxyApi local,
    InetSocketAddressProxyApi remote,
  );
  ProxyInfoProxyApi? getDefaultProxy();
  LinkPropertiesProxyApi? getLinkProperties(NetworkProxyApi network);
  int getMultipathPreference(NetworkProxyApi network);
  NetworkCapabilitiesProxyApi? getNetworkCapabilities(NetworkProxyApi network);
  NetworkInfoProxyApi? getNetworkInfo1(NetworkTypeApi networkType);
  NetworkInfoProxyApi? getNetworkInfo2(NetworkProxyApi network);
  int getNetworkPreference();
  Uint8List? getNetworkWatchlistConfigHash();
  RestrictBackgroundStatusApi getRestrictBackgroundStatus();
  bool isActiveNetworkMetered();
  bool isDefaultNetworkActive();
  void reportBadNetwork(NetworkProxyApi network);
  void reportNetworkConnectivity(NetworkProxyApi network, bool hasConnectivity);
  bool requestBandwidthUpdate(NetworkProxyApi network);
  void requestNetwork(
    NetworkRequestProxyApi request,
    ConnectivityManagerNetworkCallbackProxyApi networkCallback, [
    int? timeoutMs,
  ]);
  void reserveNetwork(
    NetworkRequestProxyApi request,
    ConnectivityManagerNetworkCallbackProxyApi networkCallback,
  );
  void setNetworkPreference(int preference);
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.ConnectivityManager.NetworkCallback',
  ),
)
abstract class ConnectivityManagerNetworkCallbackProxyApi {
  ConnectivityManagerNetworkCallbackProxyApi();
  ConnectivityManagerNetworkCallbackProxyApi.flags(
    List<ConnectivityManagerNetworkCallbackFlagApi> flags,
  );

  late final void Function(NetworkProxyApi network) onAvailable;
  late final void Function(NetworkProxyApi network, bool blocked)
  onBlockedStatusChanged;
  late final void Function(
    NetworkProxyApi network,
    NetworkCapabilitiesProxyApi networkCapabilities,
  )
  onCapabilitiesChanged;
  late final void Function(
    NetworkProxyApi network,
    LinkPropertiesProxyApi linkProperties,
  )
  onLinkPropertiesChanged;
  late final void Function(NetworkProxyApi network, int maxMsToLive) onLosing;
  late final void Function(NetworkProxyApi network) onLost;
  late final void Function(NetworkCapabilitiesProxyApi networkCapabilities)
  onReserved;
  late final void Function() onUnavailable;
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.ConnectivityManager.OnNetworkActiveListener',
  ),
)
abstract class ConnectivityManagerOnNetworkActiveListenerProxyApi {
  ConnectivityManagerOnNetworkActiveListenerProxyApi();

  late final void Function() onNetworkActive;
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'android.net.Network'),
)
abstract class NetworkProxyApi {
  @static
  NetworkProxyApi fromNetworkHandle(int networkHandle);

  void bindSocket1(SocketProxyApi socket);
  void bindSocket2(DatagramSocketProxyApi socket);
  void bindSocket3(FileDescriptorProxyApi fd);
  List<InetAddressProxyApi> getAllByName(String host);
  InetAddressProxyApi getByName(String host);
  int getNetworkHandle();
  SocketFactoryProxyApi getSocketFactory();
  UrlConnectionProxyApi openConnection(UrlProxyApi url, [ProxyProxyApi? proxy]);
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.NetworkInfo',
  ),
)
abstract class NetworkInfoProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.NetworkRequest',
  ),
)
abstract class NetworkRequestProxyApi {
  NetworkRequestProxyApi({
    List<NetworkCapabilityApi>? capabilities,
    List<TransportTypeApi>? transportTypes,
    bool? includeOtherUidNetworks,
    NetworkSpecifierProxyApi? networkSpecifier,
    List<int>? subIds,
  });

  bool canBeSatisfiedBy(NetworkCapabilitiesProxyApi nc);
  List<NetworkCapabilityApi> getCapabilities();
  NetworkSpecifierProxyApi? getNetworkSpecifier();
  List<int> getSubscriptionIds();
  List<TransportTypeApi> getTransportTypes();
  bool hasCapability(NetworkCapabilityApi capability);
  bool hasTransport(TransportTypeApi transportType);
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.NetworkCapabilities',
  ),
)
abstract class NetworkCapabilitiesProxyApi {
  List<NetworkCapabilityApi> getCapabilities();
  List<int> getEnterpriseIds();
  int getLinkDownstreamBandwidthKbps();
  int getLinkUpstreamBandwidthKbps();
  NetworkSpecifierProxyApi? getNetworkSpecifier();
  int getOwnerUid();
  int getSignalStrength();
  List<int> getSubscriptionIds();
  TransportInfoProxyApi? getTransportInfo();
  bool hasCapability(NetworkCapabilityApi capability);
  bool hasEnterpriseId(int enterpriseId);
  bool hasTransport(TransportTypeApi transportType);
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.NetworkSpecifier',
    minAndroidApi: 26,
  ),
)
abstract class NetworkSpecifierProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.LinkProperties',
  ),
)
abstract class LinkPropertiesProxyApi {
  bool addRoute(RouteInfoProxyApi route);
  void clear();
  Inet4AddressProxyApi? getDhcpServerAddress();
  List<InetAddressProxyApi> getDnsServers();
  String? getDomains();
  ProxyInfoProxyApi? getHttpProxy();
  String? getInterfaceName();
  List<LinkAddressProxyApi> getLinkAddresses();
  int getMtu();
  IpPrefixProxyApi? getNat64Prefix();
  String? getPrivateDnsServerName();
  List<RouteInfoProxyApi> getRoutes();
  bool isPrivateDnsActive();
  bool isWakeOnLanSupported();
  void setDhcpServerAddress(Inet4AddressProxyApi? serverAddress);
  void setDnsServers(List<InetAddressProxyApi> dnsServers);
  void setDomains(String? domains);
  void setHttpProxy(ProxyInfoProxyApi? proxy);
  void setInterfaceName(String? iface);
  void setLinkAddresses(List<LinkAddressProxyApi> addresses);
  void setMtu(int mtu);
  void setNat64Prefix(IpPrefixProxyApi? prefix);
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.LinkAddress',
  ),
)
abstract class LinkAddressProxyApi {
  InetAddressProxyApi getAddress();
  int getFlags();
  int getPrefixLength();
  int getScope();
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'android.net.IpPrefix'),
)
abstract class IpPrefixProxyApi {
  bool contains(InetAddressProxyApi address);
  InetAddressProxyApi getAddress();
  int getPrefixLength();
  Uint8List getRawAddress();
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.SocketKeepalive',
    minAndroidApi: 29,
  ),
)
abstract class SocketKeepaliveProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.SocketKeepalive.Callback',
    minAndroidApi: 29,
  ),
)
abstract class SocketKeepaliveCallbackProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.IpSecManager.UdpEncapsulationSocket',
    minAndroidApi: 28,
  ),
)
abstract class IpSecManagerUdpEncapsulationSocketProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'android.net.ProxyInfo'),
)
abstract class ProxyInfoProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.TransportInfo',
    minAndroidApi: 29,
  ),
)
abstract class TransportInfoProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'android.net.RouteInfo'),
)
abstract class RouteInfoProxyApi {
  IpPrefixProxyApi getDestination();
  InetAddressProxyApi? getGateway();
  String? getInterface();
  RouteTypeApi getType();
  bool hasGateway();
  bool isDefaultRoute();
  bool matches(InetAddressProxyApi destination);
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'android.net.InetAddresses',
    minAndroidApi: 29,
  ),
)
abstract class InetAddressesProxyApi {
  @static
  bool isNumericAddress(String address);
  @static
  InetAddressProxyApi parseNumericAddress(String address);
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'java.io.FileDescriptor'),
)
abstract class FileDescriptorProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'java.net.InetAddress'),
)
abstract class InetAddressProxyApi {
  @static
  List<InetAddressProxyApi> getAllByName(String? host);
  @static
  InetAddressProxyApi getByAddress1(Uint8List addr);
  @static
  InetAddressProxyApi getByAddress2(String? host, Uint8List addr);
  @static
  InetAddressProxyApi getByName(String? host);
  @static
  InetAddressProxyApi getLocalHost();
  @static
  InetAddressProxyApi getLoopbackAddress();

  Uint8List getAddress();
  String getCanonicalHostName();
  String? getHostAddress();
  String getHostName();
  bool isAnyLocalAddress();
  bool isLinkLocalAddress();
  bool isLoopbackAddress();
  bool isMcGlobal();
  bool isMcLinkLocal();
  bool isMcNodeLocal();
  bool isMcOrgLocal();
  bool isMcSiteLocal();
  bool isMulticastAddress();
  bool isReachable1(int timeout);
  bool isReachable2(NetworkInterfaceProxyApi? netif, int ttl, int timetout);
  bool isSiteLocalAddress();
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'java.net.Inet4Address'),
)
abstract class Inet4AddressProxyApi extends InetAddressProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'java.net.Inet6Address'),
)
abstract class Inet6AddressProxyApi extends InetAddressProxyApi {
  @static
  Inet6AddressProxyApi getByAddress3(
    String host,
    Uint8List addr,
    NetworkInterfaceProxyApi nif,
  );
  @static
  Inet6AddressProxyApi getByAddress4(String host, Uint8List addr, int scopeId);

  bool isIPv4CompatibleAddress();
}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'java.net.InetSocketAddress',
  ),
)
abstract class InetSocketAddressProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'java.net.NetworkInterface',
  ),
)
abstract class NetworkInterfaceProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'java.net.Socket'),
)
abstract class SocketProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'java.net.DatagramSocket',
  ),
)
abstract class DatagramSocketProxyApi {}

@ProxyApi(kotlinOptions: KotlinProxyApiOptions(fullClassName: 'java.net.URL'))
abstract class UrlProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(fullClassName: 'java.net.URLConnection'),
)
abstract class UrlConnectionProxyApi {}

@ProxyApi(
  kotlinOptions: KotlinProxyApiOptions(
    fullClassName: 'javax.net.SocketFactory',
  ),
)
abstract class SocketFactoryProxyApi {}

@ProxyApi(kotlinOptions: KotlinProxyApiOptions(fullClassName: 'java.net.Proxy'))
abstract class ProxyProxyApi {}
