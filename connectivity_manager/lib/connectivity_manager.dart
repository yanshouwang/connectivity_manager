
import 'connectivity_manager_platform_interface.dart';

class ConnectivityManager {
  Future<String?> getPlatformVersion() {
    return ConnectivityManagerPlatform.instance.getPlatformVersion();
  }
}
