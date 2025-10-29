import 'dart:typed_data';

import 'connectivity_manager_api.dart';

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

abstract interface class ConnectivityManager {
  static Future<Network?> getProcessDefaultNetwork() =>
      ConnectivityManagerApi.getProcessDefaultNetwork();
  static Future<bool> isNetworkTypeValid(NetworkType networkType) =>
      ConnectivityManagerApi.isNetworkTypeValid(networkType);
  static Future<bool> setProcessDefaultNetwork(Network network) =>
      ConnectivityManagerApi.setProcessDefaultNetwork(network);

  factory ConnectivityManager() => ConnectivityManagerApi.instance;

  Future<void> addDefaultNetworkActiveListener(
    ConnectivityManagerOnNetworkActiveListener listener,
  );
  Future<void> removeDefaultNetworkActiveListener(
    ConnectivityManagerOnNetworkActiveListener listener,
  );

  Future<void> registerBestMatchingNetworkCallback(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  );
  Future<void> registerDefaultNetworkCallback(
    ConnectivityManagerNetworkCallback networkCallback,
  );
  Future<void> registerNetworkCallback(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  );
  Future<void> unregisterNetworkCallback(
    ConnectivityManagerNetworkCallback networkCallback,
  );

  Future<bool> bindProcessToNetwork(Network network);
  Future<SocketKeepalive> createSocketKeepalive(
    Network network,
    IpSecManagerUdpEncapsulationSocket socket,
    InetAddress source,
    InetAddress destination,
    SocketKeepaliveCallback callback,
  );
  Future<Network?> getActiveNetwork();
  Future<NetworkInfo?> getActiveNetworkInfo();
  Future<List<NetworkInfo>> getAllNetworkInfo();
  Future<List<Network>> getAllNetworks();
  Future<bool> getBackgroundDataSetting();
  Future<Network?> getBoundNetworkForProcess();
  Future<int> getConnectionOwnerUid(
    int protocol,
    InetSocketAddress local,
    InetSocketAddress remote,
  );
  Future<ProxyInfo?> getDefaultProxy();
  Future<LinkProperties?> getLinkProperties(Network network);
  Future<int> getMultipathPreference(Network network);
  Future<NetworkCapabilities?> getNetworkCapabilities(Network network);
  Future<NetworkInfo?> getNetworkInfo1(NetworkType networkType);
  Future<NetworkInfo?> getNetworkInfo2(Network network);
  Future<int> getNetworkPreference();
  Future<Uint8List?> getNetworkWatchlistConfigHash();
  Future<RestrictBackgroundStatus> getRestrictBackgroundStatus();
  Future<bool> isActiveNetworkMetered();
  Future<bool> isDefaultNetworkActive();
  Future<void> reportBadNetwork(Network network);
  Future<void> reportNetworkConnectivity(Network network, bool hasConnectivity);
  Future<bool> requestBandwidthUpdate(Network network);
  Future<void> requestNetwork(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback, [
    int? timeoutMs,
  ]);
  Future<void> reserveNetwork(
    NetworkRequest request,
    ConnectivityManagerNetworkCallback networkCallback,
  );
  Future<void> setNetworkPreference(int preference);
}

abstract interface class ConnectivityManagerNetworkCallback {
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
  }) => ConnectivityManagerNetworkCallbackApi(
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
}

abstract interface class ConnectivityManagerOnNetworkActiveListener {
  factory ConnectivityManagerOnNetworkActiveListener({
    required void Function() onNetworkActive,
  }) => ConnectivityManagerOnNetworkActiveListenerApi(
    onNetworkActive: onNetworkActive,
  );
}

abstract interface class Network {
  static Future<Network> fromNetworkHandle(int networkHandle) =>
      NetworkApi.fromNetworkHandle(networkHandle);

  Future<void> bindSocket1(Socket socket);
  Future<void> bindSocket2(DatagramSocket socket);
  Future<void> bindSocket3(FileDescriptor fd);
  Future<List<InetAddress>> getAllByName(String host);
  Future<InetAddress> getByName(String host);
  Future<int> getNetworkHandle();
  Future<SocketFactory> getSocketFatory();
  Future<UrlConnection> openConnection(Url url, [Proxy? proxy]);
}

abstract interface class NetworkInfo {}

abstract interface class NetworkRequest {
  Future<bool> canBeSatisfiedBy(NetworkCapabilities nc);
  Future<List<NetworkCapability>> getCapabilities();
  Future<NetworkSpecifier?> getNetworkSpecifier();
  Future<List<int>> getSubscriptionIds();
  Future<List<TransportType>> getTransportTypes();
  Future<bool> hasCapability(NetworkCapability capability);
  Future<bool> hasTransport(TransportType transportType);

  factory NetworkRequest({
    List<NetworkCapability>? capabilities,
    List<TransportType>? transportTypes,
    bool? includeOtherUidNetworks,
    NetworkSpecifier? networkSpecifier,
    List<int>? subIds,
  }) => NetworkRequestApi(
    capabilities: capabilities,
    transportTypes: transportTypes,
    includeOtherUidNetworks: includeOtherUidNetworks,
    networkSpecifier: networkSpecifier,
    subIds: subIds,
  );
}

