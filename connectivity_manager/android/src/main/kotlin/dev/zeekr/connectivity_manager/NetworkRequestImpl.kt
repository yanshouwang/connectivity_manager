package dev.zeekr.connectivity_manager

import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.net.NetworkSpecifier
import android.os.Build
import android.os.ext.SdkExtensions

class NetworkRequestImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) :
    PigeonApiNetworkRequestProxyApi(registrar) {
    override fun pigeon_defaultConstructor(
        capabilities: List<NetworkCapabilityApi>?,
        transportTypes: List<TransportTypeApi>?,
        includeOtherUidNetworks: Boolean?,
        networkSpecifier: NetworkSpecifier?,
        subIds: List<Long>?
    ): NetworkRequest {
        val builder = NetworkRequest.Builder()
        if (capabilities != null) {
            for (capability in capabilities) {
                builder.addCapability(capability.impl)
            }
        }
        if (transportTypes != null) {
            for (transportType in transportTypes) {
                builder.addTransportType(transportType.impl)
            }
        }
        if (includeOtherUidNetworks != null) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                builder.setIncludeOtherUidNetworks(includeOtherUidNetworks)
            } else {
                throw UnsupportedOperationException("Call requires API level 31")
            }
        }
        if (networkSpecifier != null) {
            builder.setNetworkSpecifier(networkSpecifier)
        }
        if (subIds != null) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && SdkExtensions.getExtensionVersion(Build.VERSION_CODES.UPSIDE_DOWN_CAKE) >= 12) {
                builder.setSubscriptionIds(subIds.map { it.toInt() }.toSet())
            } else {
                throw UnsupportedOperationException("Call requires version 12 of the U Extensions SDK")
            }
        }
        return builder.build()
    }

    override fun canBeSatisfiedBy(pigeon_instance: NetworkRequest, nc: NetworkCapabilities): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) pigeon_instance.canBeSatisfiedBy(nc)
        else throw UnsupportedOperationException("Call requires API level 30")
    }

    override fun getCapabilities(pigeon_instance: NetworkRequest): List<NetworkCapabilityApi> {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) pigeon_instance.capabilities.map { it.networkCapabilityApi }
        else throw UnsupportedOperationException("Call requires API level 31")
    }

    override fun getNetworkSpecifier(pigeon_instance: NetworkRequest): NetworkSpecifier? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) pigeon_instance.networkSpecifier
        else throw UnsupportedOperationException("Call requires API level 30")
    }

    override fun getSubscriptionIds(pigeon_instance: NetworkRequest): List<Long> {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && SdkExtensions.getExtensionVersion(Build.VERSION_CODES.UPSIDE_DOWN_CAKE) >= 12) pigeon_instance.subscriptionIds.map { it.toLong() }
        else throw UnsupportedOperationException("Call requires version 12 of the U Extensions SDK")
    }

    override fun getTransportTypes(pigeon_instance: NetworkRequest): List<TransportTypeApi> {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) pigeon_instance.transportTypes.map { it.transportTypeApi }
        else throw UnsupportedOperationException("Call requires API level 31")
    }

    override fun hasCapability(pigeon_instance: NetworkRequest, capability: NetworkCapabilityApi): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) pigeon_instance.hasCapability(capability.impl)
        else throw UnsupportedOperationException("Call requires API level 28")
    }

    override fun hasTransport(pigeon_instance: NetworkRequest, transportType: TransportTypeApi): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) pigeon_instance.hasTransport(transportType.impl)
        else throw UnsupportedOperationException("Call requires API level 28")
    }
}

