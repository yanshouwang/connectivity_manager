// ignore_for_file: unused_element

import 'dart:typed_data';

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
      jni.context,
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
        jni.context.mainExecutor,
        callback.api,
      )
      .impl;

  @override
  Network? getActiveNetwork() => api.getActiveNetwork()?.impl;

  @override
  NetworkInfo? getActiveNetworkInfo() => api.getActiveNetworkInfo()?.impl;

  @override
  List<NetworkInfo> getAllNetworkInfo() =>
      api.getAllNetworkInfo().map((e) => e!.impl).toList();

  @override
  List<Network> getAllNetworks() =>
      api.getAllNetworks().map((e) => e!.impl).toList();

  @override
  bool getBackgroundDataSetting() => api.getBackgroundDataSetting();

  @override
  Network? getBoundNetworkForProcess() => api.getBoundNetworkForProcess()?.impl;

  @override
  int getConnectionOwnerUid(
    int protocol,
    InetSocketAddress local,
    InetSocketAddress remote,
  ) => api.getConnectionOwnerUid(protocol, local.api, remote.api);

  @override
  ProxyInfo? getDefaultProxy() => api.getDefaultProxy()?.impl;

  @override
  LinkProperties? getLinkProperties(Network network) =>
      api.getLinkProperties(network.api)?.impl;

  @override
  int getMultipathPreference(Network network) =>
      api.getMultipathPreference(network.api);

  @override
  NetworkCapabilities? getNetworkCapabilities(Network network) =>
      api.getNetworkCapabilities(network.api)?.impl;

  @override
  NetworkInfo? getNetworkInfo1(NetworkType networkType) =>
      api.getNetworkInfo$1(networkType.api)?.impl;

  @override
  NetworkInfo? getNetworkInfo2(Network network) =>
      api.getNetworkInfo(network.api)?.impl;

  @override
  int getNetworkPreference() => api.getNetworkPreference();

  @override
  Uint8List? getNetworkWatchlistConfigHash() =>
      api.getNetworkWatchlistConfigHash()?.impl;

  @override
  RestrictBackgroundStatus getRestrictBackgroundStatus() =>
      api.getRestrictBackgroundStatus().restrictBackgroundStatusImpl;

  @override
  bool isActiveNetworkMetered() => api.isActiveNetworkMetered();

  @override
  bool isDefaultNetworkActive() => api.isDefaultNetworkActive();

  @override
  void registerBestMatchingNetworkCallback(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.registerBestMatchingNetworkCallback(
    request.api,
    networkCallback.api,
    jni.context.mainHandler,
  );

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
  ]) => timeoutMs == null
      ? api.requestNetwork$1(request.api, networkCallback.api)
      : api.requestNetwork$4(request.api, networkCallback.api, timeoutMs);

  @override
  void reserveNetwork(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.reserveNetwork(
    request.api,
    jni.context.mainHandler,
    networkCallback.api,
  );

  @override
  void setNetworkPreference(int preference) =>
      api.setNetworkPreference(preference);

  @override
  void unregisterNetworkCallback(
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.unregisterNetworkCallback(networkCallback.api);
}

final class ConnectivityManagerNetworkCallbackImpl
    extends ConnectivityManagerNetworkCallback {
  final jni.ConnectivityManager$NetworkCallback api;

  ConnectivityManagerNetworkCallbackImpl.internal(this.api) : super.impl();

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
    final callback = jni.JConnectivityManager$JNetworkCallback.implement(
      jni.$JConnectivityManager$JNetworkCallback(
        onAvailable: (e) => onAvailable?.call(e.impl),
        onBlockedStatusChanged: (e1, e2) =>
            onBlockedStatusChanged?.call(e1.impl, e2),
        onCapabilitiesChanged: (e1, e2) =>
            onCapabilitiesChanged?.call(e1.impl, e2.impl),
        onLinkPropertiesChanged: (e1, e2) =>
            onLinkPropertiesChanged?.call(e1.impl, e2.impl),
        onLosing: (e1, e2) => onLosing?.call(e1.impl, e2),
        onLost: (e) => onLost?.call(e.impl),
        onReserved: (e) => onReserved?.call(e.impl),
        onUnavailable: () => onUnavailable?.call(),
      ),
    );
    final api = includeLocationInfo
        ? jni.JConnectivityManager$JNetworkCallbackImpl.new$3(
            callback,
            jni.ConnectivityManager$NetworkCallback.FLAG_INCLUDE_LOCATION_INFO,
          )
        : jni.JConnectivityManager$JNetworkCallbackImpl.new$2(callback);
    return ConnectivityManagerNetworkCallbackImpl.internal(api);
  }
}

