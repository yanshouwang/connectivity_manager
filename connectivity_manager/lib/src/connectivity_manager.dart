import 'dart:typed_data';

import 'connectivity_manager_impl.dart';

enum ConnectivityManagerType {
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

enum ConnectivityManagerRestrictBackgroundStatus {
  disabled,
  whitelisted,
  enabled,
}

enum NetworkCapabilitiesNetCapability {
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

enum NetworkCapabilitiesTransport {
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

enum RouteInfoRTN { rtnUnicast, rtnUnreachable, rtnThrow }

enum WifiInfoSecurityType {
  unknown, // -1
  open, // 0
  wep, // 1
  psk, // 2
  eap, // 3
  sae, // 4
  eapWpa3Enterprise192Bit, //
  owe, // 6
  wapiPsk, // 7
  wapiCert, // 8
  eapWpa3Enterprise, // 9
  osen, // 10
  passpointR1R2, // 11
  passpointR3, // 12
  dpp, // 13
}

enum SupplicantState {
  associated,
  associating,
  authenticating,
  completed,
  disconnected,
  dormant,
  fourWayHandshake,
  groupHandshake,
  inactive,
  interfaceDisabled,
  invalid,
  scanning,
  uninitialized;

  static bool isValidState(SupplicantState state) =>
      SupplicantStateImpl.isValidState(state);
}

abstract base class ConnectivityManager {
  static Network? getProcessDefaultNetwork() =>
      ConnectivityManagerImpl.getProcessDefaultNetwork();
  static bool isNetworkTypeValid(ConnectivityManagerType networkType) =>
      ConnectivityManagerImpl.isNetworkTypeValid(networkType);
  static bool setProcessDefaultNetwork(Network network) =>
      ConnectivityManagerImpl.setProcessDefaultNetwork(network);

  ConnectivityManager.impl();

  factory ConnectivityManager() => ConnectivityManagerImpl();

  Network? get activeNetwork;
  NetworkInfo? get activeNetworkInfo;
  List<NetworkInfo> get allNetworkInfo;
  List<Network> get allNetworks;
  bool get backgroundDataSetting;
  Network? get boundNetworkForProcess;
  ProxyInfo? get defaultProxy;
  int get networkPreference;
  set networkPreference(int preference);
  Uint8List? get networkWatchlistConfigHash;
  ConnectivityManagerRestrictBackgroundStatus get restrictBackgroundStatus;
  bool get isActiveNetworkMetered;
  bool get isDefaultNetworkActive;

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
  int getConnectionOwnerUid(
    int protocol,
    InetSocketAddress local,
    InetSocketAddress remote,
  );
  LinkProperties? getLinkProperties(Network network);
  int getMultipathPreference(Network network);
  NetworkCapabilities? getNetworkCapabilities(Network network);
  NetworkInfo? getNetworkInfoOfType(ConnectivityManagerType networkType);
  NetworkInfo? getNetworkInfoOfNetwork(Network network);
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
  Network.impl();

  factory Network.fromNetworkHandle(int networkHandle) =>
      NetworkImpl.fromNetworkHandle(networkHandle);

  int get networkHandle;
  SocketFactory get socketFactory;

  void bindSocket(Socket socket);
  void bindDatagramSocket(DatagramSocket socket);
  void bindFileDescriptor(FileDescriptor fd);
  List<InetAddress> getAllByName(String host);
  InetAddress getByName(String host);
  UrlConnection openConnection(Url url, [Proxy? proxy]);
}

abstract base class NetworkInfo {
  NetworkInfo.impl();
}

abstract base class NetworkInfoDetailedState {
  NetworkInfoDetailedState.impl();
}

abstract base class NetworkRequest {
  factory NetworkRequest({
    List<NetworkCapabilitiesNetCapability>? capabilities,
    List<NetworkCapabilitiesTransport>? transportTypes,
    bool? includeOtherUidNetworks,
    NetworkSpecifier? networkSpecifier,
    Set<int>? subIds,
  }) => NetworkRequestImpl(
    capabilities: capabilities,
    transportTypes: transportTypes,
    includeOtherUidNetworks: includeOtherUidNetworks,
    networkSpecifier: networkSpecifier,
    subIds: subIds,
  );

  NetworkRequest.impl();

  List<NetworkCapabilitiesNetCapability> get capabilities;
  NetworkSpecifier? get networkSpecifier;
  Set<int> get subscriptionIds;
  List<NetworkCapabilitiesTransport> get transportTypes;

  bool canBeSatisfiedBy(NetworkCapabilities nc);
  bool hasCapability(NetworkCapabilitiesNetCapability capability);
  bool hasTransport(NetworkCapabilitiesTransport transportType);
}

abstract base class NetworkCapabilities {
  NetworkCapabilities.impl();

  List<NetworkCapabilitiesNetCapability> get capabilities;
  List<int> get enterpriseIds;
  int get linkDownstreamBandwidthKbps;
  int get linkUpstreamBandwidthKbps;
  NetworkSpecifier? get networkSpecifier;
  int get ownerUid;
  int get signalStrength;
  Set<int> get subscriptionIds;
  TransportInfo? get transportInfo;
  bool hasCapability(NetworkCapabilitiesNetCapability capability);
  bool hasEnterpriseId(int enterpriseId);
  bool hasTransport(NetworkCapabilitiesTransport transportType);
}

abstract base class NetworkSpecifier {
  NetworkSpecifier.impl();
}

abstract base class LinkProperties {
  LinkProperties.impl();

  Inet4Address? get dhcpServerAddress;
  set dhcpServerAddress(Inet4Address? serverAddress);
  List<InetAddress> get dnsServers;
  set dnsServers(List<InetAddress> dnsServers);
  String? get domains;
  set domains(String? domains);
  ProxyInfo? get httpProxy;
  set httpProxy(ProxyInfo? proxy);
  String? get interfaceName;
  set interfaceName(String? iface);
  List<LinkAddress> get linkAddresses;
  set linkAddresses(List<LinkAddress> addresses);
  int get mtu;
  set mtu(int mtu);
  IpPrefix? get nat64Prefix;
  set nat64Prefix(IpPrefix? prefix);
  String? get privateDnsServerName;
  List<RouteInfo> get routes;
  bool get isPrivateDnsActive;
  bool get isWakeOnLanSupported;

  bool addRoute(RouteInfo route);
  void clear();
}

abstract base class LinkAddress {
  LinkAddress.impl();

  InetAddress get address;
  int get flags;
  int get prefixLength;
  int get scope;
}

abstract base class IpPrefix {
  IpPrefix.impl();

  InetAddress get address;
  int get prefixLength;
  Uint8List get rawAddress;

  bool contains(InetAddress address);
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

abstract base class WifiInfo extends TransportInfo {
  static NetworkInfoDetailedState getDetailedStateOf(
    SupplicantState suppState,
  ) => WifiInfoImpl.getDetailedStateOf(suppState);

  WifiInfo.impl() : super.impl();

  List<MloLink> get affiliatedMloLinks;
  MacAddress? get apMldMacAddress;
  int get apMloLinkId;
  int get applicableRedactions;
  List<MloLink> get associatedMloLinks;
  String get bssid;
  WifiInfoSecurityType get currentSecurityType;
  int get frequency;
  bool get hiddenSSID;
  List<ScanResultInformationElement>? get informationElements;
  int get ipAddress;
  int get linkSpeed;
  String get macAddress;
  int get maxSupportedRxLinkSpeedMbps;
  int get maxSupportedTxLinkSpeedMbps;
  int get networkId;
  String? get passpointFqdn;
  String? get passpointProviderFriendlyName;
  String? get passpointUniqueId;
  int get rssi;
  int get rxLinkSpeedMbps;
  String get ssid;
  int get subscriptionId;
  SupplicantState get supplicantState;
  int get txLinkSpeedMbps;
  int get wifiStandard;
  bool get isRestricted;
  WifiInfo makeCopy(int redactions);
}

abstract base class MacAddress {
  MacAddress.impl();
}

abstract base class MloLink {
  MloLink.impl();
}

abstract base class ScanResultInformationElement {
  ScanResultInformationElement.impl();
}

abstract base class WifiAwareNetworkInfo extends TransportInfo {
  WifiAwareNetworkInfo.impl() : super.impl();
}

abstract base class RouteInfo {
  RouteInfo.impl();

  IpPrefix get destination;
  InetAddress? get gateway;
  String? get interface;
  RouteInfoRTN get type;
  bool get isDefaultRoute;

  bool hasGateway();
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
  static List<InetAddress> getAll(String? host) =>
      InetAddressImpl.getAllByName(host);

  factory InetAddress.byName(String? host) => InetAddressImpl.getByName(host);

  factory InetAddress.byAddress(Uint8List addr) =>
      InetAddressImpl.getByAddress(addr);

  factory InetAddress.byNameAddress(String? host, Uint8List addr) =>
      InetAddressImpl.getByNameAddress(host, addr);

  factory InetAddress.local() => InetAddressImpl.getLocalHost();

  factory InetAddress.loopback() => InetAddressImpl.getLoopbackAddress();

  InetAddress.impl();

  Uint8List get address;
  String get canonicalHostName;
  String? get hostAddress;
  String get hostName;
  bool get isAnyLocalAddress;
  bool get isLinkLocalAddress;
  bool get isLoopbackAddress;
  bool get isMCGlobal;
  bool get isMCLinkLocal;
  bool get isMCNodeLocal;
  bool get isMCOrgLocal;
  bool get isMCSiteLocal;
  bool get isMulticastAddress;
  bool get isSiteLocalAddress;

  bool isReachable(int timeout);
  bool isReachableWithNetwork(NetworkInterface? netif, int ttl, int timetout);
}

abstract base class Inet4Address extends InetAddress {
  Inet4Address.impl() : super.impl();
}

abstract base class Inet6Address extends InetAddress {
  factory Inet6Address.byNameAddressNetwork(
    String host,
    Uint8List addr,
    NetworkInterface nif,
  ) => Inet6AddressImpl.getByNameAddressNetwork(host, addr, nif);

  factory Inet6Address.byNameAddressScopeId(
    String host,
    Uint8List addr,
    int scopeId,
  ) => Inet6AddressImpl.getByNameAddressScopeId(host, addr, scopeId);

  Inet6Address.impl() : super.impl();

  bool get isIPv4CompatibleAddress;
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
