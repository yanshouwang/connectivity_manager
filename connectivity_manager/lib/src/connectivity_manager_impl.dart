import 'dart:typed_data';

import 'package:jni/jni.dart';

import 'connectivity_manager.dart';
import 'jni.dart' as jni;

final class ConnectivityManagerImpl extends ConnectivityManager {
  static Network? getProcessDefaultNetwork() =>
      jni.ConnectivityManager.getProcessDefaultNetwork()?.impl;

  static bool isNetworkTypeValid(NetworkType networkType) =>
      jni.ConnectivityManager.isNetworkTypeValid(networkType.api);

  static bool setProcessDefaultNetwork(Network network) =>
      jni.ConnectivityManager.setProcessDefaultNetwork(network.api);

  final jni.ConnectivityManager api;

  ConnectivityManagerImpl.internal(this.api) : super.impl();

  factory ConnectivityManagerImpl() {
    final apiOrNull = jni.ContextCompat.getSystemService(
      Jni.androidApplicationContext.as(jni.Context.type),
      jni.ConnectivityManager.type.jClass,
      T: jni.ConnectivityManager.type,
    );
    final api = ArgumentError.checkNotNull(apiOrNull, 'api');
    return ConnectivityManagerImpl.internal(api);
  }

  @override
  void addDefaultNetworkActiveListener(
    ConnectivityManagerOnNetworkActiveListener listener,
  ) => api.addDefaultNetworkActiveListener(listener.api);

  @override
  bool bindProcessToNetwork(Network network) =>
      api.bindProcessToNetwork(network.api);