final class ConnectivityManagerOnNetworkActiveListenerImpl
    extends ConnectivityManagerOnNetworkActiveListener {
  final jni.ConnectivityManager$OnNetworkActiveListener api;

  ConnectivityManagerOnNetworkActiveListenerImpl.internal(this.api)
    : super.impl();

  factory ConnectivityManagerOnNetworkActiveListenerImpl({
    required void Function() onNetworkActive,
  }) {
    final api = jni.ConnectivityManager$OnNetworkActiveListener.implement(
      jni.$ConnectivityManager$OnNetworkActiveListener(
        onNetworkActive: onNetworkActive,
      ),
    );
    return ConnectivityManagerOnNetworkActiveListenerImpl.internal(api);
  }
}

final class NetworkImpl extends Network {
  final jni.Network api;

  NetworkImpl.internal(this.api) : super.impl();

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
      api.getAllByName(host.api)!.map((e) => e!.impl).toList();

  @override
  InetAddress getByName(String host) => api.getByName(host.api)!.impl;

  @override
  int getNetworkHandle() => api.getNetworkHandle();

  @override
  SocketFactory getSocketFactory() => api.getSocketFactory()!.impl;

  @override
  UrlConnection openConnection(Url url, [Proxy? proxy]) => proxy == null
      ? api.openConnection(url.api)!.impl
      : api.openConnection$1(url.api, proxy.api)!.impl;
}

final class NetworkInfoImpl extends NetworkInfo {
  final jni.NetworkInfo api;

  NetworkInfoImpl.internal(this.api) : super.impl();
}

final class NetworkRequestImpl extends NetworkRequest {
  final jni.NetworkRequest api;

  NetworkRequestImpl.internal(this.api) : super.impl();

  factory NetworkRequestImpl({
    List<NetworkCapability>? capabilities,
    List<TransportType>? transportTypes,
    bool? includeOtherUidNetworks,
    NetworkSpecifier? networkSpecifier,
    Set<int>? subIds,
  }) {
    final builder = jni.NetworkRequest$Builder();
    if (capabilities != null) {
      for (var capability in capabilities) {
        builder.addCapability(capability.api);
      }
    }
    if (transportTypes != null) {
      for (var transportType in transportTypes) {
        builder.addTransportType(transportType.api);
      }
    }
    if (includeOtherUidNetworks != null) {
      builder.setIncludeOtherUidNetworks(includeOtherUidNetworks);
    }
    if (networkSpecifier != null) {
      builder.setNetworkSpecifier(networkSpecifier.api);
    }
    if (subIds != null) {
      builder.setSubscriptionIds(
        subIds.map((e) => e.api).toJSet(jni.JInteger.type),
      );
    }
    final api = builder.build()!;
    return NetworkRequestImpl.internal(api);
  }

  @override
  bool canBeSatisfiedBy(NetworkCapabilities nc) => api.canBeSatisfiedBy(nc.api);

  @override
  List<NetworkCapability> getCapabilities() =>
      api.getCapabilities().map((e) => e.networkCapabilityImpl).toList();

  @override
  NetworkSpecifier? getNetworkSpecifier() => api.getNetworkSpecifier()?.impl;

  @override
  Set<int> getSubscriptionIds() =>
      api.getSubscriptionIds().map((e) => e!.impl).toSet();

  @override
  List<TransportType> getTransportTypes() =>
      api.getTransportTypes().map((e) => e.transportTypeImpl).toList();

  @override
  bool hasCapability(NetworkCapability capability) =>
      api.hasCapability(capability.api);

  @override
  bool hasTransport(TransportType transportType) =>
      api.hasTransport(transportType.api);
}

final class NetworkCapabilitiesImpl extends NetworkCapabilities {
  final jni.NetworkCapabilities api;

  NetworkCapabilitiesImpl.internal(this.api) : super.impl();

  @override
  List<NetworkCapability> getCapabilities() =>
      api.getCapabilities().map((e) => e.networkCapabilityImpl).toList();

  @override
  List<int> getEnterpriseIds() => api.getEnterpriseIds().toList();

  @override
  int getLinkDownstreamBandwidthKbps() => api.getLinkDownstreamBandwidthKbps();

  @override
  int getLinkUpstreamBandwidthKbps() => api.getLinkUpstreamBandwidthKbps();

  @override
  NetworkSpecifier? getNetworkSpecifier() => api.getNetworkSpecifier()?.impl;

  @override
  int getOwnerUid() => api.getOwnerUid();

  @override
  int getSignalStrength() => api.getSignalStrength();

  @override
  Set<int> getSubscriptionIds() =>
      api.getSubscriptionIds().map((e) => e!.impl).toSet();

  @override
  TransportInfo? getTransportInfo() => api.getTransportInfo()?.impl;

  @override
  bool hasCapability(NetworkCapability capability) =>
      api.hasCapability(capability.api);

  @override
  bool hasEnterpriseId(int enterpriseId) => api.hasEnterpriseId(enterpriseId);

