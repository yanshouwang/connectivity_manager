import 'dart:typed_data';

import 'connectivity_manager_impl.dart';

enum NetworkType {
  mobile,
  wifi,
  mobileMms,
  mobileSupl,
  mobileDun,
  mobileHipri,
  wimax,
  bluetooth,
  dummy,
  ethernet,
  vpn,
}

enum NetworkCapability {
  mms,
  supl,
  dun,
  fota,
  ims,
  cbs,
  wifiP2p,
  ia,
  rcs,
  xcap,
  eims,
  notMetered,
  internet,
  notRestricted,
  trusted,
  notVpn,
  validated,
  captivePortal,
  notRoaming,
  foreground,
  notCongested,
  notSuspended,
  mcx,
  temporarilyNotMetered,
  enterprise,
  headUnit,
  mmtel,
  prioritizeLatency,
  prioritizeBandwidth,
  localNetwork,
  notBandwidthConstrained,
}

enum TransportType {
  cellular,
  wifi,
  bluetooth,
  ethernet,
  vpn,
  wifiAware,
  lowpan,
  usb,
  thread,
  satellite,
}

enum RouteType { unicast, unreachable, throws }

enum RestrictBackgroundStatus { disabled, whitelisted, enabled }

abstract base class ConnectivityManager {
  static Network? getProcessDefaultNetwork() =>
      ConnectivityManagerImpl.getProcessDefaultNetwork();
  static bool isNetworkTypeValid(NetworkType networkType) =>
      ConnectivityManagerImpl.isNetworkTypeValid(networkType);
  static bool setProcessDefaultNetwork(Network network) =>
      ConnectivityManagerImpl.setProcessDefaultNetwork(network);

  ConnectivityManager.impl();

  factory ConnectivityManager() => ConnectivityManagerImpl.instance;

  void addDefaultNetworkActiveListener(
    ConnectivityManagerOnNetworkActiveListener listener,
  );
  void removeDefaultNetworkActiveListener(
    ConnectivityManagerOnNetworkActiveListener listener,
  );

  void registerBestMatchingNetworkCallback(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  );
  void registerDefaultNetworkCallback(
    ConnectivityManagerNetworkCallback networkCallback,
  );
  void registerNetworkCallback(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  );
  void unregisterNetworkCallback(
    ConnectivityManagerNetworkCallback networkCallback,
  );

  bool bindProcessToNetwork(Network network);
  SocketKeepalive createSocketKeepalive(
    Network network,
    IpSecManagerUdpEncapsulationSocket socket,
    InetAddress source,
    InetAddress destination,
    SocketKeepaliveCallback callback,
  );
  Network? getActiveNetwork();
  NetworkInfo? getActiveNetworkInfo();
  List<NetworkInfo> getAllNetworkInfo();
  List<Network> getAllNetworks();
  bool getBackgroundDataSetting();
  Network? getBoundNetworkForProcess();
  int getConnectionOwnerUid(
    int protocol,
    InetSocketAddress local,
    InetSocketAddress remote,
  );
  ProxyInfo? getDefaultProxy();
  LinkProperties? getLinkProperties(Network network);
  int getMultipathPreference(Network network);
  NetworkCapabilities? getNetworkCapabilities(Network network);
  NetworkInfo? getNetworkInfo1(NetworkType networkType);
  NetworkInfo? getNetworkInfo2(Network network);
  int getNetworkPreference();
  Uint8List? getNetworkWatchlistConfigHash();
  RestrictBackgroundStatus getRestrictBackgroundStatus();
  bool isActiveNetworkMetered();
  bool isDefaultNetworkActive();
  void reportBadNetwork(Network network);
  void reportNetworkConnectivity(Network network, bool hasConnectivity);
  bool requestBandwidthUpdate(Network network);
  void requestNetwork(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback, [
    int? timeoutMs,
  ]);
  void reserveNetwork(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  );
  void setNetworkPreference(int preference);
}

abstract base class ConnectivityManagerNetworkCallback {
  factory ConnectivityManagerNetworkCallback({
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
  }) => ConnectivityManagerNetworkCallbackImpl(
    includeLocationInfo: includeLocationInfo,
    onAvailable: onAvailable,
    onBlockedStatusChanged: onBlockedStatusChanged,
    onCapabilitiesChanged: onCapabilitiesChanged,
    onLinkPropertiesChanged: onLinkPropertiesChanged,
    onLosing: onLosing,
    onLost: onLost,
    onReserved: onReserved,
    onUnavailable: onUnavailable,
  );

  ConnectivityManagerNetworkCallback.impl();
}

abstract base class ConnectivityManagerOnNetworkActiveListener {
  factory ConnectivityManagerOnNetworkActiveListener({
    required void Function() onNetworkActive,
  }) => ConnectivityManagerOnNetworkActiveListenerImpl(
    onNetworkActive: onNetworkActive,
  );

  ConnectivityManagerOnNetworkActiveListener.impl();
}

abstract base class Network {
  static Network fromNetworkHandle(int networkHandle) =>
      NetworkImpl.fromNetworkHandle(networkHandle);

  Network.impl();

  void bindSocket1(Socket socket);
  void bindSocket2(DatagramSocket socket);
  void bindSocket3(FileDescriptor fd);
  List<InetAddress> getAllByName(String host);
  InetAddress getByName(String host);
  int getNetworkHandle();
  SocketFactory getSocketFatory();
  UrlConnection openConnection(Url url, [Proxy? proxy]);
}

abstract base class NetworkInfo {
  NetworkInfo.impl();
}

