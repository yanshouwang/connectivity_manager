package dev.zeekr.connectivity_manager

import android.content.Context
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.BinaryMessenger

class ConnectivityManagerRegistrarImpl(binaryMessenger: BinaryMessenger, val context: Context) :
    ConnectivityManagerApiPigeonProxyApiRegistrar(binaryMessenger) {
    override fun getPigeonApiConnectivityManagerProxyApi(): PigeonApiConnectivityManagerProxyApi {
        return ConnectivityManagerImpl(this, context)
    }

    override fun getPigeonApiConnectivityManagerNetworkCallbackProxyApi(): PigeonApiConnectivityManagerNetworkCallbackProxyApi {
        return ConnectivityManagerImpl.NetworkCallbackImpl(this)
    }

    override fun getPigeonApiConnectivityManagerOnNetworkActiveListenerProxyApi(): PigeonApiConnectivityManagerOnNetworkActiveListenerProxyApi {
        return ConnectivityManagerImpl.OnNetworkActiveListenerImpl(this)
    }

    override fun getPigeonApiNetworkProxyApi(): PigeonApiNetworkProxyApi {
        return NetworkImpl(this)
    }

    override fun getPigeonApiNetworkRequestProxyApi(): PigeonApiNetworkRequestProxyApi {
        return NetworkRequestImpl(this)
    }

    override fun getPigeonApiNetworkCapabilitiesProxyApi(): PigeonApiNetworkCapabilitiesProxyApi {
        return NetworkCapabilitiesImpl(this)
    }

    override fun getPigeonApiLinkPropertiesProxyApi(): PigeonApiLinkPropertiesProxyApi {
        return LinkPropertiesImpl(this)
    }

    override fun getPigeonApiLinkAddressProxyApi(): PigeonApiLinkAddressProxyApi {
        return LinkAddressImpl(this)
    }

    override fun getPigeonApiIpPrefixProxyApi(): PigeonApiIpPrefixProxyApi {
        return IpPrefixImpl(this)
    }

    override fun getPigeonApiRouteInfoProxyApi(): PigeonApiRouteInfoProxyApi {
        return RouteInfoImpl(this)
    }

    @RequiresApi(Build.VERSION_CODES.Q)
    override fun getPigeonApiInetAddressesProxyApi(): PigeonApiInetAddressesProxyApi {
        return InetAddressesImpl(this)
    }

    override fun getPigeonApiInetAddressProxyApi(): PigeonApiInetAddressProxyApi {
        return InetAddressImpl(this)
    }

    override fun getPigeonApiInet6AddressProxyApi(): PigeonApiInet6AddressProxyApi {
        return Inet6AddressImpl(this)
    }
}