  @override
  bool hasTransport(TransportType transportType) =>
      api.hasTransport(transportType.api);
}

final class NetworkSpecifierImpl extends NetworkSpecifier {
  final jni.NetworkSpecifier api;

  NetworkSpecifierImpl.internal(this.api) : super.impl();
}

final class LinkPropertiesImpl extends LinkProperties {
  final jni.LinkProperties api;

  LinkPropertiesImpl.internal(this.api) : super.impl();

  @override
  bool addRoute(RouteInfo route) => api.addRoute(route.api);

  @override
  void clear() => api.clear();

  @override
  Inet4Address? getDhcpServerAddress() => api.getDhcpServerAddress()?.impl;

  @override
  List<InetAddress> getDnsServers() =>
      api.getDnsServers().map((e) => e!.impl).toList();

  @override
  String? getDomains() => api.getDomains()?.impl;

  @override
  ProxyInfo? getHttpProxy() => api.getHttpProxy()?.impl;

  @override
  String? getInterfaceName() => api.getInterfaceName()?.impl;

  @override
  List<LinkAddress> getLinkAddresses() =>
      api.getLinkAddresses().map((e) => e!.impl).toList();

  @override
  int getMtu() => api.getMtu();

  @override
  IpPrefix? getNat64Prefix() => api.getNat64Prefix()?.impl;

  @override
  String? getPrivateDnsServerName() => api.getPrivateDnsServerName()?.impl;

  @override
  List<RouteInfo> getRoutes() => api.getRoutes().map((e) => e!.impl).toList();

  @override
  bool isPrivateDnsActive() => api.isPrivateDnsActive();

  @override
  bool isWakeOnLanSupported() => api.isWakeOnLanSupported();

  @override
  void setDhcpServerAddress(Inet4Address? serverAddress) =>
      api.setDhcpServerAddress(serverAddress?.api);

  @override
  void setDnsServers(List<InetAddress> dnsServers) => api.setDnsServers(
    dnsServers
        .map((e) => e.api)
        .toJList(jni.InetAddress.type)
        .as(jni.Collection.type(jni.InetAddress.type)),
  );

  @override
  void setDomains(String? domains) => api.setDomains(domains?.api);

  @override
  void setHttpProxy(ProxyInfo? proxy) => api.setHttpProxy(proxy?.api);

  @override
  void setInterfaceName(String? iface) => api.setInterfaceName(iface?.api);

  @override
  void setLinkAddresses(List<LinkAddress> addresses) => api.setLinkAddresses(
    addresses
        .map((e) => e.api)
        .toJList(jni.LinkAddress.type)
        .as(jni.Collection.type(jni.LinkAddress.type)),
  );

  @override
  void setMtu(int mtu) => api.setMtu(mtu);

  @override
  void setNat64Prefix(IpPrefix? prefix) => api.setNat64Prefix(prefix?.api);
}

final class LinkAddressImpl extends LinkAddress {
  final jni.LinkAddress api;

  LinkAddressImpl.internal(this.api) : super.impl();

  @override
  InetAddress getAddress() => api.getAddress()!.impl;

  @override
  int getFlags() => api.getFlags();

  @override
  int getPrefixLength() => api.getPrefixLength();

  @override
  int getScope() => api.getScope();
}

final class IpPrefixImpl extends IpPrefix {
  final jni.IpPrefix api;

  IpPrefixImpl.internal(this.api) : super.impl();

  @override
  bool contains(InetAddress address) => api.contains(address.api);

  @override
  InetAddress getAddress() => api.getAddress().impl;

  @override
  int getPrefixLength() => api.getPrefixLength();

  @override
  Uint8List getRawAddress() => api.getRawAddress().impl;
}

final class SocketKeepaliveImpl extends SocketKeepalive {
  final jni.SocketKeepalive api;

  SocketKeepaliveImpl.internal(this.api) : super.impl();
}

final class SocketKeepaliveCallbackImpl extends SocketKeepaliveCallback {
  jni.SocketKeepalive$Callback api;

  SocketKeepaliveCallbackImpl.internal(this.api) : super.impl();
}

final class IpSecManagerUdpEncapsulationSocketImpl
    extends IpSecManagerUdpEncapsulationSocket {
  final jni.IpSecManager$UdpEncapsulationSocket api;

  IpSecManagerUdpEncapsulationSocketImpl.internal(this.api) : super.impl();
}

final class ProxyInfoImpl extends ProxyInfo {
  final jni.ProxyInfo api;

  ProxyInfoImpl.internal(this.api) : super.impl();
}

final class TransportInfoImpl extends TransportInfo {
  final jni.TransportInfo api;

  TransportInfoImpl.internal(this.api) : super.impl();
}

final class RouteInfoImpl extends RouteInfo {
  final jni.RouteInfo api;

  RouteInfoImpl.internal(this.api) : super.impl();

