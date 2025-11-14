import 'dart:io';

import 'package:jnigen/jnigen.dart';
import 'package:logging/logging.dart';

void main() {
  final root = Platform.script.resolve('../');
  final config = Config(
    outputConfig: OutputConfig(
      dartConfig: DartCodeOutputConfig(
        path: root.resolve('lib/src/jni/'),
        structure: OutputStructure.packageStructure,
      ),
    ),
    classes: [
      'android.content.Context',
      'android.net.ConnectivityManager',
      'android.net.Network',
      'android.net.NetworkInfo',
      'android.net.NetworkRequest',
      'android.net.NetworkCapabilities',
      'android.net.NetworkSpecifier',
      'android.net.LinkProperties',
      'android.net.LinkAddress',
      'android.net.IpPrefix',
      'android.net.SocketKeepalive',
      'android.net.IpSecManager',
      'android.net.ProxyInfo',
      'android.net.TransportInfo',
      'android.net.RouteInfo',
      'android.net.InetAddresses',
      'androidx.core.content.ContextCompat',
      'java.io.FileDescriptor',
      'java.net.InetAddress',
      'java.net.Inet4Address',
      'java.net.Inet6Address',
      'java.net.InetSocketAddress',
      'java.net.NetworkInterface',
      'java.net.Socket',
      'java.net.DatagramSocket',
      'java.net.URL',
      'java.net.URLConnection',
      'java.net.Proxy',
      'javax.net.SocketFactory',
    ],
    sourcePath: [root.resolve('android/src/main/kotlin/')],
    androidSdkConfig: AndroidSdkConfig(
      addGradleDeps: true,
      androidExample: 'example/',
    ),
    logLevel: Level.ALL,
  );
  generateJniBindings(config);
}
