package dev.zeekr.connectivity_manager

import android.Manifest
import android.content.Context
import android.net.ConnectivityManager
import android.net.IpSecManager
import android.net.LinkProperties
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkInfo
import android.net.NetworkRequest
import android.net.ProxyInfo
import android.net.SocketKeepalive
import android.os.Build
import android.os.Handler
import androidx.annotation.RequiresPermission
import androidx.core.content.ContextCompat
import java.net.InetAddress
import java.net.InetSocketAddress

class ConnectivityManagerImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar, val context: Context) :
    PigeonApiConnectivityManagerProxyApi(registrar) {
    class NetworkCallbackImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) :
        PigeonApiConnectivityManagerNetworkCallbackProxyApi(registrar) {
        override fun pigeon_defaultConstructor(): ConnectivityManager.NetworkCallback {
            return object : ConnectivityManager.NetworkCallback() {
                override fun onAvailable(network: Network) {
                    super.onAvailable(network)
                    this@NetworkCallbackImpl.onAvailable(this, network) {}
                }

                override fun onBlockedStatusChanged(network: Network, blocked: Boolean) {
                    super.onBlockedStatusChanged(network, blocked)
                    this@NetworkCallbackImpl.onBlockedStatusChanged(this, network, blocked) {}
                }

                override fun onCapabilitiesChanged(network: Network, networkCapabilities: NetworkCapabilities) {
                    super.onCapabilitiesChanged(network, networkCapabilities)
                    this@NetworkCallbackImpl.onCapabilitiesChanged(this, network, networkCapabilities) {}
                }

                override fun onLinkPropertiesChanged(network: Network, linkProperties: LinkProperties) {
                    super.onLinkPropertiesChanged(network, linkProperties)
                    this@NetworkCallbackImpl.onLinkPropertiesChanged(this, network, linkProperties) {}
                }

                override fun onLosing(network: Network, maxMsToLive: Int) {
                    super.onLosing(network, maxMsToLive)
                    this@NetworkCallbackImpl.onLosing(this, network, maxMsToLive.toLong()) {}
                }

                override fun onLost(network: Network) {
                    super.onLost(network)
                    this@NetworkCallbackImpl.onLost(this, network) {}
                }

                // TODO: Implement onReserved when targetSdk 36

                override fun onUnavailable() {
                    super.onUnavailable()
                    this@NetworkCallbackImpl.onUnavailable(this) {}
                }
            }
        }

        override fun flags(flags: List<ConnectivityManagerNetworkCallbackFlagApi>): ConnectivityManager.NetworkCallback {
            return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                object : ConnectivityManager.NetworkCallback(flags.map { it.impl }.reduce { acc, i -> acc or i }) {
                    override fun onAvailable(network: Network) {
                        super.onAvailable(network)
                        this@NetworkCallbackImpl.onAvailable(this, network) {}
                    }

                    override fun onBlockedStatusChanged(network: Network, blocked: Boolean) {
                        super.onBlockedStatusChanged(network, blocked)
                        this@NetworkCallbackImpl.onBlockedStatusChanged(this, network, blocked) {}
                    }

                    override fun onCapabilitiesChanged(network: Network, networkCapabilities: NetworkCapabilities) {
                        super.onCapabilitiesChanged(network, networkCapabilities)
                        this@NetworkCallbackImpl.onCapabilitiesChanged(this, network, networkCapabilities) {}
                    }

                    override fun onLinkPropertiesChanged(network: Network, linkProperties: LinkProperties) {
                        super.onLinkPropertiesChanged(network, linkProperties)
                        this@NetworkCallbackImpl.onLinkPropertiesChanged(this, network, linkProperties) {}
                    }

                    override fun onLosing(network: Network, maxMsToLive: Int) {
                        super.onLosing(network, maxMsToLive)
                        this@NetworkCallbackImpl.onLosing(this, network, maxMsToLive.toLong()) {}
                    }

                    override fun onLost(network: Network) {
                        super.onLost(network)
                        this@NetworkCallbackImpl.onLost(this, network) {}
                    }

                    // TODO: Implement onReserved when targetSdk 36

                    override fun onUnavailable() {
                        super.onUnavailable()
                        this@NetworkCallbackImpl.onUnavailable(this) {}
                    }
                }
            } else {
                throw UnsupportedOperationException("Call requires API level 31")
            }
        }
    }

    class OnNetworkActiveListenerImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) :
        PigeonApiConnectivityManagerOnNetworkActiveListenerProxyApi(registrar) {
        override fun pigeon_defaultConstructor(): ConnectivityManager.OnNetworkActiveListener {
            return object : ConnectivityManager.OnNetworkActiveListener {
                override fun onNetworkActive() {
                    this@OnNetworkActiveListenerImpl.onNetworkActive(this) {}
                }
            }
        }
    }

    override fun instance(): ConnectivityManager {
        return ContextCompat.getSystemService(context, ConnectivityManager::class.java)
            ?: throw NullPointerException("instance is null")
    }

    override fun addDefaultNetworkActiveListener(
        pigeon_instance: ConnectivityManager, listener: ConnectivityManager.OnNetworkActiveListener
    ) {
        pigeon_instance.addDefaultNetworkActiveListener(listener)
    }

    override fun removeDefaultNetworkActiveListener(
        pigeon_instance: ConnectivityManager, listener: ConnectivityManager.OnNetworkActiveListener
    ) {
        pigeon_instance.removeDefaultNetworkActiveListener(listener)
    }

    override fun registerBestMatchingNetworkCallback(
        pigeon_instance: ConnectivityManager,
        request: NetworkRequest,
        networkCallback: ConnectivityManager.NetworkCallback
    ) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val handler = context.mainHandler
            pigeon_instance.registerBestMatchingNetworkCallback(request, networkCallback, handler)
        } else {
            throw UnsupportedOperationException("Call requires API level 31")
        }
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun registerDefaultNetworkCallback(
        pigeon_instance: ConnectivityManager, networkCallback: ConnectivityManager.NetworkCallback
    ) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val handler = context.mainHandler
            pigeon_instance.registerDefaultNetworkCallback(networkCallback, handler)
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            pigeon_instance.registerDefaultNetworkCallback(networkCallback)
        } else {
            throw UnsupportedOperationException("Call requires API level 24")
        }
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun registerNetworkCallback(
        pigeon_instance: ConnectivityManager,
        request: NetworkRequest,
        networkCallback: ConnectivityManager.NetworkCallback
    ) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val handler = context.mainHandler
            pigeon_instance.registerNetworkCallback(request, networkCallback, handler)
        } else {
            pigeon_instance.registerNetworkCallback(request, networkCallback)
        }
    }

    override fun unregisterNetworkCallback(
        pigeon_instance: ConnectivityManager, networkCallback: ConnectivityManager.NetworkCallback
    ) {
        pigeon_instance.unregisterNetworkCallback(networkCallback)
    }

    override fun bindProcessToNetwork(pigeon_instance: ConnectivityManager, network: Network): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) pigeon_instance.bindProcessToNetwork(network)
        else throw UnsupportedOperationException("Call requires API level 23")

    }

    override fun createSocketKeepalive(
        pigeon_instance: ConnectivityManager,
        network: Network,
        socket: IpSecManager.UdpEncapsulationSocket,
        source: InetAddress,
        destination: InetAddress,
        callback: SocketKeepalive.Callback
    ): SocketKeepalive {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val executor = ContextCompat.getMainExecutor(context)
            pigeon_instance.createSocketKeepalive(network, socket, source, destination, executor, callback)
        } else {
            throw UnsupportedOperationException("Call requires API level 29")
        }
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun getActiveNetwork(pigeon_instance: ConnectivityManager): Network? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) pigeon_instance.activeNetwork
        else throw UnsupportedOperationException("Call requires API level 23")

    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun getActiveNetworkInfo(pigeon_instance: ConnectivityManager): NetworkInfo? {
        return pigeon_instance.activeNetworkInfo
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun getAllNetworkInfo(pigeon_instance: ConnectivityManager): List<NetworkInfo> {
        return pigeon_instance.allNetworkInfo.toList()
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun getAllNetworks(pigeon_instance: ConnectivityManager): List<Network> {
        return pigeon_instance.allNetworks.toList()
    }

    override fun getBackgroundDataSetting(pigeon_instance: ConnectivityManager): Boolean {
        return pigeon_instance.backgroundDataSetting
    }

    override fun getBoundNetworkForProcess(pigeon_instance: ConnectivityManager): Network? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) pigeon_instance.boundNetworkForProcess
        else throw UnsupportedOperationException("Call requires API level 23")
    }

    override fun getConnectionOwnerUid(
        pigeon_instance: ConnectivityManager, protocol: Long, local: InetSocketAddress, remote: InetSocketAddress
    ): Long {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            pigeon_instance.getConnectionOwnerUid(protocol.toInt(), local, remote).toLong()
        } else {
            throw UnsupportedOperationException("Call requires API level 29")
        }
    }

    override fun getDefaultProxy(pigeon_instance: ConnectivityManager): ProxyInfo? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) pigeon_instance.defaultProxy
        else throw UnsupportedOperationException("Call requires API level 23")

    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun getLinkProperties(pigeon_instance: ConnectivityManager, network: Network): LinkProperties? {
        return pigeon_instance.getLinkProperties(network)
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun getMultipathPreference(pigeon_instance: ConnectivityManager, network: Network): Long {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            pigeon_instance.getMultipathPreference(network).toLong()
        } else {
            throw UnsupportedOperationException("Call requires API level 26")
        }
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun getNetworkCapabilities(pigeon_instance: ConnectivityManager, network: Network): NetworkCapabilities? {
        return pigeon_instance.getNetworkCapabilities(network)
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun getNetworkInfo1(pigeon_instance: ConnectivityManager, networkType: NetworkTypeApi): NetworkInfo? {
        return pigeon_instance.getNetworkInfo(networkType.impl)
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun getNetworkInfo2(pigeon_instance: ConnectivityManager, network: Network): NetworkInfo? {
        return pigeon_instance.getNetworkInfo(network)
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun getNetworkPreference(pigeon_instance: ConnectivityManager): Long {
        return pigeon_instance.networkPreference.toLong()
    }

    override fun getNetworkWatchlistConfigHash(pigeon_instance: ConnectivityManager): ByteArray? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) pigeon_instance.networkWatchlistConfigHash
        else throw UnsupportedOperationException("Call requires API level 28")
    }

    override fun getRestrictBackgroundStatus(pigeon_instance: ConnectivityManager): RestrictBackgroundStatusApi {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) pigeon_instance.restrictBackgroundStatus.restrictBackgroundStatusApi
        else throw UnsupportedOperationException("Call requires API level 24")
    }

    @RequiresPermission(Manifest.permission.ACCESS_NETWORK_STATE)
    override fun isActiveNetworkMetered(pigeon_instance: ConnectivityManager): Boolean {
        return pigeon_instance.isActiveNetworkMetered
    }

    override fun isDefaultNetworkActive(pigeon_instance: ConnectivityManager): Boolean {
        return pigeon_instance.isDefaultNetworkActive
    }

    override fun reportBadNetwork(pigeon_instance: ConnectivityManager, network: Network) {
        pigeon_instance.reportBadNetwork(network)
    }

    override fun reportNetworkConnectivity(
        pigeon_instance: ConnectivityManager, network: Network, hasConnectivity: Boolean
    ) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            pigeon_instance.reportNetworkConnectivity(network, hasConnectivity)
        } else {
            throw UnsupportedOperationException("Call requires API level 23")
        }
    }

    override fun requestBandwidthUpdate(pigeon_instance: ConnectivityManager, network: Network): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) pigeon_instance.requestBandwidthUpdate(network)
        else throw UnsupportedOperationException("Call requires API level 23")
    }

    override fun requestNetwork(
        pigeon_instance: ConnectivityManager,
        request: NetworkRequest,
        networkCallback: ConnectivityManager.NetworkCallback,
        timeoutMs: Long?
    ) {
        if (timeoutMs == null) {
            pigeon_instance.requestNetwork(request, networkCallback)
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            pigeon_instance.requestNetwork(request, networkCallback, timeoutMs.toInt())
        } else {
            throw UnsupportedOperationException("Call requires API level 26")
        }
    }

    override fun reserveNetwork(
        pigeon_instance: ConnectivityManager,
        request: NetworkRequest,
        networkCallback: ConnectivityManager.NetworkCallback
    ) {
        // TODO: Implement this when targetSdk 36
        throw NotImplementedError()
    }

    override fun setNetworkPreference(pigeon_instance: ConnectivityManager, preference: Long) {
        pigeon_instance.networkPreference = preference.toInt()
    }

    override fun getProcessDefaultNetwork(): Network? {
        return ConnectivityManager.getProcessDefaultNetwork()
    }

    override fun isNetworkTypeValid(networkType: NetworkTypeApi): Boolean {
        return ConnectivityManager.isNetworkTypeValid(networkType.impl)
    }

    override fun setProcessDefaultNetwork(network: Network): Boolean {
        return ConnectivityManager.setProcessDefaultNetwork(network)
    }
}