  @override
  IpPrefix getDestination() => api.getDestination().impl;

  @override
  InetAddress? getGateway() => api.getGateway()?.impl;

  @override
  String? getInterface() => api.getInterface()?.impl;

  @override
  RouteType getType() => api.getType().routeTypeImpl;

  @override
  bool hasGateway() => api.hasGateway();

  @override
  bool isDefaultRoute() => api.isDefaultRoute();

  @override
  bool matches(InetAddress destination) => api.matches(destination.api);
}

final class InetAddressesImpl extends InetAddresses {
  static bool isNumericAddress(String address) =>
      jni.InetAddresses.isNumericAddress(address.api);

  static InetAddress parseNumericAddress(String address) =>
      jni.InetAddresses.parseNumericAddress(address.api).impl;

  final jni.InetAddresses api;

  InetAddressesImpl.internal(this.api) : super.impl();
}

final class FileDescriptorImpl extends FileDescriptor {
  final jni.FileDescriptor api;

  FileDescriptorImpl.internal(this.api) : super.impl();
}

base mixin InetAddressImpl on InetAddress {
  static List<InetAddress> getAllByName(String? host) =>
      jni.InetAddress.getAllByName(host?.api)!.map((e) => e!.impl).toList();

  static InetAddress getByAddress1(Uint8List addr) =>
      jni.InetAddress.getByAddress(addr.api)!.impl;

  static InetAddress getByAddress2(String? host, Uint8List addr) =>
      jni.InetAddress.getByAddress$1(host?.api, addr.api)!.impl;

  static InetAddress getByName(String? host) =>
      jni.InetAddress.getByName(host?.api)!.impl;

  static InetAddress getLocalHost() => jni.InetAddress.getLocalHost()!.impl;

  static InetAddress getLoopbackAddress() =>
      jni.InetAddress.getLoopbackAddress()!.impl;

  jni.InetAddress get api;

  @override
  Uint8List getAddress() => api.getAddress()!.impl;

  @override
  String getCanonicalHostName() => api.getCanonicalHostName()!.impl;

  @override
  String? getHostAddress() => api.getHostAddress()?.impl;

  @override
  String getHostName() => api.getHostName()!.impl;

  @override
  bool isAnyLocalAddress() => api.isAnyLocalAddress();

  @override
  bool isLinkLocalAddress() => api.isLinkLocalAddress();

  @override
  bool isLoopbackAddress() => api.isLoopbackAddress();

  @override
  bool isMcGlobal() => api.isMCGlobal();

  @override
  bool isMcLinkLocal() => api.isMCLinkLocal();

  @override
  bool isMcNodeLocal() => api.isMCNodeLocal();

  @override
  bool isMcOrgLocal() => api.isMCOrgLocal();

  @override
  bool isMcSiteLocal() => api.isMCSiteLocal();

  @override
  bool isMulticastAddress() => api.isMulticastAddress();

  @override
  bool isReachable1(int timeout) => api.isReachable(timeout);

  @override
  bool isReachable2(NetworkInterface? netif, int ttl, int timetout) =>
      api.isReachable$1(netif?.api, ttl, timetout);

  @override
  bool isSiteLocalAddress() => api.isSiteLocalAddress();
}

final class Inet4AddressImpl extends Inet4Address with InetAddressImpl {
  @override
  final jni.Inet4Address api;

  Inet4AddressImpl.internal(this.api) : super.impl();
}

final class Inet6AddressImpl extends Inet6Address with InetAddressImpl {
  static Inet6Address getByAddress3(
    String host,
    Uint8List addr,
    NetworkInterface nif,
  ) => jni.Inet6Address.getByAddress$3(host.api, addr.api, nif.api)!.impl;

  static Inet6Address getByAddress4(String host, Uint8List addr, int scopeId) =>
      jni.Inet6Address.getByAddress$2(host.api, addr.api, scopeId)!.impl;

  @override
  final jni.Inet6Address api;

  Inet6AddressImpl.internal(this.api) : super.impl();

  @override
  bool isIPv4CompatibleAddress() => api.isIPv4CompatibleAddress();
}

final class InetSocketAddressImpl extends InetSocketAddress {
  final jni.InetSocketAddress api;

  InetSocketAddressImpl.internal(this.api) : super.impl();
}

final class NetworkInterfaceImpl extends NetworkInterface {
  final jni.NetworkInterface api;

  NetworkInterfaceImpl.internal(this.api) : super.impl();
}

final class SocketImpl extends Socket {
  final jni.Socket api;

  SocketImpl.internal(this.api) : super.impl();
}

final class DatagramSocketImpl extends DatagramSocket {
  final jni.DatagramSocket api;

  DatagramSocketImpl.internal(this.api) : super.impl();
}

final class UrlImpl extends Url {
  final jni.URL api;