  @override
  SocketKeepalive createSocketKeepalive(
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
      .impl;

  @override
  Network? getActiveNetwork() => api.getActiveNetwork().impl;

  @override
  NetworkInfo? getActiveNetworkInfo() => api.getActiveNetworkInfo().impl;

  @override
  List<NetworkInfo> getAllNetworkInfo() =>
      api.getAllNetworkInfo().map((e) => e.impl).toList();

  @override
  List<Network> getAllNetworks() =>
      api.getAllNetworks().map((e) => e.impl).toList();

  @override
  bool getBackgroundDataSetting() => api.getBackgroundDataSetting();

  @override
  Network? getBoundNetworkForProcess() => api.getBoundNetworkForProcess().impl;

  @override
  int getConnectionOwnerUid(
    int protocol,
    InetSocketAddress local,
    InetSocketAddress remote,
  ) => api.getConnectionOwnerUid(protocol, local.api, remote.api);

  @override
  ProxyInfo? getDefaultProxy() => api.getDefaultProxy().impl;

  @override
  LinkProperties? getLinkProperties(Network network) =>
      api.getLinkProperties(network.api).impl;

  @override
  int getMultipathPreference(Network network) =>
      api.getMultipathPreference(network.api);

  @override
  NetworkCapabilities? getNetworkCapabilities(Network network) =>
      api.getNetworkCapabilities(network.api).impl;

  @override
  NetworkInfo? getNetworkInfo1(NetworkType networkType) =>
      api.getNetworkInfo1(networkType.api).impl;

  @override
  NetworkInfo? getNetworkInfo2(Network network) =>
      api.getNetworkInfo2(network.api).impl;

  @override
  int getNetworkPreference() => api.getNetworkPreference();

  @override
  Uint8List? getNetworkWatchlistConfigHash() =>
      api.getNetworkWatchlistConfigHash();

  @override
  RestrictBackgroundStatus getRestrictBackgroundStatus() =>
      api.getRestrictBackgroundStatus().impl;

  @override
  bool isActiveNetworkMetered() => api.isActiveNetworkMetered();

  @override
  bool isDefaultNetworkActive() => api.isDefaultNetworkActive();

  @override
  void registerBestMatchingNetworkCallback(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  ) =>
      api.registerBestMatchingNetworkCallback(request.api, networkCallback.api);

  @override
  void registerDefaultNetworkCallback(
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.registerDefaultNetworkCallback(networkCallback.api);

  @override
  void registerNetworkCallback(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.registerNetworkCallback(request.api, networkCallback.api);

  @override
  void removeDefaultNetworkActiveListener(
    ConnectivityManagerOnNetworkActiveListener listener,
  ) => api.removeDefaultNetworkActiveListener(listener.api);

  @override
  void reportBadNetwork(Network network) => api.reportBadNetwork(network.api);

  @override
  void reportNetworkConnectivity(Network network, bool hasConnectivity) =>
      api.reportNetworkConnectivity(network.api, hasConnectivity);

  @override
  bool requestBandwidthUpdate(Network network) =>
      api.requestBandwidthUpdate(network.api);

  @override
  void requestNetwork(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback, [
    int? timeoutMs,
  ]) => api.requestNetwork(request.api, networkCallback.api, timeoutMs);

  @override
  void reserveNetwork(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.reserveNetwork(request.api, networkCallback.api);

  @override
  void setNetworkPreference(int preference) =>
      api.setNetworkPreference(preference);

  @override
  void unregisterNetworkCallback(
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.unregisterNetworkCallback(networkCallback.api);
}

// final class ConnectivityManagerNetworkCallbackImpl
//     extends ConnectivityManagerNetworkCallback {
//   final ConnectivityManagerNetworkCallbackProxyApi api;

//   ConnectivityManagerNetworkCallbackImpl.api(this.api) : super.impl();

//   factory ConnectivityManagerNetworkCallbackImpl({
//     bool includeLocationInfo = false,
//     void Function(Network network)? onAvailable,
//     void Function(Network network, bool blocked)? onBlockedStatusChanged,
//     void Function(Network network, NetworkCapabilities networkCapabilities)?
//     onCapabilitiesChanged,
//     void Function(Network network, LinkProperties linkProperties)?
//     onLinkPropertiesChanged,
//     void Function(Network network, int maxMsToLive)? onLosing,
//     void Function(Network network)? onLost,
//     void Function(NetworkCapabilities networkCapabilities)? onReserved,
//     void Function()? onUnavailable,
//   }) {
//     final api = includeLocationInfo
//         ? ConnectivityManagerNetworkCallbackProxyApi.flags(
//             onAvailable: (_, e) => onAvailable?.call(e.impl),
//             onBlockedStatusChanged: (_, e1, e2) =>
//                 onBlockedStatusChanged?.call(e1.impl, e2),
//             onCapabilitiesChanged: (_, e1, e2) =>
//                 onCapabilitiesChanged?.call(e1.impl, e2.impl),
//             onLinkPropertiesChanged: (_, e1, e2) =>
//                 onLinkPropertiesChanged?.call(e1.impl, e2.impl),
//             onLosing: (_, e1, e2) => onLosing?.call(e1.impl, e2),
//             onLost: (_, e) => onLost?.call(e.impl),
//             onReserved: (_, e) => onReserved?.call(e.impl),
//             onUnavailable: (_) => onUnavailable?.call(),
//             flags: [
//               ConnectivityManagerNetworkCallbackFlagApi.includeLocationInfo,
//             ],
//           )
//         : ConnectivityManagerNetworkCallbackProxyApi(
//             onAvailable: (_, e) => onAvailable?.call(e.impl),
//             onBlockedStatusChanged: (_, e1, e2) =>
//                 onBlockedStatusChanged?.call(e1.impl, e2),
//             onCapabilitiesChanged: (_, e1, e2) =>
//                 onCapabilitiesChanged?.call(e1.impl, e2.impl),
//             onLinkPropertiesChanged: (_, e1, e2) =>
//                 onLinkPropertiesChanged?.call(e1.impl, e2.impl),
//             onLosing: (_, e1, e2) => onLosing?.call(e1.impl, e2),
//             onLost: (_, e) => onLost?.call(e.impl),
//             onReserved: (_, e) => onReserved?.call(e.impl),
//             onUnavailable: (_) => onUnavailable?.call(),
//           );
//     return ConnectivityManagerNetworkCallbackImpl.api(api);
//   }
// }

// final class ConnectivityManagerOnNetworkActiveListenerImpl
//     extends ConnectivityManagerOnNetworkActiveListener {
//   final ConnectivityManagerOnNetworkActiveListenerProxyApi api;

//   ConnectivityManagerOnNetworkActiveListenerImpl.api(this.api) : super.impl();

//   factory ConnectivityManagerOnNetworkActiveListenerImpl({
//     required void Function() onNetworkActive,
//   }) {
//     final api = ConnectivityManagerOnNetworkActiveListenerProxyApi(
//       onNetworkActive: (_) => onNetworkActive(),
//     );
//     return ConnectivityManagerOnNetworkActiveListenerImpl.api(api);
//   }
// }

final class NetworkImpl extends Network {
  final jni.Network api;

  NetworkImpl.api(this.api) : super.impl();

  static Network fromNetworkHandle(int networkHandle) =>
      jni.Network.fromNetworkHandle(networkHandle)!.impl;

  @override
  void bindSocket1(Socket socket) => api.bindSocket$2(socket.api);

  @override
  void bindSocket2(DatagramSocket socket) => api.bindSocket$1(socket.api);

  @override
  void bindSocket3(FileDescriptor fd) => api.bindSocket(fd.api);

  @override
  List<InetAddress> getAllByName(String host) =>
      api.getAllByName(host).map((e) => e.impl).toList();

  @override
  InetAddress getByName(String host) => api.getByName(host).impl;

  @override
  int getNetworkHandle() => api.getNetworkHandle();

  @override
  SocketFactory getSocketFactory() => api.getSocketFactory().impl;

  @override
  UrlConnection openConnection(Url url, [Proxy? proxy]) =>
      api.openConnection(url.api, proxy?.api).impl;
}

// final class NetworkInfoImpl extends NetworkInfo {
//   final NetworkInfoProxyApi api;

//   NetworkInfoImpl.api(this.api) : super.impl();
// }

// final class NetworkRequestImpl extends NetworkRequest {
//   final NetworkRequestProxyApi api;

//   NetworkRequestImpl.api(this.api) : super.impl();

//   factory NetworkRequestImpl({
//     List<NetworkCapability>? capabilities,
//     List<TransportType>? transportTypes,
//     bool? includeOtherUidNetworks,
//     NetworkSpecifier? networkSpecifier,
//     List<int>? subIds,
//   }) {
//     final api = NetworkRequestProxyApi(
//       capabilities: capabilities?.map((e) => e.api).toList(),
//       transportTypes: transportTypes?.map((e) => e.api).toList(),
//       includeOtherUidNetworks: includeOtherUidNetworks,
//       networkSpecifier: networkSpecifier?.api,
//       subIds: subIds,
//     );
//     return NetworkRequestImpl.api(api);
//   }

//   @override
//   bool canBeSatisfiedBy(NetworkCapabilities nc) => api.canBeSatisfiedBy(nc.api);

//   @override
//   List<NetworkCapability> getCapabilities() =>
//       api.getCapabilities().then((e) => e.map((e1) => e1.impl).toList());

//   @override
//   NetworkSpecifier? getNetworkSpecifier() =>
//       api.getNetworkSpecifier().then((e) => e?.impl);

//   @override
//   List<int> getSubscriptionIds() => api.getSubscriptionIds();

//   @override
//   List<TransportType> getTransportTypes() =>
//       api.getTransportTypes().then((e) => e.map((e1) => e1.impl).toList());

//   @override
//   bool hasCapability(NetworkCapability capability) =>
//       api.hasCapability(capability.api);

//   @override
//   bool hasTransport(TransportType transportType) =>
//       api.hasTransport(transportType.api);
// }

// final class NetworkCapabilitiesImpl extends NetworkCapabilities {
//   final NetworkCapabilitiesProxyApi api;

//   NetworkCapabilitiesImpl.api(this.api) : super.impl();

//   @override
//   List<NetworkCapability> getCapabilities() =>
//       api.getCapabilities().then((e) => e.map((e1) => e1.impl).toList());

//   @override
//   List<int> getEnterpriseIds() => api.getEnterpriseIds();

//   @override
//   int getLinkDownstreamBandwidthKbps() => api.getLinkDownstreamBandwidthKbps();

//   @override
//   int getLinkUpstreamBandwidthKbps() => api.getLinkUpstreamBandwidthKbps();

//   @override
//   NetworkSpecifier? getNetworkSpecifier() =>
//       api.getNetworkSpecifier().then((e) => e?.impl);

//   @override
//   int getOwnerUid() => api.getOwnerUid();

//   @override
//   int getSignalStrength() => api.getSignalStrength();

//   @override
//   List<int> getSubscriptionIds() => api.getSubscriptionIds();

//   @override
//   TransportInfo? getTransportInfo() =>
//       api.getTransportInfo().then((e) => e?.impl);

//   @override
//   bool hasCapability(NetworkCapability capability) =>
//       api.hasCapability(capability.api);

//   @override
//   bool hasEnterpriseId(int enterpriseId) => api.hasEnterpriseId(enterpriseId);

//   @override
//   bool hasTransport(TransportType transportType) =>
//       api.hasTransport(transportType.api);
// }

// final class NetworkSpecifierImpl extends NetworkSpecifier {
//   final NetworkSpecifierProxyApi api;

//   NetworkSpecifierImpl.api(this.api) : super.impl();
// }

// final class LinkPropertiesImpl extends LinkProperties {
//   final LinkPropertiesProxyApi api;

//   LinkPropertiesImpl.api(this.api) : super.impl();

//   @override
//   bool addRoute(RouteInfo route) => api.addRoute(route.api);

//   @override
//   void clear() => api.clear();

//   @override
//   Inet4Address? getDhcpServerAddress() =>
//       api.getDhcpServerAddress().then((e) => e?.impl);

//   @override
//   List<InetAddress> getDnsServers() =>
//       api.getDnsServers().then((e) => e.map((e1) => e1.impl).toList());

//   @override
//   String? getDomains() => api.getDomains();

//   @override
//   ProxyInfo? getHttpProxy() => api.getHttpProxy().then((e) => e?.impl);

//   @override
//   String? getInterfaceName() => api.getInterfaceName();

//   @override
//   List<LinkAddress> getLinkAddresses() =>
//       api.getLinkAddresses().then((e) => e.map((e1) => e1.impl).toList());

//   @override
//   int getMtu() => api.getMtu();

//   @override
//   IpPrefix? getNat64Prefix() => api.getNat64Prefix().then((e) => e?.impl);

//   @override
//   String? getPrivateDnsServerName() => api.getPrivateDnsServerName();

//   @override
//   List<RouteInfo> getRoutes() =>
//       api.getRoutes().then((e) => e.map((e1) => e1.impl).toList());

//   @override
//   bool isPrivateDnsActive() => api.isPrivateDnsActive();

//   @override
//   bool isWakeOnLanSupported() => api.isWakeOnLanSupported();

//   @override
//   void setDhcpServerAddress(Inet4Address? serverAddress) =>
//       api.setDhcpServerAddress(serverAddress?.api);

//   @override
//   void setDnsServers(List<InetAddress> dnsServers) =>
//       api.setDnsServers(dnsServers.map((e) => e.api).toList());

//   @override
//   void setDomains(String? domains) => api.setDomains(domains);

//   @override
//   void setHttpProxy(ProxyInfo? proxy) => api.setHttpProxy(proxy?.api);

//   @override
//   void setInterfaceName(String? iface) => api.setInterfaceName(iface);

//   @override
//   void setLinkAddresses(List<LinkAddress> addresses) =>
//       api.setLinkAddresses(addresses.map((e) => e.api).toList());

//   @override
//   void setMtu(int mtu) => api.setMtu(mtu);

//   @override
//   void setNat64Prefix(IpPrefix? prefix) => api.setNat64Prefix(prefix?.api);
// }

// final class LinkAddressImpl extends LinkAddress {
//   final LinkAddressProxyApi api;

//   LinkAddressImpl.api(this.api) : super.impl();

//   @override
//   InetAddress getAddress() => api.getAddress().then((e) => e.impl);

//   @override
//   int getFlags() => api.getFlags();

//   @override
//   int getPrefixLength() => api.getPrefixLength();

//   @override
//   int getScope() => api.getScope();
// }

// final class IpPrefixImpl extends IpPrefix {
//   final IpPrefixProxyApi api;

//   IpPrefixImpl.api(this.api) : super.impl();

//   @override
//   bool contains(InetAddress address) => api.contains(address.api);

//   @override
//   InetAddress getAddress() => api.getAddress().then((e) => e.impl);

//   @override
//   int getPrefixLength() => api.getPrefixLength();

//   @override
//   Uint8List getRawAddress() => api.getRawAddress();
// }

// final class SocketKeepaliveImpl extends SocketKeepalive {
//   final SocketKeepaliveProxyApi api;

//   SocketKeepaliveImpl.api(this.api) : super.impl();
// }

// final class SocketKeepaliveCallbackImpl extends SocketKeepaliveCallback {
//   SocketKeepaliveCallbackProxyApi api;

//   SocketKeepaliveCallbackImpl.api(this.api) : super.impl();
// }

// final class IpSecManagerUdpEncapsulationSocketImpl
//     extends IpSecManagerUdpEncapsulationSocket {
//   final IpSecManagerUdpEncapsulationSocketProxyApi api;

//   IpSecManagerUdpEncapsulationSocketImpl.api(this.api) : super.impl();
// }

// final class ProxyInfoImpl extends ProxyInfo {
//   final ProxyInfoProxyApi api;

//   ProxyInfoImpl.api(this.api) : super.impl();
// }

// final class TransportInfoImpl extends TransportInfo {
//   final TransportInfoProxyApi api;

//   TransportInfoImpl.api(this.api) : super.impl();
// }

// final class RouteInfoImpl extends RouteInfo {
//   final RouteInfoProxyApi api;

//   RouteInfoImpl.api(this.api) : super.impl();

//   @override
//   IpPrefix getDestination() => api.getDestination().impl;

//   @override
//   InetAddress? getGateway() => api.getGateway().then((e) => e?.impl);

//   @override
//   String? getInterface() => api.getInterface();

//   @override
//   RouteType getType() => api.getType().then((e) => e.impl);

//   @override
//   bool hasGateway() => api.hasGateway();

//   @override
//   bool isDefaultRoute() => api.isDefaultRoute();

//   @override
//   bool matches(InetAddress destination) => api.matches(destination.api);
// }

// final class InetAddressesImpl extends InetAddresses {
//   static bool isNumericAddress(String address) =>
//       InetAddressesProxyApi.isNumericAddress(address);

//   static InetAddress parseNumericAddress(String address) =>
//       InetAddressesProxyApi.parseNumericAddress(address).then((e) => e.impl);

//   final InetAddressesProxyApi api;

//   InetAddressesImpl.api(this.api) : super.impl();
// }

// final class FileDescriptorImpl extends FileDescriptor {
//   final FileDescriptorProxyApi api;

//   FileDescriptorImpl.api(this.api) : super.impl();
// }

// final class InetAddressImpl extends InetAddress with InetAddressMixin {
//   static List<InetAddress> getAllByName(String? host) =>
//       InetAddressProxyApi.getAllByName(
//         host,
//       ).then((e) => e.map((e1) => e1.impl).toList());

//   static InetAddress getByAddress1(Uint8List addr) =>
//       InetAddressProxyApi.getByAddress1(addr).then((e) => e.impl);

//   static InetAddress getByAddress2(String? host, Uint8List addr) =>
//       InetAddressProxyApi.getByAddress2(host, addr).then((e) => e.impl);

//   static InetAddress getByName(String? host) =>
//       InetAddressProxyApi.getByName(host).then((e) => e.impl);

//   static InetAddress getLocalHost() =>
//       InetAddressProxyApi.getLocalHost().then((e) => e.impl);

//   static InetAddress getLoopbackAddress() =>
//       InetAddressProxyApi.getLoopbackAddress().then((e) => e.impl);

//   @override
//   final InetAddressProxyApi api;

//   InetAddressImpl.api(this.api) : super.impl();
// }

// final class Inet4AddressImpl extends Inet4Address with InetAddressMixin {
//   @override
//   final Inet4AddressProxyApi api;

//   Inet4AddressImpl.api(this.api) : super.impl();
// }

// final class Inet6AddressImpl extends Inet6Address with InetAddressMixin {
//   static Inet6Address getByAddress3(
//     String host,
//     Uint8List addr,
//     NetworkInterface nif,
//   ) => Inet6AddressProxyApi.getByAddress3(
//     host,
//     addr,
//     nif.api,
//   ).then((e) => e.impl);

//   static Inet6Address getByAddress4(String host, Uint8List addr, int scopeId) =>
//       Inet6AddressProxyApi.getByAddress4(
//         host,
//         addr,
//         scopeId,
//       ).then((e) => e.impl);

//   @override
//   final Inet6AddressProxyApi api;

//   Inet6AddressImpl.api(this.api) : super.impl();

//   @override
//   bool isIPv4CompatibleAddress() => api.isIPv4CompatibleAddress();
// }

// mixin InetAddressMixin on InetAddress {
//   InetAddressProxyApi get api;

//   @override
//   Uint8List getAddress() => api.getAddress();

//   @override
//   String getCanonicalHostName() => api.getCanonicalHostName();

//   @override
//   String? getHostAddress() => api.getHostAddress();

//   @override
//   String getHostName() => api.getHostName();

//   @override
//   bool isAnyLocalAddress() => api.isAnyLocalAddress();

//   @override
//   bool isLinkLocalAddress() => api.isLinkLocalAddress();

//   @override
//   bool isLoopbackAddress() => api.isLoopbackAddress();

//   @override
//   bool isMcGlobal() => api.isMcGlobal();

//   @override
//   bool isMcLinkLocal() => api.isMcLinkLocal();

//   @override
//   bool isMcNodeLocal() => api.isMcNodeLocal();

//   @override
//   bool isMcOrgLocal() => api.isMcOrgLocal();

//   @override
//   bool isMcSiteLocal() => api.isMcSiteLocal();

//   @override
//   bool isMulticastAddress() => api.isMulticastAddress();

//   @override
//   bool isReachable1(int timeout) => api.isReachable1(timeout);

//   @override
//   bool isReachable2(NetworkInterface? netif, int ttl, int timetout) =>
//       api.isReachable2(netif?.api, ttl, timetout);

//   @override
//   bool isSiteLocalAddress() => api.isSiteLocalAddress();
// }

// final class InetSocketAddressImpl extends InetSocketAddress {
//   final InetSocketAddressProxyApi api;

//   InetSocketAddressImpl.api(this.api) : super.impl();
// }

// final class NetworkInterfaceImpl extends NetworkInterface {
//   final NetworkInterfaceProxyApi api;

//   NetworkInterfaceImpl.api(this.api) : super.impl();
// }

// final class SocketImpl extends Socket {
//   final SocketProxyApi api;

//   SocketImpl.api(this.api) : super.impl();
// }

// final class DatagramSocketImpl extends DatagramSocket {
//   final DatagramSocketProxyApi api;

//   DatagramSocketImpl.api(this.api) : super.impl();
// }

// final class UrlImpl extends Url {
//   final UrlProxyApi api;

//   UrlImpl.api(this.api) : super.impl();
// }

// final class UrlConnectionImpl extends UrlConnection {
//   final UrlConnectionProxyApi api;

//   UrlConnectionImpl.api(this.api) : super.impl();
// }

// final class SocketFactoryImpl extends SocketFactory {
//   final SocketFactoryProxyApi api;

//   SocketFactoryImpl.api(this.api) : super.impl();
// }

// final class ProxyImpl extends Proxy {
//   final ProxyProxyApi api;

//   ProxyImpl.api(this.api) : super.impl();
// }

extension on NetworkType {
  int get api {
    switch (this) {
      case NetworkType.mobile:
        return jni.ConnectivityManager.TYPE_MOBILE;
      case NetworkType.wifi:
        return jni.ConnectivityManager.TYPE_WIFI;
      case NetworkType.mobileMms:
        return jni.ConnectivityManager.TYPE_MOBILE_MMS;
      case NetworkType.mobileSupl:
        return jni.ConnectivityManager.TYPE_MOBILE_SUPL;
      case NetworkType.mobileDun:
        return jni.ConnectivityManager.TYPE_MOBILE_DUN;
      case NetworkType.mobileHipri:
        return jni.ConnectivityManager.TYPE_MOBILE_HIPRI;
      case NetworkType.wimax:
        return jni.ConnectivityManager.TYPE_WIMAX;
      case NetworkType.bluetooth:
        return jni.ConnectivityManager.TYPE_BLUETOOTH;
      case NetworkType.dummy:
        return jni.ConnectivityManager.TYPE_DUMMY;
      case NetworkType.ethernet:
        return jni.ConnectivityManager.TYPE_ETHERNET;
      case NetworkType.vpn:
        return jni.ConnectivityManager.TYPE_VPN;
    }
  }
}

extension on int {
  NetworkType get networkTypeImpl {
    switch (this) {
      case jni.ConnectivityManager.TYPE_MOBILE:
        return NetworkType.mobile;
      case jni.ConnectivityManager.TYPE_WIFI:
        return NetworkType.wifi;
      case jni.ConnectivityManager.TYPE_MOBILE_MMS:
        return NetworkType.mobileMms;
      case jni.ConnectivityManager.TYPE_MOBILE_SUPL:
        return NetworkType.mobileSupl;
      case jni.ConnectivityManager.TYPE_MOBILE_DUN:
        return NetworkType.mobileDun;
      case jni.ConnectivityManager.TYPE_MOBILE_HIPRI:
        return NetworkType.mobileHipri;
      case jni.ConnectivityManager.TYPE_WIMAX:
        return NetworkType.wimax;
      case jni.ConnectivityManager.TYPE_BLUETOOTH:
        return NetworkType.bluetooth;
      case jni.ConnectivityManager.TYPE_DUMMY:
        return NetworkType.dummy;
      case jni.ConnectivityManager.TYPE_ETHERNET:
        return NetworkType.ethernet;
      case jni.ConnectivityManager.TYPE_VPN:
        return NetworkType.vpn;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }
}

// extension on NetworkCapability {
//   NetworkCapabilityApi get api => NetworkCapabilityApi.values[index];
// }

// extension on NetworkCapabilityApi {
//   NetworkCapability get impl => NetworkCapability.values[index];
// }

// extension on TransportType {
//   TransportTypeApi get api => TransportTypeApi.values[index];
// }

// extension on TransportTypeApi {
//   TransportType get impl => TransportType.values[index];
// }

// extension on RouteType {
//   RouteTypeApi get api => RouteTypeApi.values[index];
// }

// extension on RouteTypeApi {
//   RouteType get impl => RouteType.values[index];
// }

// extension on RestrictBackgroundStatus {
//   RestrictBackgroundStatusApi get api =>
//       RestrictBackgroundStatusApi.values[index];
// }

// extension on RestrictBackgroundStatusApi {
//   RestrictBackgroundStatus get impl => RestrictBackgroundStatus.values[index];
// }

// extension on ConnectivityManager {
//   ConnectivityManagerProxyApi get api {
//     final impl = this;
//     if (impl is! ConnectivityManagerImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on ConnectivityManagerProxyApi {
//   ConnectivityManager get impl => ConnectivityManagerImpl.api(this);
// }

// extension on ConnectivityManagerNetworkCallback {
//   ConnectivityManagerNetworkCallbackProxyApi get api {
//     final impl = this;
//     if (impl is! ConnectivityManagerNetworkCallbackImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on ConnectivityManagerNetworkCallbackProxyApi {
//   ConnectivityManagerNetworkCallback get impl =>
//       ConnectivityManagerNetworkCallbackImpl.api(this);
// }

// extension on ConnectivityManagerOnNetworkActiveListener {
//   ConnectivityManagerOnNetworkActiveListenerProxyApi get api {
//     final impl = this;
//     if (impl is! ConnectivityManagerOnNetworkActiveListenerImpl) {
//       throw TypeError();
//     }
//     return impl.api;
//   }
// }

// extension on ConnectivityManagerOnNetworkActiveListenerProxyApi {
//   ConnectivityManagerOnNetworkActiveListener get impl =>
//       ConnectivityManagerOnNetworkActiveListenerImpl.api(this);
// }

extension on Network {
  jni.Network get api {
    final impl = this;
    if (impl is! NetworkImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.Network {
  Network get impl => NetworkImpl.api(this);
}

// extension on NetworkInfo {
//   NetworkInfoProxyApi get api {
//     final impl = this;
//     if (impl is! NetworkInfoImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on NetworkInfoProxyApi {
//   NetworkInfo get impl => NetworkInfoImpl.api(this);
// }

// extension on NetworkRequest {
//   NetworkRequestProxyApi get api {
//     final impl = this;
//     if (impl is! NetworkRequestImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on NetworkRequestProxyApi {
//   NetworkRequest get impl => NetworkRequestImpl.api(this);
// }

// extension on NetworkCapabilities {
//   NetworkCapabilitiesProxyApi get api {
//     final impl = this;
//     if (impl is! NetworkCapabilitiesImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on NetworkCapabilitiesProxyApi {
//   NetworkCapabilities get impl => NetworkCapabilitiesImpl.api(this);
// }

// extension on NetworkSpecifier {
//   NetworkSpecifierProxyApi get api {
//     final impl = this;
//     if (impl is! NetworkSpecifierImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on NetworkSpecifierProxyApi {
//   NetworkSpecifier get impl => NetworkSpecifierImpl.api(this);
// }

// extension on LinkProperties {
//   LinkPropertiesProxyApi get api {
//     final impl = this;
//     if (impl is! LinkPropertiesImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on LinkPropertiesProxyApi {
//   LinkProperties get impl => LinkPropertiesImpl.api(this);
// }

// extension on LinkAddress {
//   LinkAddressProxyApi get api {
//     final impl = this;
//     if (impl is! LinkAddressImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on LinkAddressProxyApi {
//   LinkAddress get impl => LinkAddressImpl.api(this);
// }

// extension on IpPrefix {
//   IpPrefixProxyApi get api {
//     final impl = this;
//     if (impl is! IpPrefixImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on IpPrefixProxyApi {
//   IpPrefix get impl => IpPrefixImpl.api(this);
// }

// extension on SocketKeepalive {
//   SocketKeepaliveProxyApi get api {
//     final impl = this;
//     if (impl is! SocketKeepaliveImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on SocketKeepaliveProxyApi {
//   SocketKeepalive get impl => SocketKeepaliveImpl.api(this);
// }

// extension on SocketKeepaliveCallback {
//   SocketKeepaliveCallbackProxyApi get api {
//     final impl = this;
//     if (impl is! SocketKeepaliveCallbackImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on SocketKeepaliveCallbackProxyApi {
//   SocketKeepaliveCallback get impl => SocketKeepaliveCallbackImpl.api(this);
// }

// extension on IpSecManagerUdpEncapsulationSocket {
//   IpSecManagerUdpEncapsulationSocketProxyApi get api {
//     final impl = this;
//     if (impl is! IpSecManagerUdpEncapsulationSocketImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on IpSecManagerUdpEncapsulationSocketProxyApi {
//   IpSecManagerUdpEncapsulationSocket get impl =>
//       IpSecManagerUdpEncapsulationSocketImpl.api(this);
// }

// extension on ProxyInfo {
//   ProxyInfoProxyApi get api {
//     final impl = this;
//     if (impl is! ProxyInfoImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on ProxyInfoProxyApi {
//   ProxyInfo get impl => ProxyInfoImpl.api(this);
// }

// extension on TransportInfo {
//   TransportInfoProxyApi get api {
//     final impl = this;
//     if (impl is! TransportInfoImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on TransportInfoProxyApi {
//   TransportInfo get impl => TransportInfoImpl.api(this);
// }

// extension on RouteInfo {
//   RouteInfoProxyApi get api {
//     final impl = this;
//     if (impl is! RouteInfoImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on RouteInfoProxyApi {
//   RouteInfo get impl => RouteInfoImpl.api(this);
// }

// extension on InetAddresses {
//   InetAddressesProxyApi get api {
//     final impl = this;
//     if (impl is! InetAddressesImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on InetAddressesProxyApi {
//   InetAddresses get impl => InetAddressesImpl.api(this);
// }

// extension on FileDescriptor {
//   FileDescriptorProxyApi get api {
//     final impl = this;
//     if (impl is! FileDescriptorImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on FileDescriptorProxyApi {
//   FileDescriptor get impl => FileDescriptorImpl.api(this);
// }

// extension on InetAddress {
//   InetAddressProxyApi get api {
//     final impl = this;
//     if (impl is! InetAddressImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on InetAddressProxyApi {
//   InetAddress get impl {
//     final api = this;
//     return api is Inet6AddressProxyApi
//         ? Inet6AddressImpl.api(api)
//         : api is Inet4AddressProxyApi
//         ? Inet4AddressImpl.api(api)
//         : InetAddressImpl.api(api);
//   }
// }

// extension on Inet4Address {
//   Inet4AddressProxyApi get api {
//     final impl = this;
//     if (impl is! Inet4AddressImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on Inet4AddressProxyApi {
//   Inet4Address get impl => Inet4AddressImpl.api(this);
// }

// extension on Inet6Address {
//   Inet6AddressProxyApi get api {
//     final impl = this;
//     if (impl is! Inet6AddressImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on Inet6AddressProxyApi {
//   Inet6Address get impl => Inet6AddressImpl.api(this);
// }

// extension on InetSocketAddress {
//   InetSocketAddressProxyApi get api {
//     final impl = this;
//     if (impl is! InetSocketAddressImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on InetSocketAddressProxyApi {
//   InetSocketAddress get impl => InetSocketAddressImpl.api(this);
// }

// extension on NetworkInterface {
//   NetworkInterfaceProxyApi get api {
//     final impl = this;
//     if (impl is! NetworkInterfaceImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on NetworkInterfaceProxyApi {
//   NetworkInterface get impl => NetworkInterfaceImpl.api(this);
// }

// extension on Socket {
//   SocketProxyApi get api {
//     final impl = this;
//     if (impl is! SocketImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on SocketProxyApi {
//   Socket get impl => SocketImpl.api(this);
// }

// extension on DatagramSocket {
//   DatagramSocketProxyApi get api {
//     final impl = this;
//     if (impl is! DatagramSocketImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on DatagramSocketProxyApi {
//   DatagramSocket get impl => DatagramSocketImpl.api(this);
// }

// extension on Url {
//   UrlProxyApi get api {
//     final impl = this;
//     if (impl is! UrlImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on UrlProxyApi {
//   Url get impl => UrlImpl.api(this);
// }

// extension on UrlConnection {
//   UrlConnectionProxyApi get api {
//     final impl = this;
//     if (impl is! UrlConnectionImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on UrlConnectionProxyApi {
//   UrlConnection get impl => UrlConnectionImpl.api(this);
// }

// extension on SocketFactory {
//   SocketFactoryProxyApi get api {
//     final impl = this;
//     if (impl is! SocketFactoryImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on SocketFactoryProxyApi {
//   SocketFactory get impl => SocketFactoryImpl.api(this);
// }

// extension on Proxy {
//   ProxyProxyApi get api {
//     final impl = this;
//     if (impl is! ProxyImpl) throw TypeError();
//     return impl.api;
//   }
// }

// extension on ProxyProxyApi {
//   Proxy get impl => ProxyImpl.api(this);
// }
