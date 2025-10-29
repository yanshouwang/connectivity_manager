package dev.zeekr.connectivity_manager

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** ConnectivityManagerPlugin */
class ConnectivityManagerPlugin : FlutterPlugin {
    lateinit var registrar: ConnectivityManagerApiPigeonProxyApiRegistrar

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val binaryMessenger = binding.binaryMessenger
        val context = binding.applicationContext
        this.registrar = ConnectivityManagerRegistrarImpl(binaryMessenger, context)
        this.registrar.setUp()
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.registrar.tearDown()
        this.registrar.instanceManager.stopFinalizationListener()
    }
}
