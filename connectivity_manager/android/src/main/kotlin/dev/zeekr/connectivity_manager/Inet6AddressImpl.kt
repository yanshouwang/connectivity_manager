package dev.zeekr.connectivity_manager

import java.net.Inet6Address
import java.net.NetworkInterface

class Inet6AddressImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) :
    PigeonApiInet6AddressProxyApi(registrar) {
    override fun getByAddress3(host: String, addr: ByteArray, nif: NetworkInterface): Inet6Address {
        return Inet6Address.getByAddress(host, addr, nif)
    }

    override fun getByAddress4(host: String, addr: ByteArray, scopeId: Long): Inet6Address {
        return Inet6Address.getByAddress(host, addr, scopeId.toInt())
    }

    override fun isIPv4CompatibleAddress(pigeon_instance: Inet6Address): Boolean {
        return pigeon_instance.isIPv4CompatibleAddress
    }
}