package dev.zeekr.connectivity_manager

import android.net.IpPrefix
import android.os.Build
import java.net.InetAddress

class IpPrefixImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) : PigeonApiIpPrefixProxyApi(registrar) {
    override fun contains(pigeon_instance: IpPrefix, address: InetAddress): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) pigeon_instance.contains(address)
        else throw UnsupportedOperationException("Call requires API level 23")

    }

    override fun getAddress(pigeon_instance: IpPrefix): InetAddress {
        return pigeon_instance.address
    }

    override fun getPrefixLength(pigeon_instance: IpPrefix): Long {
        return pigeon_instance.prefixLength.toLong()
    }

    override fun getRawAddress(pigeon_instance: IpPrefix): ByteArray {
        return pigeon_instance.rawAddress
    }
}