val Int.networkCapabilityApi
    get() = when (this) {
        NetworkCapabilities.NET_CAPABILITY_MMS -> NetworkCapabilityApi.MMS
        NetworkCapabilities.NET_CAPABILITY_SUPL -> NetworkCapabilityApi.SUPL
        NetworkCapabilities.NET_CAPABILITY_DUN -> NetworkCapabilityApi.DUN
        NetworkCapabilities.NET_CAPABILITY_FOTA -> NetworkCapabilityApi.FOTA
        NetworkCapabilities.NET_CAPABILITY_IMS -> NetworkCapabilityApi.IMS
        NetworkCapabilities.NET_CAPABILITY_CBS -> NetworkCapabilityApi.CBS
        NetworkCapabilities.NET_CAPABILITY_WIFI_P2P -> NetworkCapabilityApi.WIFI_P2P
        NetworkCapabilities.NET_CAPABILITY_IA -> NetworkCapabilityApi.IA
        NetworkCapabilities.NET_CAPABILITY_RCS -> NetworkCapabilityApi.RCS
        NetworkCapabilities.NET_CAPABILITY_XCAP -> NetworkCapabilityApi.XCAP
        NetworkCapabilities.NET_CAPABILITY_EIMS -> NetworkCapabilityApi.EIMS
        NetworkCapabilities.NET_CAPABILITY_NOT_METERED -> NetworkCapabilityApi.NOT_METERED
        NetworkCapabilities.NET_CAPABILITY_INTERNET -> NetworkCapabilityApi.INTERNET
        NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED -> NetworkCapabilityApi.NOT_RESTRICTED
        NetworkCapabilities.NET_CAPABILITY_TRUSTED -> NetworkCapabilityApi.TRUSTED
        NetworkCapabilities.NET_CAPABILITY_NOT_VPN -> NetworkCapabilityApi.NOT_VPN
        NetworkCapabilities.NET_CAPABILITY_VALIDATED -> NetworkCapabilityApi.VALIDATED
        NetworkCapabilities.NET_CAPABILITY_CAPTIVE_PORTAL -> NetworkCapabilityApi.CAPTIVE_PORTAL
        NetworkCapabilities.NET_CAPABILITY_NOT_ROAMING -> NetworkCapabilityApi.NOT_ROAMING
        NetworkCapabilities.NET_CAPABILITY_FOREGROUND -> NetworkCapabilityApi.FOREGROUND
        NetworkCapabilities.NET_CAPABILITY_NOT_CONGESTED -> NetworkCapabilityApi.NOT_CONGESTED
        NetworkCapabilities.NET_CAPABILITY_NOT_SUSPENDED -> NetworkCapabilityApi.NOT_SUSPENDED
        NetworkCapabilities.NET_CAPABILITY_MCX -> NetworkCapabilityApi.MCX
        NetworkCapabilities.NET_CAPABILITY_TEMPORARILY_NOT_METERED -> NetworkCapabilityApi.TEMPORARILY_NOT_METERED
        NetworkCapabilities.NET_CAPABILITY_ENTERPRISE -> NetworkCapabilityApi.ENTERPRISE
        NetworkCapabilities.NET_CAPABILITY_HEAD_UNIT -> NetworkCapabilityApi.HEAD_UNIT
        NetworkCapabilities.NET_CAPABILITY_MMTEL -> NetworkCapabilityApi.MMTEL
        NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_LATENCY -> NetworkCapabilityApi.PRIORITIZE_LATENCY
        NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_BANDWIDTH -> NetworkCapabilityApi.PRIORITIZE_BANDWIDTH
        NetworkCapabilities.NET_CAPABILITY_LOCAL_NETWORK -> NetworkCapabilityApi.LOCAL_NETWORK
        // TODO: Add NOT_BANDWIDTH_CONSTRAINED when targetSdk 36
        else -> throw IllegalArgumentException("illegal value: $this")
    }

val Int.transportTypeApi
    get() = when (this) {
        NetworkCapabilities.TRANSPORT_CELLULAR -> TransportTypeApi.CELLULAR
        NetworkCapabilities.TRANSPORT_WIFI -> TransportTypeApi.WIFI
        NetworkCapabilities.TRANSPORT_BLUETOOTH -> TransportTypeApi.BLUETOOTH
        NetworkCapabilities.TRANSPORT_ETHERNET -> TransportTypeApi.ETHERNET
        NetworkCapabilities.TRANSPORT_VPN -> TransportTypeApi.VPN
        NetworkCapabilities.TRANSPORT_WIFI_AWARE -> TransportTypeApi.WIFI_AWARE
        NetworkCapabilities.TRANSPORT_LOWPAN -> TransportTypeApi.LOWPAN
        NetworkCapabilities.TRANSPORT_USB -> TransportTypeApi.USB
        NetworkCapabilities.TRANSPORT_THREAD -> TransportTypeApi.THREAD
        NetworkCapabilities.TRANSPORT_SATELLITE -> TransportTypeApi.SATELLITE
        else -> throw IllegalArgumentException("illegal value: $this")
    }

