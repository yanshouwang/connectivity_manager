import 'dart:typed_data';

import 'connectivity_manager.dart';
import 'jni.dart' as jni;

final class ConnectivityManagerImpl extends ConnectivityManager {
  static Network? getProcessDefaultNetwork() =>
      jni.ConnectivityManager.getProcessDefaultNetwork()?.impl;

  static bool isNetworkTypeValid(ConnectivityManagerType networkType) =>
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
  Network? get activeNetwork => api.getActiveNetwork()?.impl;

  @override
  NetworkInfo? get activeNetworkInfo => api.getActiveNetworkInfo()?.impl;

  @override
  List<NetworkInfo> get allNetworkInfo =>
      api.getAllNetworkInfo().nonNulls.map((e) => e.impl).toList();

  @override
  List<Network> get allNetworks =>
      api.getAllNetworks().nonNulls.map((e) => e.impl).toList();

  @override
  bool get backgroundDataSetting => api.getBackgroundDataSetting();

  @override
  Network? get boundNetworkForProcess => api.getBoundNetworkForProcess()?.impl;

  @override
  ProxyInfo? get defaultProxy => api.getDefaultProxy()?.impl;

  @override
  int get networkPreference => api.getNetworkPreference();

  @override
  set networkPreference(int preference) => api.setNetworkPreference(preference);

  @override
  Uint8List? get networkWatchlistConfigHash =>
      api.getNetworkWatchlistConfigHash()?.impl;

  @override
  ConnectivityManagerRestrictBackgroundStatus get restrictBackgroundStatus =>
      api
          .getRestrictBackgroundStatus()
          .connectivityManagerRestrictBackgroundStatusImpl;

  @override
  bool get isActiveNetworkMetered => api.isActiveNetworkMetered();

  @override
  bool get isDefaultNetworkActive => api.isDefaultNetworkActive();

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
  int getConnectionOwnerUid(
    int protocol,
    InetSocketAddress local,
    InetSocketAddress remote,
  ) => api.getConnectionOwnerUid(protocol, local.api, remote.api);

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
  NetworkInfo? getNetworkInfoOfType(ConnectivityManagerType networkType) =>
      api.getNetworkInfo$1(networkType.api)?.impl;

  @override
  NetworkInfo? getNetworkInfoOfNetwork(Network network) =>
      api.getNetworkInfo(network.api)?.impl;

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
  ) => api.registerNetworkCallback$1(request.api, networkCallback.api);

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
  void unregisterNetworkCallback(
    ConnectivityManagerNetworkCallback networkCallback,
  ) => api.unregisterNetworkCallback$1(networkCallback.api);
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
  static Network fromNetworkHandle(int networkHandle) =>
      jni.Network.fromNetworkHandle(networkHandle)!.impl;

  final jni.Network api;

  NetworkImpl.internal(this.api) : super.impl();

  @override
  int get networkHandle => api.getNetworkHandle();

  @override
  SocketFactory get socketFactory => api.getSocketFactory()!.impl;

  @override
  void bindSocket(Socket socket) => api.bindSocket$2(socket.api);

  @override
  void bindDatagramSocket(DatagramSocket socket) =>
      api.bindSocket$1(socket.api);

  @override
  void bindFileDescriptor(FileDescriptor fd) => api.bindSocket(fd.api);

  @override
  List<InetAddress> getAllByName(String host) =>
      api.getAllByName(host.api)!.nonNulls.map((e) => e.impl).toList();

  @override
  InetAddress getByName(String host) => api.getByName(host.api)!.impl;

  @override
  UrlConnection openConnection(Url url, [Proxy? proxy]) => proxy == null
      ? api.openConnection(url.api)!.impl
      : api.openConnection$1(url.api, proxy.api)!.impl;
}

final class NetworkInfoImpl extends NetworkInfo {
  final jni.NetworkInfo api;

  NetworkInfoImpl.internal(this.api) : super.impl();
}

final class NetworkInfoDetailedStateImpl extends NetworkInfoDetailedState {
  final jni.NetworkInfo$DetailedState api;

  NetworkInfoDetailedStateImpl.internal(this.api) : super.impl();
}

final class NetworkRequestImpl extends NetworkRequest {
  final jni.NetworkRequest api;

  NetworkRequestImpl.internal(this.api) : super.impl();