abstract interface class NetworkCapabilities {
  Future<List<NetworkCapability>> getCapabilities();
  Future<List<int>> getEnterpriseIds();
  Future<int> getLinkDownstreamBandwidthKbps();
  Future<int> getLinkUpstreamBandwidthKbps();
  Future<NetworkSpecifier?> getNetworkSpecifier();
  Future<int> getOwnerUid();
  Future<int> getSignalStrength();
  Future<List<int>> getSubscriptionIds();
  Future<TransportInfo?> getTransportInfo();
  Future<bool> hasCapability(NetworkCapability capability);
  Future<bool> hasEnterpriseId(int enterpriseId);
  Future<bool> hasTransport(TransportType transportType);
}

abstract interface class NetworkSpecifier {}

abstract interface class LinkProperties {
  Future<bool> addRoute(RouteInfo route);
  Future<void> clear();
  Future<Inet4Address?> getDhcpServerAddress();
  Future<List<InetAddress>> getDnsServers();
  Future<String?> getDomains();
  Future<ProxyInfo?> getHttpProxy();
  Future<String?> getInterfaceName();
  Future<List<LinkAddress>> getLinkAddresses();
  Future<int> getMtu();
  Future<IpPrefix?> getNat64Prefix();
  Future<String?> getPrivateDnsServerName();
  Future<List<RouteInfo>> getRoutes();
  Future<bool> isPrivateDnsActive();
  Future<bool> isWakeOnLanSupported();
  Future<void> setDhcpServerAddress(Inet4Address? serverAddress);
  Future<void> setDnsServers(List<InetAddress> dnsServers);
  Future<void> setDomains(String? domains);
  Future<void> setHttpProxy(ProxyInfo? proxy);
  Future<void> setInterfaceName(String? iface);
  Future<void> setLinkAddresses(List<LinkAddress> addresses);
  Future<void> setMtu(int mtu);
  Future<void> setNat64Prefix(IpPrefix? prefix);
}

abstract interface class LinkAddress {
  Future<InetAddress> getAddress();
  Future<int> getFlags();
  Future<int> getPrefixLength();
  Future<int> getScope();
}

abstract interface class IpPrefix {
  Future<bool> contains(InetAddress address);
  Future<InetAddress> getAddress();
  Future<int> getPrefixLength();
  Future<Uint8List> getRawAddress();
}

abstract interface class SocketKeepalive {}

abstract interface class SocketKeepaliveCallback {}

abstract interface class IpSecManagerUdpEncapsulationSocket {}

abstract interface class ProxyInfo {}

abstract interface class TransportInfo {}

abstract interface class RouteInfo {
  Future<IpPrefix> getDestination();
  Future<InetAddress?> getGateway();
  Future<String?> getInterface();
  Future<RouteType> getType();
  Future<bool> hasGateway();
  Future<bool> isDefaultRoute();
  Future<bool> matches(InetAddress destination);
}

abstract interface class InetAddresses {
  static Future<bool> isNumericAddress(String address) =>
      InetAddressesApi.isNumericAddress(address);
  static Future<InetAddress> parseNumericAddress(String address) =>
      InetAddressesApi.parseNumericAddress(address);
}

abstract interface class FileDescriptor {}

abstract interface class InetAddress {
  static Future<List<InetAddress>> getAllByName(String? host) =>
      InetAddressApi.getAllByName(host);
  static Future<InetAddress> getByAddress1(Uint8List addr) =>
      InetAddressApi.getByAddress1(addr);
  static Future<InetAddress> getByAddress2(String? host, Uint8List addr) =>
      InetAddressApi.getByAddress2(host, addr);
  static Future<InetAddress> getByName(String? host) =>
      InetAddressApi.getByName(host);
  static Future<InetAddress> getLocalHost() => InetAddressApi.getLocalHost();
  static Future<InetAddress> getLoopbackAddress() =>
      InetAddressApi.getLoopbackAddress();

  Future<Uint8List> getAddress();
  Future<String> getCanonicalHostName();
  Future<String?> getHostAddress();
  Future<String> getHostName();
  Future<bool> isAnyLocalAddress();
  Future<bool> isLinkLocalAddress();
  Future<bool> isLoopbackAddress();
  Future<bool> isMcGlobal();
  Future<bool> isMcLinkLocal();
  Future<bool> isMcNodeLocal();
  Future<bool> isMcOrgLocal();
  Future<bool> isMcSiteLocal();
  Future<bool> isMulticastAddress();
  Future<bool> isReachable1(int timeout);
  Future<bool> isReachable2(NetworkInterface? netif, int ttl, int timetout);
  Future<bool> isSiteLocalAddress();
}

abstract interface class Inet4Address implements InetAddress {}

abstract interface class Inet6Address implements InetAddress {
  static Future<Inet6Address> getByAddress3(
    String host,
    Uint8List addr,
    NetworkInterface nif,
  ) => Inet6AddressApi.getByAddress3(host, addr, nif);
  static Future<Inet6Address> getByAddress4(
    String host,
    Uint8List addr,
    int scopeId,
  ) => Inet6AddressApi.getByAddress4(host, addr, scopeId);

  Future<bool> isIPv4CompatibleAddress();
}

abstract interface class InetSocketAddress {}

abstract interface class NetworkInterface {}

abstract interface class Socket {}

abstract interface class DatagramSocket {}

abstract interface class Url {}

abstract interface class UrlConnection {}

abstract interface class SocketFactory {}

abstract interface class Proxy {}