abstract base class NetworkRequest {
  factory NetworkRequest({
    List<NetworkCapability>? capabilities,
    List<TransportType>? transportTypes,
    bool? includeOtherUidNetworks,
    NetworkSpecifier? networkSpecifier,
    List<int>? subIds,
  }) => NetworkRequestImpl(
    capabilities: capabilities,
    transportTypes: transportTypes,
    includeOtherUidNetworks: includeOtherUidNetworks,
    networkSpecifier: networkSpecifier,
    subIds: subIds,
  );

  NetworkRequest.impl();

  bool canBeSatisfiedBy(NetworkCapabilities nc);
  List<NetworkCapability> getCapabilities();
  NetworkSpecifier? getNetworkSpecifier();
  List<int> getSubscriptionIds();
  List<TransportType> getTransportTypes();
  bool hasCapability(NetworkCapability capability);
  bool hasTransport(TransportType transportType);
}

abstract base class NetworkCapabilities {
  NetworkCapabilities.impl();

  List<NetworkCapability> getCapabilities();
  List<int> getEnterpriseIds();
  int getLinkDownstreamBandwidthKbps();
  int getLinkUpstreamBandwidthKbps();
  NetworkSpecifier? getNetworkSpecifier();
  int getOwnerUid();
  int getSignalStrength();
  List<int> getSubscriptionIds();
  TransportInfo? getTransportInfo();
  bool hasCapability(NetworkCapability capability);
  bool hasEnterpriseId(int enterpriseId);
  bool hasTransport(TransportType transportType);
}

abstract base class NetworkSpecifier {
  NetworkSpecifier.impl();
}

abstract base class LinkProperties {
  LinkProperties.impl();

  bool addRoute(RouteInfo route);
  void clear();
  Inet4Address? getDhcpServerAddress();
  List<InetAddress> getDnsServers();
  String? getDomains();
  ProxyInfo? getHttpProxy();
  String? getInterfaceName();
  List<LinkAddress> getLinkAddresses();
  int getMtu();
  IpPrefix? getNat64Prefix();
  String? getPrivateDnsServerName();
  List<RouteInfo> getRoutes();
  bool isPrivateDnsActive();
  bool isWakeOnLanSupported();
  void setDhcpServerAddress(Inet4Address? serverAddress);
  void setDnsServers(List<InetAddress> dnsServers);
  void setDomains(String? domains);
  void setHttpProxy(ProxyInfo? proxy);
  void setInterfaceName(String? iface);
  void setLinkAddresses(List<LinkAddress> addresses);
  void setMtu(int mtu);
  void setNat64Prefix(IpPrefix? prefix);
}

abstract base class LinkAddress {
  LinkAddress.impl();

  InetAddress getAddress();
  int getFlags();
  int getPrefixLength();
  int getScope();
}

abstract base class IpPrefix {
  IpPrefix.impl();

  bool contains(InetAddress address);
  InetAddress getAddress();
  int getPrefixLength();
  Uint8List getRawAddress();
}

abstract base class SocketKeepalive {
  SocketKeepalive.impl();
}

abstract base class SocketKeepaliveCallback {
  SocketKeepaliveCallback.impl();
}

abstract base class IpSecManagerUdpEncapsulationSocket {
  IpSecManagerUdpEncapsulationSocket.impl();
}

abstract base class ProxyInfo {
  ProxyInfo.impl();
}

abstract base class TransportInfo {
  TransportInfo.impl();
}

abstract base class RouteInfo {
  RouteInfo.impl();

  IpPrefix getDestination();
  InetAddress? getGateway();
  String? getInterface();
  RouteType getType();
  bool hasGateway();
  bool isDefaultRoute();
  bool matches(InetAddress destination);
}

abstract base class InetAddresses {
  static bool isNumericAddress(String address) =>
      InetAddressesImpl.isNumericAddress(address);
  static InetAddress parseNumericAddress(String address) =>
      InetAddressesImpl.parseNumericAddress(address);

  InetAddresses.impl();
}

abstract base class FileDescriptor {
  FileDescriptor.impl();
}

abstract base class InetAddress {
  static List<InetAddress> getAllByName(String? host) =>
      InetAddressImpl.getAllByName(host);
  static InetAddress getByAddress1(Uint8List addr) =>
      InetAddressImpl.getByAddress1(addr);
  static InetAddress getByAddress2(String? host, Uint8List addr) =>
      InetAddressImpl.getByAddress2(host, addr);
  static InetAddress getByName(String? host) => InetAddressImpl.getByName(host);
  static InetAddress getLocalHost() => InetAddressImpl.getLocalHost();
  static InetAddress getLoopbackAddress() =>
      InetAddressImpl.getLoopbackAddress();

  InetAddress.impl();

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
  bool isReachable2(NetworkInterface? netif, int ttl, int timetout);
  bool isSiteLocalAddress();
}

abstract base class Inet4Address implements InetAddress {
  Inet4Address.impl();
}

abstract base class Inet6Address implements InetAddress {
  static Inet6Address getByAddress3(
    String host,
    Uint8List addr,
    NetworkInterface nif,
  ) => Inet6AddressImpl.getByAddress3(host, addr, nif);
  static Inet6Address getByAddress4(String host, Uint8List addr, int scopeId) =>
      Inet6AddressImpl.getByAddress4(host, addr, scopeId);

  Inet6Address.impl();

  bool isIPv4CompatibleAddress();
}

abstract base class InetSocketAddress {
  InetSocketAddress.impl();
}

abstract base class NetworkInterface {
  NetworkInterface.impl();
}

abstract base class Socket {
  Socket.impl();
}

abstract base class DatagramSocket {
  DatagramSocket.impl();
}

abstract base class Url {
  Url.impl();
}

abstract base class UrlConnection {
  UrlConnection.impl();
}

abstract base class SocketFactory {
  SocketFactory.impl();
}

abstract base class Proxy {
  Proxy.impl();
}
