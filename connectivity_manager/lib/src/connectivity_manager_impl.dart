// ignore_for_file: unused_element

import 'dart:typed_data';

import 'connectivity_manager.dart';
import 'connectivity_manager_api.dart';
import 'connectivity_manager_api.g.dart';

final class ConnectivityManagerImpl extends ConnectivityManagerApi {
  static Future<Network?> getProcessDefaultNetwork() =>
      ConnectivityManagerProxyApi.getProcessDefaultNetwork().then(
        (e) => e?.impl,
      );

  static Future<bool> isNetworkTypeValid(NetworkType networkType) =>
      ConnectivityManagerProxyApi.isNetworkTypeValid(networkType.api);

  static Future<bool> setProcessDefaultNetwork(Network network) =>
      ConnectivityManagerProxyApi.setProcessDefaultNetwork(network.api);

  final ConnectivityManagerProxyApi api;

  ConnectivityManagerImpl.api(this.api) : super.impl();

  factory ConnectivityManagerImpl() =>
      ConnectivityManagerImpl.api(ConnectivityManagerProxyApi.instance);

  @override
  Future<void> addDefaultNetworkActiveListener(
    ConnectivityManagerOnNetworkActiveListener listener,
  ) => api.addDefaultNetworkActiveListener(listener.api);

  @override
  Future<bool> bindProcessToNetwork(Network network) =>
      api.bindProcessToNetwork(network.api);

  @override
  Future<SocketKeepalive> createSocketKeepalive(
    Network network,
    IpSecManagerUdpEncapsulationSocket socket,
    InetAddress source,
    InetAddress destination,
    SocketKeepaliveCallback callback,
  ) => api
      .createSocketKeepalive(
        network.api,
        socket.api,
        source.api,
        destination.api,
        callback.api,
      )
      .then((e) => e.impl);

  @override
  Future<Network?> getActiveNetwork() =>
      api.getActiveNetwork().then((e) => e?.impl);

  @override
  Future<NetworkInfo?> getActiveNetworkInfo() =>
      api.getActiveNetworkInfo().then((e) => e?.impl);

  @override
  Future<List<NetworkInfo>> getAllNetworkInfo() =>
      api.getAllNetworkInfo().then((e) => e.map((e1) => e1.impl).toList());

  @override
  Future<List<Network>> getAllNetworks() =>
      api.getAllNetworks().then((e) => e.map((e1) => e1.impl).toList());

  @override
  Future<bool> getBackgroundDataSetting() => api.getBackgroundDataSetting();

  @override
  Future<Network?> getBoundNetworkForProcess() =>
      api.getBoundNetworkForProcess().then((e) => e?.impl);

  @override
  Future<int> getConnectionOwnerUid(
    int protocol,
    InetSocketAddress local,
    InetSocketAddress remote,
  ) => api.getConnectionOwnerUid(protocol, local.api, remote.api);

  @override
  Future<ProxyInfo?> getDefaultProxy() =>
      api.getDefaultProxy().then((e) => e?.impl);

  @override
  Future<LinkProperties?> getLinkProperties(Network network) =>
      api.getLinkProperties(network.api).then((e) => e?.impl);

  @override
  Future<int> getMultipathPreference(Network network) =>
      api.getMultipathPreference(network.api);

  @override
  Future<NetworkCapabilities?> getNetworkCapabilities(Network network) =>
      api.getNetworkCapabilities(network.api).then((e) => e?.impl);

  @override
  Future<NetworkInfo?> getNetworkInfo1(NetworkType networkType) =>
      api.getNetworkInfo1(networkType.api).then((e) => e?.impl);

  @override
  Future<NetworkInfo?> getNetworkInfo2(Network network) =>
      api.getNetworkInfo2(network.api).then((e) => e?.impl);

  @override
  Future<int> getNetworkPreference() => api.getNetworkPreference();

  @override
  Future<Uint8List?> getNetworkWatchlistConfigHash() =>
      api.getNetworkWatchlistConfigHash();

  @override
  Future<RestrictBackgroundStatus> getRestrictBackgroundStatus() =>
      api.getRestrictBackgroundStatus().then((e) => e.impl);

  @override
  Future<bool> isActiveNetworkMetered() => api.isActiveNetworkMetered();

  @override
  Future<bool> isDefaultNetworkActive() => api.isDefaultNetworkActive();

  @override
  Future<void> registerBestMatchingNetworkCallback(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  ) =>
      api.registerBestMatchingNetworkCallback(request.api, networkCallback.api);

