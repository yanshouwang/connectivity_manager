import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_manager/connectivity_manager.dart';
import 'package:connectivity_manager/connectivity_manager_platform_interface.dart';
import 'package:connectivity_manager/connectivity_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockConnectivityManagerPlatform
    with MockPlatformInterfaceMixin
    implements ConnectivityManagerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ConnectivityManagerPlatform initialPlatform = ConnectivityManagerPlatform.instance;

  test('$MethodChannelConnectivityManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelConnectivityManager>());
  });

  test('getPlatformVersion', () async {
    ConnectivityManager connectivityManagerPlugin = ConnectivityManager();
    MockConnectivityManagerPlatform fakePlatform = MockConnectivityManagerPlatform();
    ConnectivityManagerPlatform.instance = fakePlatform;

    expect(await connectivityManagerPlugin.getPlatformVersion(), '42');
  });
}
