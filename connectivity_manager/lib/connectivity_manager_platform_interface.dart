import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'connectivity_manager_method_channel.dart';

abstract class ConnectivityManagerPlatform extends PlatformInterface {
  /// Constructs a ConnectivityManagerPlatform.
  ConnectivityManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static ConnectivityManagerPlatform _instance = MethodChannelConnectivityManager();

  /// The default instance of [ConnectivityManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelConnectivityManager].
  static ConnectivityManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ConnectivityManagerPlatform] when
  /// they register themselves.
  static set instance(ConnectivityManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