  @override
  Future<void> registerDefaultNetworkCallback(
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.registerDefaultNetworkCallback(networkCallback.api);

  @override
  Future<void> registerNetworkCallback(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.registerNetworkCallback(request.api, networkCallback.api);

  @override
  Future<void> removeDefaultNetworkActiveListener(
    ConnectivityManagerOnNetworkActiveListener listener,
  ) => api.removeDefaultNetworkActiveListener(listener.api);

  @override
  Future<void> reportBadNetwork(Network network) =>
      api.reportBadNetwork(network.api);

  @override
  Future<void> reportNetworkConnectivity(
    Network network,
    bool hasConnectivity,
  ) => api.reportNetworkConnectivity(network.api, hasConnectivity);

  @override
  Future<bool> requestBandwidthUpdate(Network network) =>
      api.requestBandwidthUpdate(network.api);

  @override
  Future<void> requestNetwork(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback, [
    int? timeoutMs,
  ]) => api.requestNetwork(request.api, networkCallback.api, timeoutMs);

  @override
  Future<void> reserveNetwork(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.reserveNetwork(request.api, networkCallback.api);

  @override
  Future<void> setNetworkPreference(int preference) =>
      api.setNetworkPreference(preference);

  @override
  Future<void> unregisterNetworkCallback(
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.unregisterNetworkCallback(networkCallback.api);
}

final class ConnectivityManagerNetworkCallbackImpl
    extends ConnectivityManagerNetworkCallbackApi {
  final ConnectivityManagerNetworkCallbackProxyApi api;

  ConnectivityManagerNetworkCallbackImpl.api(this.api) : super.impl();

  factory ConnectivityManagerNetworkCallbackImpl({
    bool includeLocationInfo = false,
    void Function(Network network)? onAvailable,
    void Function(Network network, bool blocked)? onBlockedStatusChanged,
    void Function(Network network, NetworkCapabilities networkCapabilities)?
    onCapabilitiesChanged,
    void Function(Network network, LinkProperties linkProperties)?
    onLinkPropertiesChanged,
    void Function(Network network, int maxMsToLive)? onLosing,
    void Function(Network network)? onLost,
    void Function(NetworkCapabilities networkCapabilities)? onReserved,
    void Function()? onUnavailable,
  }) {
    final api = includeLocationInfo
        ? ConnectivityManagerNetworkCallbackProxyApi.flags(
            onAvailable: (_, e) => onAvailable?.call(e.impl),
            onBlockedStatusChanged: (_, e1, e2) =>
                onBlockedStatusChanged?.call(e1.impl, e2),
            onCapabilitiesChanged: (_, e1, e2) =>
                onCapabilitiesChanged?.call(e1.impl, e2.impl),
            onLinkPropertiesChanged: (_, e1, e2) =>
                onLinkPropertiesChanged?.call(e1.impl, e2.impl),
            onLosing: (_, e1, e2) => onLosing?.call(e1.impl, e2),
            onLost: (_, e) => onLost?.call(e.impl),
            onReserved: (_, e) => onReserved?.call(e.impl),
            onUnavailable: (_) => onUnavailable?.call(),
            flags: [
              ConnectivityManagerNetworkCallbackFlagApi.includeLocationInfo,
            ],
          )
        : ConnectivityManagerNetworkCallbackProxyApi(
            onAvailable: (_, e) => onAvailable?.call(e.impl),
            onBlockedStatusChanged: (_, e1, e2) =>
                onBlockedStatusChanged?.call(e1.impl, e2),
            onCapabilitiesChanged: (_, e1, e2) =>
                onCapabilitiesChanged?.call(e1.impl, e2.impl),
            onLinkPropertiesChanged: (_, e1, e2) =>
                onLinkPropertiesChanged?.call(e1.impl, e2.impl),
            onLosing: (_, e1, e2) => onLosing?.call(e1.impl, e2),
            onLost: (_, e) => onLost?.call(e.impl),
            onReserved: (_, e) => onReserved?.call(e.impl),
            onUnavailable: (_) => onUnavailable?.call(),
          );
    return ConnectivityManagerNetworkCallbackImpl.api(api);
  }
}

final class ConnectivityManagerOnNetworkActiveListenerImpl
    extends ConnectivityManagerOnNetworkActiveListenerApi {
  final ConnectivityManagerOnNetworkActiveListenerProxyApi api;

  ConnectivityManagerOnNetworkActiveListenerImpl.api(this.api) : super.impl();

  factory ConnectivityManagerOnNetworkActiveListenerImpl({
    required void Function() onNetworkActive,
  }) {
    final api = ConnectivityManagerOnNetworkActiveListenerProxyApi(
      onNetworkActive: (_) => onNetworkActive(),
    );
    return ConnectivityManagerOnNetworkActiveListenerImpl.api(api);
  }
}

final class NetworkImpl extends NetworkApi {
  final NetworkProxyApi api;

  NetworkImpl.api(this.api) : super.impl();

  static Future<Network> fromNetworkHandle(int networkHandle) =>
      NetworkProxyApi.fromNetworkHandle(networkHandle).then((e) => e.impl);

  @override
  Future<void> bindSocket1(Socket socket) => api.bindSocket1(socket.api);

  @override
  Future<void> bindSocket2(DatagramSocket socket) =>
      api.bindSocket2(socket.api);

  @override
  Future<void> bindSocket3(FileDescriptor fd) => api.bindSocket3(fd.api);

  @override
  Future<List<InetAddress>> getAllByName(String host) =>
      api.getAllByName(host).then((e) => e.map((e1) => e1.impl).toList());

  @override
  Future<InetAddress> getByName(String host) =>
      api.getByName(host).then((e) => e.impl);

  @override
  Future<int> getNetworkHandle() => api.getNetworkHandle();

  @override
  Future<SocketFactory> getSocketFatory() =>
      api.getSocketFatory().then((e) => e.impl);

  @override
  Future<UrlConnection> openConnection(Url url, [Proxy? proxy]) =>
      api.openConnection(url.api, proxy?.api).then((e) => e.impl);
}

final class NetworkInfoImpl extends NetworkInfoApi {
  final NetworkInfoProxyApi api;

  NetworkInfoImpl.api(this.api) : super.impl();
}

final class NetworkRequestImpl extends NetworkRequestApi {
  final NetworkRequestProxyApi api;

  NetworkRequestImpl.api(this.api) : super.impl();

  factory NetworkRequestImpl({
    List<NetworkCapability>? capabilities,
    List<TransportType>? transportTypes,
    bool? includeOtherUidNetworks,
    NetworkSpecifier? networkSpecifier,
    List<int>? subIds,
  }) {
    final api = NetworkRequestProxyApi(
      capabilities: capabilities?.map((e) => e.api).toList(),
      transportTypes: transportTypes?.map((e) => e.api).toList(),
      includeOtherUidNetworks: includeOtherUidNetworks,
      networkSpecifier: networkSpecifier?.api,
      subIds: subIds,
    );
    return NetworkRequestImpl.api(api);
  }

  @override
  Future<bool> canBeSatisfiedBy(NetworkCapabilities nc) =>
      api.canBeSatisfiedBy(nc.api);

  @override
  Future<List<NetworkCapability>> getCapabilities() =>
      api.getCapabilities().then((e) => e.map((e1) => e1.impl).toList());

  @override
  Future<NetworkSpecifier?> getNetworkSpecifier() =>
      api.getNetworkSpecifier().then((e) => e?.impl);

  @override
  Future<List<int>> getSubscriptionIds() => api.getSubscriptionIds();

  @override
  Future<List<TransportType>> getTransportTypes() =>
      api.getTransportTypes().then((e) => e.map((e1) => e1.impl).toList());

  @override
  Future<bool> hasCapability(NetworkCapability capability) =>
      api.hasCapability(capability.api);

  @override
  Future<bool> hasTransport(TransportType transportType) =>
      api.hasTransport(transportType.api);
}

final class NetworkCapabilitiesImpl extends NetworkCapabilitiesApi {
  final NetworkCapabilitiesProxyApi api;

  NetworkCapabilitiesImpl.api(this.api) : super.impl();

  @override
  Future<List<NetworkCapability>> getCapabilities() =>
      api.getCapabilities().then((e) => e.map((e1) => e1.impl).toList());

  @override
  Future<List<int>> getEnterpriseIds() => api.getEnterpriseIds();

  @override
  Future<int> getLinkDownstreamBandwidthKbps() =>
      api.getLinkDownstreamBandwidthKbps();

  @override
  Future<int> getLinkUpstreamBandwidthKbps() =>
      api.getLinkUpstreamBandwidthKbps();

  @override
  Future<NetworkSpecifier?> getNetworkSpecifier() =>
      api.getNetworkSpecifier().then((e) => e?.impl);

  @override
  Future<int> getOwnerUid() => api.getOwnerUid();

  @override
  Future<int> getSignalStrength() => api.getSignalStrength();

  @override
  Future<List<int>> getSubscriptionIds() => api.getSubscriptionIds();

  @override
  Future<TransportInfo?> getTransportInfo() =>
      api.getTransportInfo().then((e) => e?.impl);

  @override
  Future<bool> hasCapability(NetworkCapability capability) =>
      api.hasCapability(capability.api);

  @override
  Future<bool> hasEnterpriseId(int enterpriseId) =>
      api.hasEnterpriseId(enterpriseId);

  @override
  Future<bool> hasTransport(TransportType transportType) =>
      api.hasTransport(transportType.api);
}

final class NetworkSpecifierImpl extends NetworkSpecifierApi {
  final NetworkSpecifierProxyApi api;

  NetworkSpecifierImpl.api(this.api) : super.impl();
}

final class LinkPropertiesImpl extends LinkPropertiesApi {
  final LinkPropertiesProxyApi api;

  LinkPropertiesImpl.api(this.api) : super.impl();

  @override
  Future<bool> addRoute(RouteInfo route) => api.addRoute(route.api);

  @override
  Future<void> clear() => api.clear();

  @override
  Future<Inet4Address?> getDhcpServerAddress() =>
      api.getDhcpServerAddress().then((e) => e?.impl);

  @override
  Future<List<InetAddress>> getDnsServers() =>
      api.getDnsServers().then((e) => e.map((e1) => e1.impl).toList());

  @override
  Future<String?> getDomains() => api.getDomains();

  @override
  Future<ProxyInfo?> getHttpProxy() => api.getHttpProxy().then((e) => e?.impl);

  @override
  Future<String?> getInterfaceName() => api.getInterfaceName();

  @override
  Future<List<LinkAddress>> getLinkAddresses() =>
      api.getLinkAddresses().then((e) => e.map((e1) => e1.impl).toList());

  @override
  Future<int> getMtu() => api.getMtu();

  @override
  Future<IpPrefix?> getNat64Prefix() =>
      api.getNat64Prefix().then((e) => e?.impl);

  @override
  Future<String?> getPrivateDnsServerName() => api.getPrivateDnsServerName();

  @override
  Future<List<RouteInfo>> getRoutes() =>
      api.getRoutes().then((e) => e.map((e1) => e1.impl).toList());

  @override
  Future<bool> isPrivateDnsActive() => api.isPrivateDnsActive();

  @override
  Future<bool> isWakeOnLanSupported() => api.isWakeOnLanSupported();

  @override
  Future<void> setDhcpServerAddress(Inet4Address? serverAddress) =>
      api.setDhcpServerAddress(serverAddress?.api);

  @override
  Future<void> setDnsServers(List<InetAddress> dnsServers) =>
      api.setDnsServers(dnsServers.map((e) => e.api).toList());

  @override
  Future<void> setDomains(String? domains) => api.setDomains(domains);

  @override
  Future<void> setHttpProxy(ProxyInfo? proxy) => api.setHttpProxy(proxy?.api);

  @override
  Future<void> setInterfaceName(String? iface) => api.setInterfaceName(iface);

  @override
  Future<void> setLinkAddresses(List<LinkAddress> addresses) =>
      api.setLinkAddresses(addresses.map((e) => e.api).toList());

  @override
  Future<void> setMtu(int mtu) => api.setMtu(mtu);

  @override
  Future<void> setNat64Prefix(IpPrefix? prefix) =>
      api.setNat64Prefix(prefix?.api);
}

final class LinkAddressImpl extends LinkAddressApi {
  final LinkAddressProxyApi api;

  LinkAddressImpl.api(this.api) : super.impl();

  @override
  Future<InetAddress> getAddress() => api.getAddress().then((e) => e.impl);

  @override
  Future<int> getFlags() => api.getFlags();

  @override
  Future<int> getPrefixLength() => api.getPrefixLength();

  @override
  Future<int> getScope() => api.getScope();
}

final class IpPrefixImpl extends IpPrefixApi {
  final IpPrefixProxyApi api;

  IpPrefixImpl.api(this.api) : super.impl();

  @override
  Future<bool> contains(InetAddress address) => api.contains(address.api);

  @override
  Future<InetAddress> getAddress() => api.getAddress().then((e) => e.impl);

  @override
  Future<int> getPrefixLength() => api.getPrefixLength();

  @override
  Future<Uint8List> getRawAddress() => api.getRawAddress();
}

final class SocketKeepaliveImpl extends SocketKeepaliveApi {
  final SocketKeepaliveProxyApi api;

  SocketKeepaliveImpl.api(this.api) : super.impl();
}

final class SocketKeepaliveCallbackImpl extends SocketKeepaliveCallbackApi {
  SocketKeepaliveCallbackProxyApi api;

  SocketKeepaliveCallbackImpl.api(this.api) : super.impl();
}

final class IpSecManagerUdpEncapsulationSocketImpl
    extends IpSecManagerUdpEncapsulationSocketApi {
  final IpSecManagerUdpEncapsulationSocketProxyApi api;

  IpSecManagerUdpEncapsulationSocketImpl.api(this.api) : super.impl();
}

final class ProxyInfoImpl extends ProxyInfoApi {
  final ProxyInfoProxyApi api;

  ProxyInfoImpl.api(this.api) : super.impl();
}

final class TransportInfoImpl extends TransportInfoApi {
  final TransportInfoProxyApi api;

  TransportInfoImpl.api(this.api) : super.impl();
}

final class RouteInfoImpl extends RouteInfoApi {
  final RouteInfoProxyApi api;

  RouteInfoImpl.api(this.api) : super.impl();

  @override
  Future<IpPrefix> getDestination() => api.getDestination().then((e) => e.impl);

  @override
  Future<InetAddress?> getGateway() => api.getGateway().then((e) => e?.impl);

  @override
  Future<String?> getInterface() => api.getInterface();

  @override
  Future<RouteType> getType() => api.getType().then((e) => e.impl);

  @override
  Future<bool> hasGateway() => api.hasGateway();

  @override
  Future<bool> isDefaultRoute() => api.isDefaultRoute();

  @override
  Future<bool> matches(InetAddress destination) => api.matches(destination.api);
}

final class InetAddressesImpl extends InetAddressesApi {
  static Future<bool> isNumericAddress(String address) =>
      InetAddressesProxyApi.isNumericAddress(address);

  static Future<InetAddress> parseNumericAddress(String address) =>
      InetAddressesProxyApi.parseNumericAddress(address).then((e) => e.impl);

  final InetAddressesProxyApi api;

  InetAddressesImpl.api(this.api) : super.impl();
}

final class FileDescriptorImpl extends FileDescriptorApi {
  final FileDescriptorProxyApi api;

  FileDescriptorImpl.api(this.api) : super.impl();
}

final class InetAddressImpl extends InetAddressApi with InetAddressMixin {
  static Future<List<InetAddress>> getAllByName(String? host) =>
      InetAddressProxyApi.getAllByName(
        host,
      ).then((e) => e.map((e1) => e1.impl).toList());

  static Future<InetAddress> getByAddress1(Uint8List addr) =>
      InetAddressProxyApi.getByAddress1(addr).then((e) => e.impl);

  static Future<InetAddress> getByAddress2(String? host, Uint8List addr) =>
      InetAddressProxyApi.getByAddress2(host, addr).then((e) => e.impl);

  static Future<InetAddress> getByName(String? host) =>
      InetAddressProxyApi.getByName(host).then((e) => e.impl);

  static Future<InetAddress> getLocalHost() =>
      InetAddressProxyApi.getLocalHost().then((e) => e.impl);

  static Future<InetAddress> getLoopbackAddress() =>
      InetAddressProxyApi.getLoopbackAddress().then((e) => e.impl);

  @override
  final InetAddressProxyApi api;

  InetAddressImpl.api(this.api) : super.impl();
}

final class Inet4AddressImpl extends Inet4AddressApi with InetAddressMixin {
  @override
  final Inet4AddressProxyApi api;

  Inet4AddressImpl.api(this.api) : super.impl();
}

final class Inet6AddressImpl extends Inet6AddressApi with InetAddressMixin {
  static Future<Inet6Address> getByAddress3(
    String host,
    Uint8List addr,
    NetworkInterface nif,
  ) => Inet6AddressProxyApi.getByAddress3(
    host,
    addr,
    nif.api,
  ).then((e) => e.impl);

  static Future<Inet6Address> getByAddress4(
    String host,
    Uint8List addr,
    int scopeId,
  ) => Inet6AddressProxyApi.getByAddress4(
    host,
    addr,
    scopeId,
  ).then((e) => e.impl);

  @override
  final Inet6AddressProxyApi api;

  Inet6AddressImpl.api(this.api) : super.impl();

  @override
  Future<bool> isIPv4CompatibleAddress() => api.isIPv4CompatibleAddress();
}

mixin InetAddressMixin on InetAddress {
  InetAddressProxyApi get api;

  @override
  Future<Uint8List> getAddress() => api.getAddress();

  @override
  Future<String> getCanonicalHostName() => api.getCanonicalHostName();

  @override
  Future<String?> getHostAddress() => api.getHostAddress();

  @override
  Future<String> getHostName() => api.getHostName();

  @override
  Future<bool> isAnyLocalAddress() => api.isAnyLocalAddress();

  @override
  Future<bool> isLinkLocalAddress() => api.isLinkLocalAddress();

  @override
  Future<bool> isLoopbackAddress() => api.isLoopbackAddress();

  @override
  Future<bool> isMcGlobal() => api.isMcGlobal();

  @override
  Future<bool> isMcLinkLocal() => api.isMcLinkLocal();

  @override
  Future<bool> isMcNodeLocal() => api.isMcNodeLocal();

  @override
  Future<bool> isMcOrgLocal() => api.isMcOrgLocal();

  @override
  Future<bool> isMcSiteLocal() => api.isMcSiteLocal();

  @override
  Future<bool> isMulticastAddress() => api.isMulticastAddress();

  @override
  Future<bool> isReachable1(int timeout) => api.isReachable1(timeout);

  @override
  Future<bool> isReachable2(NetworkInterface? netif, int ttl, int timetout) =>
      api.isReachable2(netif?.api, ttl, timetout);

  @override
  Future<bool> isSiteLocalAddress() => api.isSiteLocalAddress();
}

final class InetSocketAddressImpl extends InetSocketAddressApi {
  final InetSocketAddressProxyApi api;

  InetSocketAddressImpl.api(this.api) : super.impl();
}

final class NetworkInterfaceImpl extends NetworkInterfaceApi {
  final NetworkInterfaceProxyApi api;

  NetworkInterfaceImpl.api(this.api) : super.impl();
}

final class SocketImpl extends SocketApi {
  final SocketProxyApi api;

  SocketImpl.api(this.api) : super.impl();
}

final class DatagramSocketImpl extends DatagramSocketApi {
  final DatagramSocketProxyApi api;

  DatagramSocketImpl.api(this.api) : super.impl();
}

final class UrlImpl extends UrlApi {
  final UrlProxyApi api;

  UrlImpl.api(this.api) : super.impl();
}

final class UrlConnectionImpl extends UrlConnectionApi {
  final UrlConnectionProxyApi api;

  UrlConnectionImpl.api(this.api) : super.impl();
}

final class SocketFactoryImpl extends SocketFactoryApi {
  final SocketFactoryProxyApi api;

  SocketFactoryImpl.api(this.api) : super.impl();
}

final class ProxyImpl extends ProxyApi {
  final ProxyProxyApi api;

  ProxyImpl.api(this.api) : super.impl();
}

extension on NetworkType {
  NetworkTypeApi get api => NetworkTypeApi.values[index];
}

extension on NetworkTypeApi {
  NetworkType get impl => NetworkType.values[index];
}

extension on NetworkCapability {
  NetworkCapabilityApi get api => NetworkCapabilityApi.values[index];
}

extension on NetworkCapabilityApi {
  NetworkCapability get impl => NetworkCapability.values[index];
}

extension on TransportType {
  TransportTypeApi get api => TransportTypeApi.values[index];
}

extension on TransportTypeApi {
  TransportType get impl => TransportType.values[index];
}

extension on RouteType {
  RouteTypeApi get api => RouteTypeApi.values[index];
}

extension on RouteTypeApi {
  RouteType get impl => RouteType.values[index];
}

extension on RestrictBackgroundStatus {
  RestrictBackgroundStatusApi get api =>
      RestrictBackgroundStatusApi.values[index];
}

extension on RestrictBackgroundStatusApi {
  RestrictBackgroundStatus get impl => RestrictBackgroundStatus.values[index];
}

extension on ConnectivityManager {
  ConnectivityManagerProxyApi get api {
    final impl = this;
    if (impl is! ConnectivityManagerImpl) throw TypeError();
    return impl.api;
  }
}

extension on ConnectivityManagerProxyApi {
  ConnectivityManager get impl => ConnectivityManagerImpl.api(this);
}

extension on ConnectivityManagerNetworkCallback {
  ConnectivityManagerNetworkCallbackProxyApi get api {
    final impl = this;
    if (impl is! ConnectivityManagerNetworkCallbackImpl) throw TypeError();
    return impl.api;
  }
}

extension on ConnectivityManagerNetworkCallbackProxyApi {
  ConnectivityManagerNetworkCallback get impl =>
      ConnectivityManagerNetworkCallbackImpl.api(this);
}

extension on ConnectivityManagerOnNetworkActiveListener {
  ConnectivityManagerOnNetworkActiveListenerProxyApi get api {
    final impl = this;
    if (impl is! ConnectivityManagerOnNetworkActiveListenerImpl) {
      throw TypeError();
    }
    return impl.api;
  }
}

extension on ConnectivityManagerOnNetworkActiveListenerProxyApi {
  ConnectivityManagerOnNetworkActiveListener get impl =>
      ConnectivityManagerOnNetworkActiveListenerImpl.api(this);
}

extension on Network {
  NetworkProxyApi get api {
    final impl = this;
    if (impl is! NetworkImpl) throw TypeError();
    return impl.api;
  }
}

extension on NetworkProxyApi {
  Network get impl => NetworkImpl.api(this);
}

extension on NetworkInfo {
  NetworkInfoProxyApi get api {
    final impl = this;
    if (impl is! NetworkInfoImpl) throw TypeError();
    return impl.api;
  }
}

extension on NetworkInfoProxyApi {
  NetworkInfo get impl => NetworkInfoImpl.api(this);
}

extension on NetworkRequest {
  NetworkRequestProxyApi get api {
    final impl = this;
    if (impl is! NetworkRequestImpl) throw TypeError();
    return impl.api;
  }
}

extension on NetworkRequestProxyApi {
  NetworkRequest get impl => NetworkRequestImpl.api(this);
}

extension on NetworkCapabilities {
  NetworkCapabilitiesProxyApi get api {
    final impl = this;
    if (impl is! NetworkCapabilitiesImpl) throw TypeError();
    return impl.api;
  }
}

extension on NetworkCapabilitiesProxyApi {
  NetworkCapabilities get impl => NetworkCapabilitiesImpl.api(this);
}

extension on NetworkSpecifier {
  NetworkSpecifierProxyApi get api {
    final impl = this;
    if (impl is! NetworkSpecifierImpl) throw TypeError();
    return impl.api;
  }
}

extension on NetworkSpecifierProxyApi {
  NetworkSpecifier get impl => NetworkSpecifierImpl.api(this);
}

extension on LinkProperties {
  LinkPropertiesProxyApi get api {
    final impl = this;
    if (impl is! LinkPropertiesImpl) throw TypeError();
    return impl.api;
  }
}

extension on LinkPropertiesProxyApi {
  LinkProperties get impl => LinkPropertiesImpl.api(this);
}

extension on LinkAddress {
  LinkAddressProxyApi get api {
    final impl = this;
    if (impl is! LinkAddressImpl) throw TypeError();
    return impl.api;
  }
}

extension on LinkAddressProxyApi {
  LinkAddress get impl => LinkAddressImpl.api(this);
}

extension on IpPrefix {
  IpPrefixProxyApi get api {
    final impl = this;
    if (impl is! IpPrefixImpl) throw TypeError();
    return impl.api;
  }
}

extension on IpPrefixProxyApi {
  IpPrefix get impl => IpPrefixImpl.api(this);
}

extension on SocketKeepalive {
  SocketKeepaliveProxyApi get api {
    final impl = this;
    if (impl is! SocketKeepaliveImpl) throw TypeError();
    return impl.api;
  }
}

extension on SocketKeepaliveProxyApi {
  SocketKeepalive get impl => SocketKeepaliveImpl.api(this);
}

extension on SocketKeepaliveCallback {
  SocketKeepaliveCallbackProxyApi get api {
    final impl = this;
    if (impl is! SocketKeepaliveCallbackImpl) throw TypeError();
    return impl.api;
  }
}

extension on SocketKeepaliveCallbackProxyApi {
  SocketKeepaliveCallback get impl => SocketKeepaliveCallbackImpl.api(this);
}

extension on IpSecManagerUdpEncapsulationSocket {
  IpSecManagerUdpEncapsulationSocketProxyApi get api {
    final impl = this;
    if (impl is! IpSecManagerUdpEncapsulationSocketImpl) throw TypeError();
    return impl.api;
  }
}

extension on IpSecManagerUdpEncapsulationSocketProxyApi {
  IpSecManagerUdpEncapsulationSocket get impl =>
      IpSecManagerUdpEncapsulationSocketImpl.api(this);
}

extension on ProxyInfo {
  ProxyInfoProxyApi get api {
    final impl = this;
    if (impl is! ProxyInfoImpl) throw TypeError();
    return impl.api;
  }
}

extension on ProxyInfoProxyApi {
  ProxyInfo get impl => ProxyInfoImpl.api(this);
}

extension on TransportInfo {
  TransportInfoProxyApi get api {
    final impl = this;
    if (impl is! TransportInfoImpl) throw TypeError();
    return impl.api;
  }
}

extension on TransportInfoProxyApi {
  TransportInfo get impl => TransportInfoImpl.api(this);
}

extension on RouteInfo {
  RouteInfoProxyApi get api {
    final impl = this;
    if (impl is! RouteInfoImpl) throw TypeError();
    return impl.api;
  }
}

extension on RouteInfoProxyApi {
  RouteInfo get impl => RouteInfoImpl.api(this);
}

extension on InetAddresses {
  InetAddressesProxyApi get api {
    final impl = this;
    if (impl is! InetAddressesImpl) throw TypeError();
    return impl.api;
  }
}

extension on InetAddressesProxyApi {
  InetAddresses get impl => InetAddressesImpl.api(this);
}

extension on FileDescriptor {
  FileDescriptorProxyApi get api {
    final impl = this;
    if (impl is! FileDescriptorImpl) throw TypeError();
    return impl.api;
  }
}

extension on FileDescriptorProxyApi {
  FileDescriptor get impl => FileDescriptorImpl.api(this);
}

extension on InetAddress {
  InetAddressProxyApi get api {
    final impl = this;
    if (impl is! InetAddressImpl) throw TypeError();
    return impl.api;
  }
}

extension on InetAddressProxyApi {
  InetAddress get impl {
    final api = this;
    return api is Inet6AddressProxyApi
        ? Inet6AddressImpl.api(api)
        : api is Inet4AddressProxyApi
        ? Inet4AddressImpl.api(api)
        : InetAddressImpl.api(api);
  }
}

extension on Inet4Address {
  Inet4AddressProxyApi get api {
    final impl = this;
    if (impl is! Inet4AddressImpl) throw TypeError();
    return impl.api;
  }
}

extension on Inet4AddressProxyApi {
  Inet4Address get impl => Inet4AddressImpl.api(this);
}

extension on Inet6Address {
  Inet6AddressProxyApi get api {
    final impl = this;
    if (impl is! Inet6AddressImpl) throw TypeError();
    return impl.api;
  }
}

extension on Inet6AddressProxyApi {
  Inet6Address get impl => Inet6AddressImpl.api(this);
}

extension on InetSocketAddress {
  InetSocketAddressProxyApi get api {
    final impl = this;
    if (impl is! InetSocketAddressImpl) throw TypeError();
    return impl.api;
  }
}

extension on InetSocketAddressProxyApi {
  InetSocketAddress get impl => InetSocketAddressImpl.api(this);
}

extension on NetworkInterface {
  NetworkInterfaceProxyApi get api {
    final impl = this;
    if (impl is! NetworkInterfaceImpl) throw TypeError();
    return impl.api;
  }
}

extension on NetworkInterfaceProxyApi {
  NetworkInterface get impl => NetworkInterfaceImpl.api(this);
}

extension on Socket {
  SocketProxyApi get api {
    final impl = this;
    if (impl is! SocketImpl) throw TypeError();
    return impl.api;
  }
}

extension on SocketProxyApi {
  Socket get impl => SocketImpl.api(this);
}

extension on DatagramSocket {
  DatagramSocketProxyApi get api {
    final impl = this;
    if (impl is! DatagramSocketImpl) throw TypeError();
    return impl.api;
  }
}

extension on DatagramSocketProxyApi {
  DatagramSocket get impl => DatagramSocketImpl.api(this);
}

extension on Url {
  UrlProxyApi get api {
    final impl = this;
    if (impl is! UrlImpl) throw TypeError();
    return impl.api;
  }
}

extension on UrlProxyApi {
  Url get impl => UrlImpl.api(this);
}

extension on UrlConnection {
  UrlConnectionProxyApi get api {
    final impl = this;
    if (impl is! UrlConnectionImpl) throw TypeError();
    return impl.api;
  }
}

extension on UrlConnectionProxyApi {
  UrlConnection get impl => UrlConnectionImpl.api(this);
}

extension on SocketFactory {
  SocketFactoryProxyApi get api {
    final impl = this;
    if (impl is! SocketFactoryImpl) throw TypeError();
    return impl.api;
  }
}

extension on SocketFactoryProxyApi {
  SocketFactory get impl => SocketFactoryImpl.api(this);
}

extension on Proxy {
  ProxyProxyApi get api {
    final impl = this;
    if (impl is! ProxyImpl) throw TypeError();
    return impl.api;
  }
}

extension on ProxyProxyApi {
  Proxy get impl => ProxyImpl.api(this);
}
