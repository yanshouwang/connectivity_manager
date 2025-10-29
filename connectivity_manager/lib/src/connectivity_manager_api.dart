import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'connectivity_manager.dart';
import 'connectivity_manager_impl.dart';

abstract base class ConnectivityManagerApi extends PlatformInterface
    implements ConnectivityManager {
  static final Object _token = Object();

  static ConnectivityManagerApi _instance = ConnectivityManagerImpl();

  static ConnectivityManagerApi get instance => _instance;

  static set instance(ConnectivityManagerApi instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  static Future<Network?> getProcessDefaultNetwork() =>
      ConnectivityManagerImpl.getProcessDefaultNetwork();

  static Future<bool> isNetworkTypeValid(NetworkType networkType) =>
      ConnectivityManagerImpl.isNetworkTypeValid(networkType);

  static Future<bool> setProcessDefaultNetwork(Network network) =>
      ConnectivityManagerImpl.setProcessDefaultNetwork(network);

  ConnectivityManagerApi.impl() : super(token: _token);
}

abstract base class ConnectivityManagerNetworkCallbackApi
    extends PlatformInterface
    implements ConnectivityManagerNetworkCallback {
  static final _token = Object();

  ConnectivityManagerNetworkCallbackApi.impl() : super(token: _token);

  factory ConnectivityManagerNetworkCallbackApi({
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
}

abstract base class ConnectivityManagerOnNetworkActiveListenerApi
    extends PlatformInterface
    implements ConnectivityManagerOnNetworkActiveListener {
  static final _token = Object();

  ConnectivityManagerOnNetworkActiveListenerApi.impl() : super(token: _token);

  factory ConnectivityManagerOnNetworkActiveListenerApi({
    required void Function() onNetworkActive,
  }) => ConnectivityManagerOnNetworkActiveListenerImpl(
    onNetworkActive: onNetworkActive,
  );
}

abstract base class NetworkApi extends PlatformInterface implements Network {
  static final _token = Object();

  static Future<Network> fromNetworkHandle(int networkHandle) =>
      NetworkImpl.fromNetworkHandle(networkHandle);

  NetworkApi.impl() : super(token: _token);
}

abstract base class NetworkInfoApi extends PlatformInterface
    implements NetworkInfo {
  static final _token = Object();

  NetworkInfoApi.impl() : super(token: _token);
}

abstract base class NetworkRequestApi extends PlatformInterface
    implements NetworkRequest {
  static final _token = Object();

  NetworkRequestApi.impl() : super(token: _token);

  factory NetworkRequestApi({
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
}

abstract base class NetworkCapabilitiesApi extends PlatformInterface
    implements NetworkCapabilities {
  static final _token = Object();

  NetworkCapabilitiesApi.impl() : super(token: _token);
}

abstract base class NetworkSpecifierApi extends PlatformInterface
    implements NetworkSpecifier {
  static final _token = Object();

  NetworkSpecifierApi.impl() : super(token: _token);
}

abstract base class LinkPropertiesApi extends PlatformInterface
    implements LinkProperties {
  static final _token = Object();

  LinkPropertiesApi.impl() : super(token: _token);
}

abstract base class LinkAddressApi extends PlatformInterface
    implements LinkAddress {
  static final _token = Object();

  LinkAddressApi.impl() : super(token: _token);
}

abstract base class IpPrefixApi extends PlatformInterface implements IpPrefix {
  static final _token = Object();

  IpPrefixApi.impl() : super(token: _token);
}

abstract base class SocketKeepaliveApi extends PlatformInterface
    implements SocketKeepalive {
  static final _token = Object();

  SocketKeepaliveApi.impl() : super(token: _token);
}

abstract base class SocketKeepaliveCallbackApi extends PlatformInterface
    implements SocketKeepaliveCallback {
  static final _token = Object();

  SocketKeepaliveCallbackApi.impl() : super(token: _token);
}

abstract base class IpSecManagerUdpEncapsulationSocketApi
    extends PlatformInterface
    implements IpSecManagerUdpEncapsulationSocket {
  static final _token = Object();

  IpSecManagerUdpEncapsulationSocketApi.impl() : super(token: _token);
}

abstract base class ProxyInfoApi extends PlatformInterface
    implements ProxyInfo {
  static final _token = Object();

  ProxyInfoApi.impl() : super(token: _token);
}

abstract base class TransportInfoApi extends PlatformInterface
    implements TransportInfo {
  static final _token = Object();

  TransportInfoApi.impl() : super(token: _token);
}

abstract base class RouteInfoApi extends PlatformInterface
    implements RouteInfo {
  static final _token = Object();

  RouteInfoApi.impl() : super(token: _token);
}

abstract base class InetAddressesApi extends PlatformInterface
    implements InetAddresses {
  static final _token = Object();

  static Future<bool> isNumericAddress(String address) =>
      InetAddressesImpl.isNumericAddress(address);

  static Future<InetAddress> parseNumericAddress(String address) =>
      InetAddressesImpl.parseNumericAddress(address);

  InetAddressesApi.impl() : super(token: _token);
}

abstract base class FileDescriptorApi extends PlatformInterface
    implements FileDescriptor {
  static final _token = Object();

  FileDescriptorApi.impl() : super(token: _token);
}

abstract base class InetAddressApi extends PlatformInterface
    implements InetAddress {
  static final _token = Object();

  static Future<List<InetAddress>> getAllByName(String? host) =>
      InetAddressImpl.getAllByName(host);

  static Future<InetAddress> getByAddress1(Uint8List addr) =>
      InetAddressImpl.getByAddress1(addr);

  static Future<InetAddress> getByAddress2(String? host, Uint8List addr) =>
      InetAddressImpl.getByAddress2(host, addr);

  static Future<InetAddress> getByName(String? host) =>
      InetAddressImpl.getByName(host);

  static Future<InetAddress> getLocalHost() => InetAddressApi.getLocalHost();

  static Future<InetAddress> getLoopbackAddress() =>
      InetAddressImpl.getLoopbackAddress();

  InetAddressApi.impl() : super(token: _token);
}

abstract base class Inet4AddressApi extends PlatformInterface
    implements Inet4Address {
  static final _token = Object();

  Inet4AddressApi.impl() : super(token: _token);
}

abstract base class Inet6AddressApi extends PlatformInterface
    implements Inet6Address {
  static final _token = Object();

  static Future<Inet6Address> getByAddress3(
    String host,
    Uint8List addr,
    NetworkInterface nif,
  ) => Inet6AddressImpl.getByAddress3(host, addr, nif);

  static Future<Inet6Address> getByAddress4(
    String host,
    Uint8List addr,
    int scopeId,
  ) => Inet6AddressImpl.getByAddress4(host, addr, scopeId);

  Inet6AddressApi.impl() : super(token: _token);
}

abstract base class InetSocketAddressApi extends PlatformInterface
    implements InetSocketAddress {
  static final _token = Object();

  InetSocketAddressApi.impl() : super(token: _token);
}

abstract base class NetworkInterfaceApi extends PlatformInterface
    implements NetworkInterface {
  static final _token = Object();

  NetworkInterfaceApi.impl() : super(token: _token);
}

abstract base class SocketApi extends PlatformInterface implements Socket {
  static final _token = Object();

  SocketApi.impl() : super(token: _token);
}

abstract base class DatagramSocketApi extends PlatformInterface
    implements DatagramSocket {
  static final _token = Object();

  DatagramSocketApi.impl() : super(token: _token);
}

abstract base class UrlApi extends PlatformInterface implements Url {
  static final _token = Object();

  UrlApi.impl() : super(token: _token);
}

abstract base class UrlConnectionApi extends PlatformInterface
    implements UrlConnection {
  static final _token = Object();

  UrlConnectionApi.impl() : super(token: _token);
}

abstract base class SocketFactoryApi extends PlatformInterface
    implements SocketFactory {
  static final _token = Object();

  SocketFactoryApi.impl() : super(token: _token);
}

abstract base class ProxyApi extends PlatformInterface implements Proxy {
  static final _token = Object();

  ProxyApi.impl() : super(token: _token);
}