  UrlImpl.internal(this.api) : super.impl();
}

final class UrlConnectionImpl extends UrlConnection {
  final jni.URLConnection api;

  UrlConnectionImpl.internal(this.api) : super.impl();
}

final class SocketFactoryImpl extends SocketFactory {
  final jni.SocketFactory api;

  SocketFactoryImpl.internal(this.api) : super.impl();
}

final class ProxyImpl extends Proxy {
  final jni.Proxy api;

  ProxyImpl.internal(this.api) : super.impl();
}

extension on String {
  jni.JString get api => toJString();
}

extension on jni.JString {
  String get impl => toDartString();
}

extension on int {
  jni.JInteger get api => toJInteger();

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

  NetworkCapability get networkCapabilityImpl {
    switch (this) {
      case jni.NetworkCapabilities.NET_CAPABILITY_MMS:
        return NetworkCapability.mms;
      case jni.NetworkCapabilities.NET_CAPABILITY_SUPL:
        return NetworkCapability.supl;
      case jni.NetworkCapabilities.NET_CAPABILITY_DUN:
        return NetworkCapability.dun;
      case jni.NetworkCapabilities.NET_CAPABILITY_FOTA:
        return NetworkCapability.fota;
      case jni.NetworkCapabilities.NET_CAPABILITY_IMS:
        return NetworkCapability.ims;
      case jni.NetworkCapabilities.NET_CAPABILITY_CBS:
        return NetworkCapability.cbs;
      case jni.NetworkCapabilities.NET_CAPABILITY_WIFI_P2P:
        return NetworkCapability.wifiP2p;
      case jni.NetworkCapabilities.NET_CAPABILITY_IA:
        return NetworkCapability.ia;
      case jni.NetworkCapabilities.NET_CAPABILITY_RCS:
        return NetworkCapability.rcs;
      case jni.NetworkCapabilities.NET_CAPABILITY_XCAP:
        return NetworkCapability.xcap;
      case jni.NetworkCapabilities.NET_CAPABILITY_EIMS:
        return NetworkCapability.eims;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_METERED:
        return NetworkCapability.notMetered;
      case jni.NetworkCapabilities.NET_CAPABILITY_INTERNET:
        return NetworkCapability.internet;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED:
        return NetworkCapability.notRestricted;
      case jni.NetworkCapabilities.NET_CAPABILITY_TRUSTED:
        return NetworkCapability.trusted;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_VPN:
        return NetworkCapability.notVpn;
      case jni.NetworkCapabilities.NET_CAPABILITY_VALIDATED:
        return NetworkCapability.validated;
      case jni.NetworkCapabilities.NET_CAPABILITY_CAPTIVE_PORTAL:
        return NetworkCapability.captivePortal;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_ROAMING:
        return NetworkCapability.notRoaming;
      case jni.NetworkCapabilities.NET_CAPABILITY_FOREGROUND:
        return NetworkCapability.foreground;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_CONGESTED:
        return NetworkCapability.notCongested;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_SUSPENDED:
        return NetworkCapability.notSuspended;
      case jni.NetworkCapabilities.NET_CAPABILITY_MCX:
        return NetworkCapability.mcx;
      case jni.NetworkCapabilities.NET_CAPABILITY_TEMPORARILY_NOT_METERED:
        return NetworkCapability.temporarilyNotMetered;
      case jni.NetworkCapabilities.NET_CAPABILITY_ENTERPRISE:
        return NetworkCapability.enterprise;
      case jni.NetworkCapabilities.NET_CAPABILITY_HEAD_UNIT:
        return NetworkCapability.headUnit;
      case jni.NetworkCapabilities.NET_CAPABILITY_MMTEL:
        return NetworkCapability.mmtel;
      case jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_LATENCY:
        return NetworkCapability.prioritizeLatency;
      case jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_BANDWIDTH:
        return NetworkCapability.prioritizeBandwidth;
      case jni.NetworkCapabilities.NET_CAPABILITY_LOCAL_NETWORK:
        return NetworkCapability.localNetwork;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_BANDWIDTH_CONSTRAINED:
        return NetworkCapability.notBandwidthConstrained;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }

  TransportType get transportTypeImpl {
    switch (this) {
      case jni.NetworkCapabilities.TRANSPORT_CELLULAR:
        return TransportType.cellular;
      case jni.NetworkCapabilities.TRANSPORT_WIFI:
        return TransportType.wifi;
      case jni.NetworkCapabilities.TRANSPORT_BLUETOOTH:
        return TransportType.bluetooth;
      case jni.NetworkCapabilities.TRANSPORT_ETHERNET:
        return TransportType.ethernet;
      case jni.NetworkCapabilities.TRANSPORT_VPN:
        return TransportType.vpn;
      case jni.NetworkCapabilities.TRANSPORT_WIFI_AWARE:
        return TransportType.wifiAware;
      case jni.NetworkCapabilities.TRANSPORT_LOWPAN:
        return TransportType.lowpan;
      case jni.NetworkCapabilities.TRANSPORT_USB:
        return TransportType.usb;
      case jni.NetworkCapabilities.TRANSPORT_THREAD:
        return TransportType.thread;
      case jni.NetworkCapabilities.TRANSPORT_SATELLITE:
        return TransportType.satellite;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }

  RouteType get routeTypeImpl {
    switch (this) {
      case jni.RouteInfo.RTN_UNICAST:
        return RouteType.rtnUnicast;
      case jni.RouteInfo.RTN_UNREACHABLE:
        return RouteType.rtnUnreachable;
      case jni.RouteInfo.RTN_THROW:
        return RouteType.rtnThrow;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }

  RestrictBackgroundStatus get restrictBackgroundStatusImpl {
    switch (this) {
      case jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_DISABLED:
        return RestrictBackgroundStatus.disabled;
      case jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_WHITELISTED:
        return RestrictBackgroundStatus.whitelisted;
      case jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_ENABLED:
        return RestrictBackgroundStatus.enabled;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }
}

extension on jni.JInteger {
  int get impl => intValue();
}

extension on Uint8List {
  jni.JByteArray get api => toJByteBuffer().array;
}

extension on jni.JByteArray {
  Uint8List get impl => jni.JByteBuffer.wrap(this).asUint8List();
}

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

extension on NetworkCapability {
  int get api {
    switch (this) {
      case NetworkCapability.mms:
        return jni.NetworkCapabilities.NET_CAPABILITY_MMS;
      case NetworkCapability.supl:
        return jni.NetworkCapabilities.NET_CAPABILITY_SUPL;
      case NetworkCapability.dun:
        return jni.NetworkCapabilities.NET_CAPABILITY_DUN;
      case NetworkCapability.fota:
        return jni.NetworkCapabilities.NET_CAPABILITY_FOTA;
      case NetworkCapability.ims:
        return jni.NetworkCapabilities.NET_CAPABILITY_IMS;
      case NetworkCapability.cbs:
        return jni.NetworkCapabilities.NET_CAPABILITY_CBS;
      case NetworkCapability.wifiP2p:
        return jni.NetworkCapabilities.NET_CAPABILITY_WIFI_P2P;
      case NetworkCapability.ia:
        return jni.NetworkCapabilities.NET_CAPABILITY_IA;
      case NetworkCapability.rcs:
        return jni.NetworkCapabilities.NET_CAPABILITY_RCS;
      case NetworkCapability.xcap:
        return jni.NetworkCapabilities.NET_CAPABILITY_XCAP;
      case NetworkCapability.eims:
        return jni.NetworkCapabilities.NET_CAPABILITY_EIMS;
      case NetworkCapability.notMetered:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_METERED;
      case NetworkCapability.internet:
        return jni.NetworkCapabilities.NET_CAPABILITY_INTERNET;
      case NetworkCapability.notRestricted:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED;
      case NetworkCapability.trusted:
        return jni.NetworkCapabilities.NET_CAPABILITY_TRUSTED;
      case NetworkCapability.notVpn:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_VPN;
      case NetworkCapability.validated:
        return jni.NetworkCapabilities.NET_CAPABILITY_VALIDATED;
      case NetworkCapability.captivePortal:
        return jni.NetworkCapabilities.NET_CAPABILITY_CAPTIVE_PORTAL;
      case NetworkCapability.notRoaming:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_ROAMING;
      case NetworkCapability.foreground:
        return jni.NetworkCapabilities.NET_CAPABILITY_FOREGROUND;
      case NetworkCapability.notCongested:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_CONGESTED;
      case NetworkCapability.notSuspended:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_SUSPENDED;
      case NetworkCapability.mcx:
        return jni.NetworkCapabilities.NET_CAPABILITY_MCX;
      case NetworkCapability.temporarilyNotMetered:
        return jni.NetworkCapabilities.NET_CAPABILITY_TEMPORARILY_NOT_METERED;
      case NetworkCapability.enterprise:
        return jni.NetworkCapabilities.NET_CAPABILITY_ENTERPRISE;
      case NetworkCapability.headUnit:
        return jni.NetworkCapabilities.NET_CAPABILITY_HEAD_UNIT;
      case NetworkCapability.mmtel:
        return jni.NetworkCapabilities.NET_CAPABILITY_MMTEL;
      case NetworkCapability.prioritizeLatency:
        return jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_LATENCY;
      case NetworkCapability.prioritizeBandwidth:
        return jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_BANDWIDTH;
      case NetworkCapability.localNetwork:
        return jni.NetworkCapabilities.NET_CAPABILITY_LOCAL_NETWORK;
      case NetworkCapability.notBandwidthConstrained:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_BANDWIDTH_CONSTRAINED;
    }
  }
}

extension on TransportType {
  int get api {
    switch (this) {
      case TransportType.cellular:
        return jni.NetworkCapabilities.TRANSPORT_CELLULAR;
      case TransportType.wifi:
        return jni.NetworkCapabilities.TRANSPORT_WIFI;
      case TransportType.bluetooth:
        return jni.NetworkCapabilities.TRANSPORT_BLUETOOTH;
      case TransportType.ethernet:
        return jni.NetworkCapabilities.TRANSPORT_ETHERNET;
      case TransportType.vpn:
        return jni.NetworkCapabilities.TRANSPORT_VPN;
      case TransportType.wifiAware:
        return jni.NetworkCapabilities.TRANSPORT_WIFI_AWARE;
      case TransportType.lowpan:
        return jni.NetworkCapabilities.TRANSPORT_LOWPAN;
      case TransportType.usb:
        return jni.NetworkCapabilities.TRANSPORT_USB;
      case TransportType.thread:
        return jni.NetworkCapabilities.TRANSPORT_THREAD;
      case TransportType.satellite:
        return jni.NetworkCapabilities.TRANSPORT_SATELLITE;
    }
  }
}

extension on RouteType {
  int get api {
    switch (this) {
      case RouteType.rtnUnicast:
        return jni.RouteInfo.RTN_UNICAST;
      case RouteType.rtnUnreachable:
        return jni.RouteInfo.RTN_UNREACHABLE;
      case RouteType.rtnThrow:
        return jni.RouteInfo.RTN_THROW;
    }
  }
}

extension on RestrictBackgroundStatus {
  int get api {
    switch (this) {
      case RestrictBackgroundStatus.disabled:
        return jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_DISABLED;
      case RestrictBackgroundStatus.whitelisted:
        return jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_WHITELISTED;
      case RestrictBackgroundStatus.enabled:
        return jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_ENABLED;
    }
  }
}

extension on ConnectivityManager {
  jni.ConnectivityManager get api {
    final impl = this;
    if (impl is! ConnectivityManagerImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.ConnectivityManager {
  ConnectivityManager get impl => ConnectivityManagerImpl.internal(this);
}

extension on ConnectivityManagerNetworkCallback {
  jni.ConnectivityManager$NetworkCallback get api {
    final impl = this;
    if (impl is! ConnectivityManagerNetworkCallbackImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.ConnectivityManager$NetworkCallback {
  ConnectivityManagerNetworkCallback get impl =>
      ConnectivityManagerNetworkCallbackImpl.internal(this);
}

extension on ConnectivityManagerOnNetworkActiveListener {
  jni.ConnectivityManager$OnNetworkActiveListener get api {
    final impl = this;
    if (impl is! ConnectivityManagerOnNetworkActiveListenerImpl) {
      throw TypeError();
    }
    return impl.api;
  }
}

extension on jni.ConnectivityManager$OnNetworkActiveListener {
  ConnectivityManagerOnNetworkActiveListener get impl =>
      ConnectivityManagerOnNetworkActiveListenerImpl.internal(this);
}

extension on Network {
  jni.Network get api {
    final impl = this;
    if (impl is! NetworkImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.Network {
  Network get impl => NetworkImpl.internal(this);
}

extension on NetworkInfo {
  jni.NetworkInfo get api {
    final impl = this;
    if (impl is! NetworkInfoImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.NetworkInfo {
  NetworkInfo get impl => NetworkInfoImpl.internal(this);
}

extension on NetworkRequest {
  jni.NetworkRequest get api {
    final impl = this;
    if (impl is! NetworkRequestImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.NetworkRequest {
  NetworkRequest get impl => NetworkRequestImpl.internal(this);
}

extension on NetworkCapabilities {
  jni.NetworkCapabilities get api {
    final impl = this;
    if (impl is! NetworkCapabilitiesImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.NetworkCapabilities {
  NetworkCapabilities get impl => NetworkCapabilitiesImpl.internal(this);
}

extension on NetworkSpecifier {
  jni.NetworkSpecifier get api {
    final impl = this;
    if (impl is! NetworkSpecifierImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.NetworkSpecifier {
  NetworkSpecifier get impl => NetworkSpecifierImpl.internal(this);
}

extension on LinkProperties {
  jni.LinkProperties get api {
    final impl = this;
    if (impl is! LinkPropertiesImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.LinkProperties {
  LinkProperties get impl => LinkPropertiesImpl.internal(this);
}

extension on LinkAddress {
  jni.LinkAddress get api {
    final impl = this;
    if (impl is! LinkAddressImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.LinkAddress {
  LinkAddress get impl => LinkAddressImpl.internal(this);
}

extension on IpPrefix {
  jni.IpPrefix get api {
    final impl = this;
    if (impl is! IpPrefixImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.IpPrefix {
  IpPrefix get impl => IpPrefixImpl.internal(this);
}

extension on SocketKeepalive {
  jni.SocketKeepalive get api {
    final impl = this;
    if (impl is! SocketKeepaliveImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.SocketKeepalive {
  SocketKeepalive get impl => SocketKeepaliveImpl.internal(this);
}

extension on SocketKeepaliveCallback {
  jni.SocketKeepalive$Callback get api {
    final impl = this;
    if (impl is! SocketKeepaliveCallbackImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.SocketKeepalive$Callback {
  SocketKeepaliveCallback get impl =>
      SocketKeepaliveCallbackImpl.internal(this);
}

extension on IpSecManagerUdpEncapsulationSocket {
  jni.IpSecManager$UdpEncapsulationSocket get api {
    final impl = this;
    if (impl is! IpSecManagerUdpEncapsulationSocketImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.IpSecManager$UdpEncapsulationSocket {
  IpSecManagerUdpEncapsulationSocket get impl =>
      IpSecManagerUdpEncapsulationSocketImpl.internal(this);
}

extension on ProxyInfo {
  jni.ProxyInfo get api {
    final impl = this;
    if (impl is! ProxyInfoImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.ProxyInfo {
  ProxyInfo get impl => ProxyInfoImpl.internal(this);
}

extension on TransportInfo {
  jni.TransportInfo get api {
    final impl = this;
    if (impl is! TransportInfoImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.TransportInfo {
  TransportInfo get impl => TransportInfoImpl.internal(this);
}

extension on RouteInfo {
  jni.RouteInfo get api {
    final impl = this;
    if (impl is! RouteInfoImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.RouteInfo {
  RouteInfo get impl => RouteInfoImpl.internal(this);
}

extension on InetAddresses {
  jni.InetAddresses get api {
    final impl = this;
    if (impl is! InetAddressesImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.InetAddresses {
  InetAddresses get impl => InetAddressesImpl.internal(this);
}

extension on FileDescriptor {
  jni.FileDescriptor get api {
    final impl = this;
    if (impl is! FileDescriptorImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.FileDescriptor {
  FileDescriptor get impl => FileDescriptorImpl.internal(this);
}

extension on InetAddress {
  jni.InetAddress get api {
    final impl = this;
    if (impl is! InetAddressImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.InetAddress {
  InetAddress get impl {
    final api = this;
    if (api is jni.Inet4Address) {
      return Inet4AddressImpl.internal(api);
    } else if (api is jni.Inet6Address) {
      return Inet6AddressImpl.internal(api);
    } else {
      throw TypeError();
    }
  }
}

extension on Inet4Address {
  jni.Inet4Address get api {
    final impl = this;
    if (impl is! Inet4AddressImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.Inet4Address {
  Inet4Address get impl => Inet4AddressImpl.internal(this);
}

extension on Inet6Address {
  jni.Inet6Address get api {
    final impl = this;
    if (impl is! Inet6AddressImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.Inet6Address {
  Inet6Address get impl => Inet6AddressImpl.internal(this);
}

extension on InetSocketAddress {
  jni.InetSocketAddress get api {
    final impl = this;
    if (impl is! InetSocketAddressImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.InetSocketAddress {
  InetSocketAddress get impl => InetSocketAddressImpl.internal(this);
}

extension on NetworkInterface {
  jni.NetworkInterface get api {
    final impl = this;
    if (impl is! NetworkInterfaceImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.NetworkInterface {
  NetworkInterface get impl => NetworkInterfaceImpl.internal(this);
}

extension on Socket {
  jni.Socket get api {
    final impl = this;
    if (impl is! SocketImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.Socket {
  Socket get impl => SocketImpl.internal(this);
}

extension on DatagramSocket {
  jni.DatagramSocket get api {
    final impl = this;
    if (impl is! DatagramSocketImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.DatagramSocket {
  DatagramSocket get impl => DatagramSocketImpl.internal(this);
}

extension on Url {
  jni.URL get api {
    final impl = this;
    if (impl is! UrlImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.URL {
  Url get impl => UrlImpl.internal(this);
}

extension on UrlConnection {
  jni.URLConnection get api {
    final impl = this;
    if (impl is! UrlConnectionImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.URLConnection {
  UrlConnection get impl => UrlConnectionImpl.internal(this);
}

extension on SocketFactory {
  jni.SocketFactory get api {
    final impl = this;
    if (impl is! SocketFactoryImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.SocketFactory {
  SocketFactory get impl => SocketFactoryImpl.internal(this);
}

extension on Proxy {
  jni.Proxy get api {
    final impl = this;
    if (impl is! ProxyImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.Proxy {
  Proxy get impl => ProxyImpl.internal(this);
}