val NetworkCapabilityApi.impl
    get() = when (this) {
        NetworkCapabilityApi.MMS -> NetworkCapabilities.NET_CAPABILITY_MMS
        NetworkCapabilityApi.SUPL -> NetworkCapabilities.NET_CAPABILITY_SUPL
        NetworkCapabilityApi.DUN -> NetworkCapabilities.NET_CAPABILITY_DUN
        NetworkCapabilityApi.FOTA -> NetworkCapabilities.NET_CAPABILITY_FOTA
        NetworkCapabilityApi.IMS -> NetworkCapabilities.NET_CAPABILITY_IMS
        NetworkCapabilityApi.CBS -> NetworkCapabilities.NET_CAPABILITY_CBS
        NetworkCapabilityApi.WIFI_P2P -> NetworkCapabilities.NET_CAPABILITY_WIFI_P2P
        NetworkCapabilityApi.IA -> NetworkCapabilities.NET_CAPABILITY_IA
        NetworkCapabilityApi.RCS -> NetworkCapabilities.NET_CAPABILITY_RCS
        NetworkCapabilityApi.XCAP -> NetworkCapabilities.NET_CAPABILITY_XCAP
        NetworkCapabilityApi.EIMS -> NetworkCapabilities.NET_CAPABILITY_EIMS
        NetworkCapabilityApi.NOT_METERED -> NetworkCapabilities.NET_CAPABILITY_NOT_METERED
        NetworkCapabilityApi.INTERNET -> NetworkCapabilities.NET_CAPABILITY_INTERNET
        NetworkCapabilityApi.NOT_RESTRICTED -> NetworkCapabilities.NET_CAPABILITY_NOT_RESTRICTED
        NetworkCapabilityApi.TRUSTED -> NetworkCapabilities.NET_CAPABILITY_TRUSTED
        NetworkCapabilityApi.NOT_VPN -> NetworkCapabilities.NET_CAPABILITY_NOT_VPN
        NetworkCapabilityApi.VALIDATED -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) NetworkCapabilities.NET_CAPABILITY_VALIDATED
        else throw UnsupportedOperationException("Field requires API level 23")

        NetworkCapabilityApi.CAPTIVE_PORTAL -> NetworkCapabilities.NET_CAPABILITY_CAPTIVE_PORTAL
        NetworkCapabilityApi.NOT_ROAMING -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) NetworkCapabilities.NET_CAPABILITY_NOT_ROAMING
        else throw UnsupportedOperationException("Field requires API level 28")

        NetworkCapabilityApi.FOREGROUND -> NetworkCapabilities.NET_CAPABILITY_FOREGROUND
        NetworkCapabilityApi.NOT_CONGESTED -> NetworkCapabilities.NET_CAPABILITY_NOT_CONGESTED
        NetworkCapabilityApi.NOT_SUSPENDED -> NetworkCapabilities.NET_CAPABILITY_NOT_SUSPENDED
        NetworkCapabilityApi.MCX -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) NetworkCapabilities.NET_CAPABILITY_MCX
        else throw UnsupportedOperationException("Field requires API level 29")

        NetworkCapabilityApi.TEMPORARILY_NOT_METERED -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) NetworkCapabilities.NET_CAPABILITY_TEMPORARILY_NOT_METERED
        else throw UnsupportedOperationException("Field requires API level 30")

        NetworkCapabilityApi.ENTERPRISE -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) NetworkCapabilities.NET_CAPABILITY_ENTERPRISE
        else throw UnsupportedOperationException("Field requires API level 31")

        NetworkCapabilityApi.HEAD_UNIT -> NetworkCapabilities.NET_CAPABILITY_HEAD_UNIT
        NetworkCapabilityApi.MMTEL -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) NetworkCapabilities.NET_CAPABILITY_MMTEL
        else throw UnsupportedOperationException("Field requires API level 33")

        NetworkCapabilityApi.PRIORITIZE_LATENCY -> NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_LATENCY
        NetworkCapabilityApi.PRIORITIZE_BANDWIDTH -> NetworkCapabilities.NET_CAPABILITY_PRIORITIZE_BANDWIDTH
        NetworkCapabilityApi.LOCAL_NETWORK -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && SdkExtensions.getExtensionVersion(
                Build.VERSION_CODES.UPSIDE_DOWN_CAKE
            ) >= 12
        ) NetworkCapabilities.NET_CAPABILITY_LOCAL_NETWORK
        else throw UnsupportedOperationException("Field requires version 12 of the U Extensions SDK")

        NetworkCapabilityApi.NOT_BANDWIDTH_CONSTRAINED -> throw UnsupportedOperationException("Field requires API level 36")
    }

val TransportTypeApi.impl
    get() = when (this) {
        TransportTypeApi.CELLULAR -> NetworkCapabilities.TRANSPORT_CELLULAR
        TransportTypeApi.WIFI -> NetworkCapabilities.TRANSPORT_WIFI
        TransportTypeApi.BLUETOOTH -> NetworkCapabilities.TRANSPORT_BLUETOOTH
        TransportTypeApi.ETHERNET -> NetworkCapabilities.TRANSPORT_ETHERNET
        TransportTypeApi.VPN -> NetworkCapabilities.TRANSPORT_VPN
        TransportTypeApi.WIFI_AWARE -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) NetworkCapabilities.TRANSPORT_WIFI_AWARE
        else throw UnsupportedOperationException("Field requires API level 26")

        TransportTypeApi.LOWPAN -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) NetworkCapabilities.TRANSPORT_LOWPAN
        else throw UnsupportedOperationException("Field requires API level 27")

        TransportTypeApi.USB -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) NetworkCapabilities.TRANSPORT_USB
        else throw UnsupportedOperationException("Field requires API level 31")

        TransportTypeApi.THREAD -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && SdkExtensions.getExtensionVersion(
                Build.VERSION_CODES.UPSIDE_DOWN_CAKE
            ) >= 7
        ) NetworkCapabilities.TRANSPORT_THREAD
        else throw UnsupportedOperationException("Field requires version 7 of the U Extensions SDK")

        TransportTypeApi.SATELLITE -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && SdkExtensions.getExtensionVersion(
                Build.VERSION_CODES.UPSIDE_DOWN_CAKE
            ) >= 12
        ) NetworkCapabilities.TRANSPORT_SATELLITE
        else throw UnsupportedOperationException("Field requires version 12 of the U Extensions SDK")
    }