val Context.mainHandler get() = Handler(mainLooper)

val Int.restrictBackgroundStatusApi
    get() = when (this) {
        ConnectivityManager.RESTRICT_BACKGROUND_STATUS_DISABLED -> RestrictBackgroundStatusApi.DISABLED
        ConnectivityManager.RESTRICT_BACKGROUND_STATUS_WHITELISTED -> RestrictBackgroundStatusApi.WHITELISTED
        ConnectivityManager.RESTRICT_BACKGROUND_STATUS_ENABLED -> RestrictBackgroundStatusApi.ENABLED
        else -> throw IllegalArgumentException("illegal value: $this")
    }

val NetworkTypeApi.impl
    get() = when (this) {
        NetworkTypeApi.MOBILE -> ConnectivityManager.TYPE_MOBILE
        NetworkTypeApi.WIFI -> ConnectivityManager.TYPE_WIFI
        NetworkTypeApi.MOBILE_MMS -> ConnectivityManager.TYPE_MOBILE_MMS
        NetworkTypeApi.MOBILE_SUPL -> ConnectivityManager.TYPE_MOBILE_SUPL
        NetworkTypeApi.MOBILE_DUN -> ConnectivityManager.TYPE_MOBILE_DUN
        NetworkTypeApi.MOBILE_HIPRI -> ConnectivityManager.TYPE_MOBILE_HIPRI
        NetworkTypeApi.WIMAX -> ConnectivityManager.TYPE_WIMAX
        NetworkTypeApi.BLUETOOTH -> ConnectivityManager.TYPE_BLUETOOTH
        NetworkTypeApi.DUMMY -> ConnectivityManager.TYPE_DUMMY
        NetworkTypeApi.ETHERNET -> ConnectivityManager.TYPE_ETHERNET
        NetworkTypeApi.VPN -> ConnectivityManager.TYPE_VPN
    }

val ConnectivityManagerNetworkCallbackFlagApi.impl
    get() = when (this) {
        ConnectivityManagerNetworkCallbackFlagApi.INCLUDE_LOCATION_INFO -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) ConnectivityManager.NetworkCallback.FLAG_INCLUDE_LOCATION_INFO
        else throw UnsupportedOperationException("Field requires API level 31")
    }