  factory NetworkRequestImpl({
    List<NetworkCapabilitiesNetCapability>? capabilities,
    List<NetworkCapabilitiesTransport>? transportTypes,
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
  List<NetworkCapabilitiesNetCapability> get capabilities => api
      .getCapabilities()
      .map((e) => e.networkCapabilitiesNetCapabilityImpl)
      .toList();
  @override
  NetworkSpecifier? get networkSpecifier => api.getNetworkSpecifier()?.impl;
  @override
  Set<int> get subscriptionIds =>
      api.getSubscriptionIds().nonNulls.map((e) => e.impl).toSet();
  @override
  List<NetworkCapabilitiesTransport> get transportTypes => api
      .getTransportTypes()
      .map((e) => e.networkCapabilitiesTransportImpl)
      .toList();

  @override
  bool canBeSatisfiedBy(NetworkCapabilities nc) => api.canBeSatisfiedBy(nc.api);

  @override
  bool hasCapability(NetworkCapabilitiesNetCapability capability) =>
      api.hasCapability(capability.api);

  @override
  bool hasTransport(NetworkCapabilitiesTransport transportType) =>
      api.hasTransport(transportType.api);
}

final class NetworkCapabilitiesImpl extends NetworkCapabilities {
  final jni.NetworkCapabilities api;

  NetworkCapabilitiesImpl.internal(this.api) : super.impl();

  @override
  List<NetworkCapabilitiesNetCapability> get capabilities => api
      .getCapabilities()
      .map((e) => e.networkCapabilitiesNetCapabilityImpl)
      .toList();

  @override
  List<int> get enterpriseIds => api.getEnterpriseIds().toList();

  @override
  int get linkDownstreamBandwidthKbps => api.getLinkDownstreamBandwidthKbps();

  @override
  int get linkUpstreamBandwidthKbps => api.getLinkUpstreamBandwidthKbps();

  @override
  NetworkSpecifier? get networkSpecifier => api.getNetworkSpecifier()?.impl;

  @override
  int get ownerUid => api.getOwnerUid();

  @override
  int get signalStrength => api.getSignalStrength();

  @override
  Set<int> get subscriptionIds =>
      api.getSubscriptionIds().nonNulls.map((e) => e.impl).toSet();

  @override
  TransportInfo? get transportInfo => api.getTransportInfo()?.impl;

  @override
  bool hasCapability(NetworkCapabilitiesNetCapability capability) =>
      api.hasCapability(capability.api);

  @override
  bool hasEnterpriseId(int enterpriseId) => api.hasEnterpriseId(enterpriseId);

  @override
  bool hasTransport(NetworkCapabilitiesTransport transportType) =>
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
  Inet4Address? get dhcpServerAddress => api.getDhcpServerAddress()?.impl;
  @override
  set dhcpServerAddress(Inet4Address? serverAddress) =>
      api.setDhcpServerAddress(serverAddress?.api);

  @override
  List<InetAddress> get dnsServers =>
      api.getDnsServers().nonNulls.map((e) => e.impl).toList();
  @override
  set dnsServers(List<InetAddress> dnsServers) => api.setDnsServers(
    dnsServers
        .map((e) => e.api)
        .toJList(jni.InetAddress.type)
        .as(jni.Collection.type(jni.InetAddress.type)),
  );

  @override
  String? get domains => api.getDomains()?.impl;
  @override
  set domains(String? domains) => api.setDomains(domains?.api);

  @override
  ProxyInfo? get httpProxy => api.getHttpProxy()?.impl;
  @override
  set httpProxy(ProxyInfo? proxy) => api.setHttpProxy(proxy?.api);

  @override
  String? get interfaceName => api.getInterfaceName()?.impl;
  @override
  set interfaceName(String? iface) => api.setInterfaceName(iface?.api);

  @override
  List<LinkAddress> get linkAddresses =>
      api.getLinkAddresses().nonNulls.map((e) => e.impl).toList();
  @override
  set linkAddresses(List<LinkAddress> addresses) => api.setLinkAddresses(
    addresses
        .map((e) => e.api)
        .toJList(jni.LinkAddress.type)
        .as(jni.Collection.type(jni.LinkAddress.type)),
  );

  @override
  int get mtu => api.getMtu();
  @override
  set mtu(int mtu) => api.setMtu(mtu);

  @override
  IpPrefix? get nat64Prefix => api.getNat64Prefix()?.impl;
  @override
  set nat64Prefix(IpPrefix? prefix) => api.setNat64Prefix(prefix?.api);

  @override
  String? get privateDnsServerName => api.getPrivateDnsServerName()?.impl;

  @override
  List<RouteInfo> get routes =>
      api.getRoutes().nonNulls.map((e) => e.impl).toList();

  @override
  bool get isPrivateDnsActive => api.isPrivateDnsActive();

  @override
  bool get isWakeOnLanSupported => api.isWakeOnLanSupported();

  @override
  bool addRoute(RouteInfo route) => api.addRoute(route.api);

  @override
  void clear() => api.clear();
}

final class LinkAddressImpl extends LinkAddress {
  final jni.LinkAddress api;

  LinkAddressImpl.internal(this.api) : super.impl();

  @override
  InetAddress get address => api.getAddress()!.impl;

  @override
  int get flags => api.getFlags();

  @override
  int get prefixLength => api.getPrefixLength();

  @override
  int get scope => api.getScope();
}

final class IpPrefixImpl extends IpPrefix {
  final jni.IpPrefix api;

  IpPrefixImpl.internal(this.api) : super.impl();

  @override
  InetAddress get address => api.getAddress().impl;

  @override
  int get prefixLength => api.getPrefixLength();

  @override
  Uint8List get rawAddress => api.getRawAddress().impl;

  @override
  bool contains(InetAddress address) => api.contains(address.api);
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

base mixin TransportInfoImpl on TransportInfo {
  // jni.TransportInfo get api;
  jni.JObject get api;
}

final class WifiInfoImpl extends WifiInfo with TransportInfoImpl {
  static NetworkInfoDetailedState getDetailedStateOf(
    SupplicantState suppState,
  ) => jni.WifiInfo.getDetailedStateOf(suppState.api)!.impl;

  @override
  final jni.WifiInfo api;

  WifiInfoImpl.internal(this.api) : super.impl();

  @override
  List<MloLink> get affiliatedMloLinks =>
      api.getAffiliatedMloLinks().nonNulls.map((e) => e.impl).toList();

  @override
  MacAddress? get apMldMacAddress => api.getApMldMacAddress()?.impl;

  @override
  int get apMloLinkId => api.getApMloLinkId();

  @override
  int get applicableRedactions => api.getApplicableRedactions();

  @override
  List<MloLink> get associatedMloLinks =>
      api.getAssociatedMloLinks().nonNulls.map((e) => e.impl).toList();

  @override
  String get bssid => api.getBSSID()!.impl;

  @override
  WifiInfoSecurityType get currentSecurityType =>
      api.getCurrentSecurityType().wifiInfoSecurityTypeImpl;

  @override
  int get frequency => api.getFrequency();

  @override
  bool get hiddenSSID => api.getHiddenSSID();

  @override
  List<ScanResultInformationElement>? get informationElements =>
      api.getInformationElements()?.nonNulls.map((e) => e.impl).toList();

  @override
  int get ipAddress => api.getIpAddress();

  @override
  bool get isRestricted => api.isRestricted();

  @override
  int get linkSpeed => api.getLinkSpeed();

  @override
  String get macAddress => api.getMacAddress()!.impl;

  @override
  WifiInfo makeCopy(int redactions) => api.makeCopy(redactions).impl;

  @override
  int get maxSupportedRxLinkSpeedMbps => api.getMaxSupportedRxLinkSpeedMbps();

  @override
  int get maxSupportedTxLinkSpeedMbps => api.getMaxSupportedTxLinkSpeedMbps();

  @override
  int get networkId => api.getNetworkId();

  @override
  String? get passpointFqdn => api.getPasspointFqdn()?.impl;

  @override
  String? get passpointProviderFriendlyName =>
      api.getPasspointProviderFriendlyName()?.impl;

  @override
  String? get passpointUniqueId => api.getPasspointUniqueId()?.impl;

  @override
  int get rssi => api.getRssi();

  @override
  int get rxLinkSpeedMbps => api.getRxLinkSpeedMbps();

  @override
  String get ssid => api.getSSID()!.impl;

  @override
  int get subscriptionId => api.getSubscriptionId();

  @override
  SupplicantState get supplicantState => api.getSupplicantState()!.impl;

  @override
  int get txLinkSpeedMbps => api.getTxLinkSpeedMbps();

  @override
  int get wifiStandard => api.getWifiStandard();
}

final class MacAddressImpl extends MacAddress {
  final jni.MacAddress api;

  MacAddressImpl.internal(this.api) : super.impl();
}

final class MloLinkImpl extends MloLink {
  final jni.MloLink api;

  MloLinkImpl.internal(this.api) : super.impl();
}

final class ScanResultInformationElementImpl
    extends ScanResultInformationElement {
  final jni.ScanResult$InformationElement api;

  ScanResultInformationElementImpl.internal(this.api) : super.impl();
}

final class SupplicantStateImpl {
  static bool isValidState(SupplicantState state) =>
      jni.SupplicantState.isValidState(state.api);
}

final class WifiAwareNetworkInfoImpl extends WifiAwareNetworkInfo
    with TransportInfoImpl {
  @override
  final jni.WifiAwareNetworkInfo api;

  WifiAwareNetworkInfoImpl.internal(this.api) : super.impl();
}

final class RouteInfoImpl extends RouteInfo {
  final jni.RouteInfo api;

  RouteInfoImpl.internal(this.api) : super.impl();

  @override
  IpPrefix get destination => api.getDestination().impl;

  @override
  InetAddress? get gateway => api.getGateway()?.impl;

  @override
  String? get interface => api.getInterface()?.impl;

  @override
  RouteInfoRTN get type => api.getType().routeInfoRTNImpl;

  @override
  bool get isDefaultRoute => api.isDefaultRoute();

  @override
  bool hasGateway() => api.hasGateway();

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
      jni.InetAddress.getAllByName(
        host?.api,
      )!.nonNulls.map((e) => e.impl).toList();

  static InetAddress getByAddress(Uint8List addr) =>
      jni.InetAddress.getByAddress(addr.api)!.impl;

  static InetAddress getByNameAddress(String? host, Uint8List addr) =>
      jni.InetAddress.getByAddress$1(host?.api, addr.api)!.impl;

  static InetAddress getByName(String? host) =>
      jni.InetAddress.getByName(host?.api)!.impl;

  static InetAddress getLocalHost() => jni.InetAddress.getLocalHost()!.impl;

  static InetAddress getLoopbackAddress() =>
      jni.InetAddress.getLoopbackAddress()!.impl;

  jni.InetAddress get api;

  @override
  Uint8List get address => api.getAddress()!.impl;

  @override
  String get canonicalHostName => api.getCanonicalHostName()!.impl;

  @override
  String? get hostAddress => api.getHostAddress()?.impl;

  @override
  String get hostName => api.getHostName()!.impl;

  @override
  bool get isAnyLocalAddress => api.isAnyLocalAddress();

  @override
  bool get isLinkLocalAddress => api.isLinkLocalAddress();

  @override
  bool get isLoopbackAddress => api.isLoopbackAddress();

  @override
  bool get isMCGlobal => api.isMCGlobal();

  @override
  bool get isMCLinkLocal => api.isMCLinkLocal();

  @override
  bool get isMCNodeLocal => api.isMCNodeLocal();

  @override
  bool get isMCOrgLocal => api.isMCOrgLocal();

  @override
  bool get isMCSiteLocal => api.isMCSiteLocal();

  @override
  bool get isMulticastAddress => api.isMulticastAddress();

  @override
  bool get isSiteLocalAddress => api.isSiteLocalAddress();

  @override
  bool isReachable(int timeout) => api.isReachable(timeout);

  @override
  bool isReachableWithNetwork(NetworkInterface? netif, int ttl, int timetout) =>
      api.isReachable$1(netif?.api, ttl, timetout);
}

final class Inet4AddressImpl extends Inet4Address with InetAddressImpl {
  @override
  final jni.Inet4Address api;

  Inet4AddressImpl.internal(this.api) : super.impl();
}

final class Inet6AddressImpl extends Inet6Address with InetAddressImpl {
  static Inet6Address getByNameAddressNetwork(
    String host,
    Uint8List addr,
    NetworkInterface nif,
  ) => jni.Inet6Address.getByAddress$3(host.api, addr.api, nif.api)!.impl;

  static Inet6Address getByNameAddressScopeId(
    String host,
    Uint8List addr,
    int scopeId,
  ) => jni.Inet6Address.getByAddress$2(host.api, addr.api, scopeId)!.impl;

  @override
  final jni.Inet6Address api;

  Inet6AddressImpl.internal(this.api) : super.impl();

  @override
  bool get isIPv4CompatibleAddress => api.isIPv4CompatibleAddress();
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

  ConnectivityManagerRestrictBackgroundStatus
  get connectivityManagerRestrictBackgroundStatusImpl {
    switch (this) {
      case jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_DISABLED:
        return ConnectivityManagerRestrictBackgroundStatus.disabled;
      case jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_WHITELISTED:
        return ConnectivityManagerRestrictBackgroundStatus.whitelisted;
      case jni.ConnectivityManager.RESTRICT_BACKGROUND_STATUS_ENABLED:
        return ConnectivityManagerRestrictBackgroundStatus.enabled;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }

  NetworkCapabilitiesNetCapability get networkCapabilitiesNetCapabilityImpl {
    switch (this) {
      case jni.NetworkCapabilities.NET_CAPABILITY_MMS:
        return NetworkCapabilitiesNetCapability.mms;
      case jni.NetworkCapabilities.NET_CAPABILITY_SUPL:
        return NetworkCapabilitiesNetCapability.supl;
      case jni.NetworkCapabilities.NET_CAPABILITY_DUN:
        return NetworkCapabilitiesNetCapability.dun;
      case jni.NetworkCapabilities.NET_CAPABILITY_FOTA:
        return NetworkCapabilitiesNetCapability.fota;
      case jni.NetworkCapabilities.NET_CAPABILITY_IMS:
        return NetworkCapabilitiesNetCapability.ims;
      case jni.NetworkCapabilities.NET_CAPABILITY_CBS:
        return NetworkCapabilitiesNetCapability.cbs;
      case jni.NetworkCapabilities.NET_CAPABILITY_WIFI_P2P:
        return NetworkCapabilitiesNetCapability.wifiP2p;
      case jni.NetworkCapabilities.NET_CAPABILITY_IA:
        return NetworkCapabilitiesNetCapability.ia;
      case jni.NetworkCapabilities.NET_CAPABILITY_RCS:
        return NetworkCapabilitiesNetCapability.rcs;
      case jni.NetworkCapabilities.NET_CAPABILITY_XCAP:
        return NetworkCapabilitiesNetCapability.xcap;
      case jni.NetworkCapabilities.NET_CAPABILITY_EIMS:
        return NetworkCapabilitiesNetCapability.eims;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_METERED:
        return NetworkCapabilitiesNetCapability.notMetered;
      case jni.NetworkCapabilities.NET_CAPABILITY_INTERNET:
        return NetworkCapabilitiesNetCapability.internet;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED:
        return NetworkCapabilitiesNetCapability.notRestricted;
      case jni.NetworkCapabilities.NET_CAPABILITY_TRUSTED:
        return NetworkCapabilitiesNetCapability.trusted;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_VPN:
        return NetworkCapabilitiesNetCapability.notVpn;
      case jni.NetworkCapabilities.NET_CAPABILITY_VALIDATED:
        return NetworkCapabilitiesNetCapability.validated;
      case jni.NetworkCapabilities.NET_CAPABILITY_CAPTIVE_PORTAL:
        return NetworkCapabilitiesNetCapability.captivePortal;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_ROAMING:
        return NetworkCapabilitiesNetCapability.notRoaming;
      case jni.NetworkCapabilities.NET_CAPABILITY_FOREGROUND:
        return NetworkCapabilitiesNetCapability.foreground;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_CONGESTED:
        return NetworkCapabilitiesNetCapability.notCongested;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_SUSPENDED:
        return NetworkCapabilitiesNetCapability.notSuspended;
      case jni.NetworkCapabilities.NET_CAPABILITY_MCX:
        return NetworkCapabilitiesNetCapability.mcx;
      case jni.NetworkCapabilities.NET_CAPABILITY_TEMPORARILY_NOT_METERED:
        return NetworkCapabilitiesNetCapability.temporarilyNotMetered;
      case jni.NetworkCapabilities.NET_CAPABILITY_ENTERPRISE:
        return NetworkCapabilitiesNetCapability.enterprise;
      case jni.NetworkCapabilities.NET_CAPABILITY_HEAD_UNIT:
        return NetworkCapabilitiesNetCapability.headUnit;
      case jni.NetworkCapabilities.NET_CAPABILITY_MMTEL:
        return NetworkCapabilitiesNetCapability.mmtel;
      case jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_LATENCY:
        return NetworkCapabilitiesNetCapability.prioritizeLatency;
      case jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_BANDWIDTH:
        return NetworkCapabilitiesNetCapability.prioritizeBandwidth;
      case jni.NetworkCapabilities.NET_CAPABILITY_LOCAL_NETWORK:
        return NetworkCapabilitiesNetCapability.localNetwork;
      case jni.NetworkCapabilities.NET_CAPABILITY_NOT_BANDWIDTH_CONSTRAINED:
        return NetworkCapabilitiesNetCapability.notBandwidthConstrained;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }

  NetworkCapabilitiesTransport get networkCapabilitiesTransportImpl {
    switch (this) {
      case jni.NetworkCapabilities.TRANSPORT_CELLULAR:
        return NetworkCapabilitiesTransport.cellular;
      case jni.NetworkCapabilities.TRANSPORT_WIFI:
        return NetworkCapabilitiesTransport.wifi;
      case jni.NetworkCapabilities.TRANSPORT_BLUETOOTH:
        return NetworkCapabilitiesTransport.bluetooth;
      case jni.NetworkCapabilities.TRANSPORT_ETHERNET:
        return NetworkCapabilitiesTransport.ethernet;
      case jni.NetworkCapabilities.TRANSPORT_VPN:
        return NetworkCapabilitiesTransport.vpn;
      case jni.NetworkCapabilities.TRANSPORT_WIFI_AWARE:
        return NetworkCapabilitiesTransport.wifiAware;
      case jni.NetworkCapabilities.TRANSPORT_LOWPAN:
        return NetworkCapabilitiesTransport.lowpan;
      case jni.NetworkCapabilities.TRANSPORT_USB:
        return NetworkCapabilitiesTransport.usb;
      case jni.NetworkCapabilities.TRANSPORT_THREAD:
        return NetworkCapabilitiesTransport.thread;
      case jni.NetworkCapabilities.TRANSPORT_SATELLITE:
        return NetworkCapabilitiesTransport.satellite;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }

  RouteInfoRTN get routeInfoRTNImpl {
    switch (this) {
      case jni.RouteInfo.RTN_UNICAST:
        return RouteInfoRTN.rtnUnicast;
      case jni.RouteInfo.RTN_UNREACHABLE:
        return RouteInfoRTN.rtnUnreachable;
      case jni.RouteInfo.RTN_THROW:
        return RouteInfoRTN.rtnThrow;
      default:
        throw UnimplementedError('Unimplemented value: $this');
    }
  }

  WifiInfoSecurityType get wifiInfoSecurityTypeImpl {
    switch (this) {
      case jni.WifiInfo.SECURITY_TYPE_UNKNOWN:
        return WifiInfoSecurityType.unknown;
      case jni.WifiInfo.SECURITY_TYPE_OPEN:
        return WifiInfoSecurityType.open;
      case jni.WifiInfo.SECURITY_TYPE_WEP:
        return WifiInfoSecurityType.wep;
      case jni.WifiInfo.SECURITY_TYPE_PSK:
        return WifiInfoSecurityType.psk;
      case jni.WifiInfo.SECURITY_TYPE_EAP:
        return WifiInfoSecurityType.eap;
      case jni.WifiInfo.SECURITY_TYPE_SAE:
        return WifiInfoSecurityType.sae;
      case jni.WifiInfo.SECURITY_TYPE_EAP_WPA3_ENTERPRISE_192_BIT:
        return WifiInfoSecurityType.eapWpa3Enterprise192Bit;
      case jni.WifiInfo.SECURITY_TYPE_OWE:
        return WifiInfoSecurityType.owe;
      case jni.WifiInfo.SECURITY_TYPE_WAPI_PSK:
        return WifiInfoSecurityType.wapiPsk;
      case jni.WifiInfo.SECURITY_TYPE_WAPI_CERT:
        return WifiInfoSecurityType.wapiCert;
      case jni.WifiInfo.SECURITY_TYPE_EAP_WPA3_ENTERPRISE:
        return WifiInfoSecurityType.eapWpa3Enterprise;
      case jni.WifiInfo.SECURITY_TYPE_OSEN:
        return WifiInfoSecurityType.osen;
      case jni.WifiInfo.SECURITY_TYPE_PASSPOINT_R1_R2:
        return WifiInfoSecurityType.passpointR1R2;
      case jni.WifiInfo.SECURITY_TYPE_PASSPOINT_R3:
        return WifiInfoSecurityType.passpointR3;
      case jni.WifiInfo.SECURITY_TYPE_DPP:
        return WifiInfoSecurityType.dpp;
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

extension on ConnectivityManagerType {
  int get api {
    switch (this) {
      case ConnectivityManagerType.mobile:
        return jni.ConnectivityManager.TYPE_MOBILE;
      case ConnectivityManagerType.wifi:
        return jni.ConnectivityManager.TYPE_WIFI;
      case ConnectivityManagerType.mobileMms:
        return jni.ConnectivityManager.TYPE_MOBILE_MMS;
      case ConnectivityManagerType.mobileSupl:
        return jni.ConnectivityManager.TYPE_MOBILE_SUPL;
      case ConnectivityManagerType.mobileDun:
        return jni.ConnectivityManager.TYPE_MOBILE_DUN;
      case ConnectivityManagerType.mobileHipri:
        return jni.ConnectivityManager.TYPE_MOBILE_HIPRI;
      case ConnectivityManagerType.wimax:
        return jni.ConnectivityManager.TYPE_WIMAX;
      case ConnectivityManagerType.bluetooth:
        return jni.ConnectivityManager.TYPE_BLUETOOTH;
      case ConnectivityManagerType.dummy:
        return jni.ConnectivityManager.TYPE_DUMMY;
      case ConnectivityManagerType.ethernet:
        return jni.ConnectivityManager.TYPE_ETHERNET;
      case ConnectivityManagerType.vpn:
        return jni.ConnectivityManager.TYPE_VPN;
    }
  }
}

extension on NetworkCapabilitiesNetCapability {
  int get api {
    switch (this) {
      case NetworkCapabilitiesNetCapability.mms:
        return jni.NetworkCapabilities.NET_CAPABILITY_MMS;
      case NetworkCapabilitiesNetCapability.supl:
        return jni.NetworkCapabilities.NET_CAPABILITY_SUPL;
      case NetworkCapabilitiesNetCapability.dun:
        return jni.NetworkCapabilities.NET_CAPABILITY_DUN;
      case NetworkCapabilitiesNetCapability.fota:
        return jni.NetworkCapabilities.NET_CAPABILITY_FOTA;
      case NetworkCapabilitiesNetCapability.ims:
        return jni.NetworkCapabilities.NET_CAPABILITY_IMS;
      case NetworkCapabilitiesNetCapability.cbs:
        return jni.NetworkCapabilities.NET_CAPABILITY_CBS;
      case NetworkCapabilitiesNetCapability.wifiP2p:
        return jni.NetworkCapabilities.NET_CAPABILITY_WIFI_P2P;
      case NetworkCapabilitiesNetCapability.ia:
        return jni.NetworkCapabilities.NET_CAPABILITY_IA;
      case NetworkCapabilitiesNetCapability.rcs:
        return jni.NetworkCapabilities.NET_CAPABILITY_RCS;
      case NetworkCapabilitiesNetCapability.xcap:
        return jni.NetworkCapabilities.NET_CAPABILITY_XCAP;
      case NetworkCapabilitiesNetCapability.eims:
        return jni.NetworkCapabilities.NET_CAPABILITY_EIMS;
      case NetworkCapabilitiesNetCapability.notMetered:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_METERED;
      case NetworkCapabilitiesNetCapability.internet:
        return jni.NetworkCapabilities.NET_CAPABILITY_INTERNET;
      case NetworkCapabilitiesNetCapability.notRestricted:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED;
      case NetworkCapabilitiesNetCapability.trusted:
        return jni.NetworkCapabilities.NET_CAPABILITY_TRUSTED;
      case NetworkCapabilitiesNetCapability.notVpn:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_VPN;
      case NetworkCapabilitiesNetCapability.validated:
        return jni.NetworkCapabilities.NET_CAPABILITY_VALIDATED;
      case NetworkCapabilitiesNetCapability.captivePortal:
        return jni.NetworkCapabilities.NET_CAPABILITY_CAPTIVE_PORTAL;
      case NetworkCapabilitiesNetCapability.notRoaming:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_ROAMING;
      case NetworkCapabilitiesNetCapability.foreground:
        return jni.NetworkCapabilities.NET_CAPABILITY_FOREGROUND;
      case NetworkCapabilitiesNetCapability.notCongested:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_CONGESTED;
      case NetworkCapabilitiesNetCapability.notSuspended:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_SUSPENDED;
      case NetworkCapabilitiesNetCapability.mcx:
        return jni.NetworkCapabilities.NET_CAPABILITY_MCX;
      case NetworkCapabilitiesNetCapability.temporarilyNotMetered:
        return jni.NetworkCapabilities.NET_CAPABILITY_TEMPORARILY_NOT_METERED;
      case NetworkCapabilitiesNetCapability.enterprise:
        return jni.NetworkCapabilities.NET_CAPABILITY_ENTERPRISE;
      case NetworkCapabilitiesNetCapability.headUnit:
        return jni.NetworkCapabilities.NET_CAPABILITY_HEAD_UNIT;
      case NetworkCapabilitiesNetCapability.mmtel:
        return jni.NetworkCapabilities.NET_CAPABILITY_MMTEL;
      case NetworkCapabilitiesNetCapability.prioritizeLatency:
        return jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_LATENCY;
      case NetworkCapabilitiesNetCapability.prioritizeBandwidth:
        return jni.NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_BANDWIDTH;
      case NetworkCapabilitiesNetCapability.localNetwork:
        return jni.NetworkCapabilities.NET_CAPABILITY_LOCAL_NETWORK;
      case NetworkCapabilitiesNetCapability.notBandwidthConstrained:
        return jni.NetworkCapabilities.NET_CAPABILITY_NOT_BANDWIDTH_CONSTRAINED;
    }
  }
}

extension on NetworkCapabilitiesTransport {
  int get api {
    switch (this) {
      case NetworkCapabilitiesTransport.cellular:
        return jni.NetworkCapabilities.TRANSPORT_CELLULAR;
      case NetworkCapabilitiesTransport.wifi:
        return jni.NetworkCapabilities.TRANSPORT_WIFI;
      case NetworkCapabilitiesTransport.bluetooth:
        return jni.NetworkCapabilities.TRANSPORT_BLUETOOTH;
      case NetworkCapabilitiesTransport.ethernet:
        return jni.NetworkCapabilities.TRANSPORT_ETHERNET;
      case NetworkCapabilitiesTransport.vpn:
        return jni.NetworkCapabilities.TRANSPORT_VPN;
      case NetworkCapabilitiesTransport.wifiAware:
        return jni.NetworkCapabilities.TRANSPORT_WIFI_AWARE;
      case NetworkCapabilitiesTransport.lowpan:
        return jni.NetworkCapabilities.TRANSPORT_LOWPAN;
      case NetworkCapabilitiesTransport.usb:
        return jni.NetworkCapabilities.TRANSPORT_USB;
      case NetworkCapabilitiesTransport.thread:
        return jni.NetworkCapabilities.TRANSPORT_THREAD;
      case NetworkCapabilitiesTransport.satellite:
        return jni.NetworkCapabilities.TRANSPORT_SATELLITE;
    }
  }
}

extension on SupplicantState {
  jni.SupplicantState get api {
    switch (this) {
      case SupplicantState.associated:
        return jni.SupplicantState.ASSOCIATED;
      case SupplicantState.associating:
        return jni.SupplicantState.ASSOCIATING;
      case SupplicantState.authenticating:
        return jni.SupplicantState.AUTHENTICATING;
      case SupplicantState.completed:
        return jni.SupplicantState.COMPLETED;
      case SupplicantState.disconnected:
        return jni.SupplicantState.DISCONNECTED;
      case SupplicantState.dormant:
        return jni.SupplicantState.DORMANT;
      case SupplicantState.fourWayHandshake:
        return jni.SupplicantState.FOUR_WAY_HANDSHAKE;
      case SupplicantState.groupHandshake:
        return jni.SupplicantState.GROUP_HANDSHAKE;
      case SupplicantState.inactive:
        return jni.SupplicantState.INACTIVE;
      case SupplicantState.interfaceDisabled:
        return jni.SupplicantState.INTERFACE_DISABLED;
      case SupplicantState.invalid:
        return jni.SupplicantState.INVALID;
      case SupplicantState.scanning:
        return jni.SupplicantState.SCANNING;
      case SupplicantState.uninitialized:
        return jni.SupplicantState.UNINITIALIZED;
    }
  }
}

extension on jni.SupplicantState {
  SupplicantState get impl {
    if (this == jni.SupplicantState.ASSOCIATED) {
      return SupplicantState.associated;
    }
    if (this == jni.SupplicantState.ASSOCIATING) {
      return SupplicantState.associating;
    }
    if (this == jni.SupplicantState.AUTHENTICATING) {
      return SupplicantState.authenticating;
    }
    if (this == jni.SupplicantState.COMPLETED) {
      return SupplicantState.completed;
    }
    if (this == jni.SupplicantState.DISCONNECTED) {
      return SupplicantState.disconnected;
    }
    if (this == jni.SupplicantState.DORMANT) {
      return SupplicantState.dormant;
    }
    if (this == jni.SupplicantState.FOUR_WAY_HANDSHAKE) {
      return SupplicantState.fourWayHandshake;
    }
    if (this == jni.SupplicantState.GROUP_HANDSHAKE) {
      return SupplicantState.groupHandshake;
    }
    if (this == jni.SupplicantState.INACTIVE) {
      return SupplicantState.inactive;
    }
    if (this == jni.SupplicantState.INTERFACE_DISABLED) {
      return SupplicantState.interfaceDisabled;
    }
    if (this == jni.SupplicantState.INVALID) {
      return SupplicantState.invalid;
    }
    if (this == jni.SupplicantState.SCANNING) {
      return SupplicantState.scanning;
    }
    if (this == jni.SupplicantState.UNINITIALIZED) {
      return SupplicantState.uninitialized;
    }
    throw UnimplementedError('Unimplemented value: $this');
  }
}

extension on ConnectivityManagerNetworkCallback {
  jni.ConnectivityManager$NetworkCallback get api {
    final impl = this;
    if (impl is! ConnectivityManagerNetworkCallbackImpl) throw TypeError();
    return impl.api;
  }
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

extension on jni.NetworkInfo {
  NetworkInfo get impl => NetworkInfoImpl.internal(this);
}

extension on jni.NetworkInfo$DetailedState {
  NetworkInfoDetailedState get impl =>
      NetworkInfoDetailedStateImpl.internal(this);
}

extension on NetworkRequest {
  jni.NetworkRequest get api {
    final impl = this;
    if (impl is! NetworkRequestImpl) throw TypeError();
    return impl.api;
  }
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

extension on IpSecManagerUdpEncapsulationSocket {
  jni.IpSecManager$UdpEncapsulationSocket get api {
    final impl = this;
    if (impl is! IpSecManagerUdpEncapsulationSocketImpl) throw TypeError();
    return impl.api;
  }
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

extension on jni.TransportInfo {
  TransportInfo get impl {
    final api = this;
    final isWifi = api.isInstanceOf(jni.WifiInfo.type.jClass);
    if (isWifi) {
      final apiWifi = api.as(jni.WifiInfo.type);
      return WifiInfoImpl.internal(apiWifi);
    }
    final isWifiAwareNetwork = api.isInstanceOf(
      jni.WifiAwareNetworkInfo.type.jClass,
    );
    if (isWifiAwareNetwork) {
      final apiWifiAwareNetwork = api.as(jni.WifiAwareNetworkInfo.type);
      return WifiAwareNetworkInfoImpl.internal(apiWifiAwareNetwork);
    }
    throw TypeError();
  }
}

extension on jni.WifiInfo {
  WifiInfo get impl => WifiInfoImpl.internal(this);
}

extension on jni.MacAddress {
  MacAddress get impl => MacAddressImpl.internal(this);
}

extension on jni.MloLink {
  MloLink get impl => MloLinkImpl.internal(this);
}

extension on jni.ScanResult$InformationElement {
  ScanResultInformationElement get impl =>
      ScanResultInformationElementImpl.internal(this);
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

extension on FileDescriptor {
  jni.FileDescriptor get api {
    final impl = this;
    if (impl is! FileDescriptorImpl) throw TypeError();
    return impl.api;
  }
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
    final isV4 = api.isInstanceOf(jni.Inet4Address.type.jClass);
    if (isV4) {
      final apiV4 = api.as(jni.Inet4Address.type);
      return Inet4AddressImpl.internal(apiV4);
    }
    final isV6 = api.isInstanceOf(jni.Inet6Address.type.jClass);
    if (isV6) {
      final apiV6 = api.as(jni.Inet6Address.type);
      return Inet6AddressImpl.internal(apiV6);
    }
    throw TypeError();
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

extension on NetworkInterface {
  jni.NetworkInterface get api {
    final impl = this;
    if (impl is! NetworkInterfaceImpl) throw TypeError();
    return impl.api;
  }
}

extension on Socket {
  jni.Socket get api {
    final impl = this;
    if (impl is! SocketImpl) throw TypeError();
    return impl.api;
  }
}

extension on DatagramSocket {
  jni.DatagramSocket get api {
    final impl = this;
    if (impl is! DatagramSocketImpl) throw TypeError();
    return impl.api;
  }
}

extension on Url {
  jni.URL get api {
    final impl = this;
    if (impl is! UrlImpl) throw TypeError();
    return impl.api;
  }
}

extension on jni.URLConnection {
  UrlConnection get impl => UrlConnectionImpl.internal(this);
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
