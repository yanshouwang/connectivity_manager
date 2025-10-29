package dev.zeekr.connectivity_manager

import android.net.NetworkCapabilities
import android.net.NetworkSpecifier
import android.net.TransportInfo
import android.os.Build
import android.os.ext.SdkExtensions

class NetworkCapabilitiesImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) :
    PigeonApiNetworkCapabilitiesProxyApi(registrar) {
    override fun getCapabilities(pigeon_instance: NetworkCapabilities): List<NetworkCapabilityApi> {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) pigeon_instance.capabilities.map { it.networkCapabilityApi }
        else throw UnsupportedOperationException("Call requires API level 31")

    }

    override fun getEnterpriseIds(pigeon_instance: NetworkCapabilities): List<Long> {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) pigeon_instance.enterpriseIds.map { it.toLong() }
        else throw UnsupportedOperationException("Call requires API level 33")

    }

    override fun getLinkDownstreamBandwidthKbps(pigeon_instance: NetworkCapabilities): Long {
        return pigeon_instance.linkDownstreamBandwidthKbps.toLong()
    }

    override fun getLinkUpstreamBandwidthKbps(pigeon_instance: NetworkCapabilities): Long {
        return pigeon_instance.linkUpstreamBandwidthKbps.toLong()
    }

    override fun getNetworkSpecifier(pigeon_instance: NetworkCapabilities): NetworkSpecifier? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) pigeon_instance.networkSpecifier
        else throw UnsupportedOperationException("Call requires API level 30")

    }

    override fun getOwnerUid(pigeon_instance: NetworkCapabilities): Long {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) pigeon_instance.ownerUid.toLong()
        else throw UnsupportedOperationException("Call requires API level 30")

    }

    override fun getSignalStrength(pigeon_instance: NetworkCapabilities): Long {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.signalStrength.toLong()
        else throw UnsupportedOperationException("Call requires API level 29")
    }

    override fun getSubscriptionIds(pigeon_instance: NetworkCapabilities): List<Long> {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R && SdkExtensions.getExtensionVersion(Build.VERSION_CODES.UPSIDE_DOWN_CAKE) >= 12) pigeon_instance.subscriptionIds.map { it.toLong() }
        else throw UnsupportedOperationException("Call requires version 12 of the U Extensions SDK")
    }

    override fun getTransportInfo(pigeon_instance: NetworkCapabilities): TransportInfo? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.transportInfo
        else throw UnsupportedOperationException("Call requires API level 29")
    }

    override fun hasCapability(pigeon_instance: NetworkCapabilities, capability: NetworkCapabilityApi): Boolean {
        return pigeon_instance.hasCapability(capability.impl)
    }

    override fun hasEnterpriseId(pigeon_instance: NetworkCapabilities, enterpriseId: Long): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) pigeon_instance.hasEnterpriseId(enterpriseId.toInt())
        else throw UnsupportedOperationException("Call requires API level 33")
    }

    override fun hasTransport(pigeon_instance: NetworkCapabilities, transportType: TransportTypeApi): Boolean {
        return pigeon_instance.hasTransport(transportType.impl)
    }
}