import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'connectivity_manager_platform_interface.dart';

/// An implementation of [ConnectivityManagerPlatform] that uses method channels.
class MethodChannelConnectivityManager extends ConnectivityManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('connectivity_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
