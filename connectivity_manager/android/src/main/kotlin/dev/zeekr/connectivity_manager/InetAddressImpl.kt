package dev.zeekr.connectivity_manager

import java.net.InetAddress
import java.net.NetworkInterface

class InetAddressImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) :
    PigeonApiInetAddressProxyApi(registrar) {
    override fun getAddress(pigeon_instance: InetAddress): ByteArray {
        return pigeon_instance.address
    }

    override fun getCanonicalHostName(pigeon_instance: InetAddress): String {
        return pigeon_instance.canonicalHostName
    }

    override fun getHostAddress(pigeon_instance: InetAddress): String? {
        return pigeon_instance.hostAddress
    }

    override fun getHostName(pigeon_instance: InetAddress): String {
        return pigeon_instance.hostName
    }

    override fun isAnyLocalAddress(pigeon_instance: InetAddress): Boolean {
        return pigeon_instance.isAnyLocalAddress
    }

    override fun isLinkLocalAddress(pigeon_instance: InetAddress): Boolean {
        return pigeon_instance.isLinkLocalAddress
    }

    override fun isLoopbackAddress(pigeon_instance: InetAddress): Boolean {
        return pigeon_instance.isLoopbackAddress
    }

    override fun isMcGlobal(pigeon_instance: InetAddress): Boolean {
        return pigeon_instance.isMCGlobal
    }

    override fun isMcLinkLocal(pigeon_instance: InetAddress): Boolean {
        return pigeon_instance.isMCLinkLocal
    }

    override fun isMcNodeLocal(pigeon_instance: InetAddress): Boolean {
        return pigeon_instance.isMCNodeLocal
    }

    override fun isMcOrgLocal(pigeon_instance: InetAddress): Boolean {
        return pigeon_instance.isMCOrgLocal
    }

    override fun isMcSiteLocal(pigeon_instance: InetAddress): Boolean {
        return pigeon_instance.isMCSiteLocal
    }

    override fun isMulticastAddress(pigeon_instance: InetAddress): Boolean {
        return pigeon_instance.isMulticastAddress
    }

    override fun isReachable1(pigeon_instance: InetAddress, timeout: Long): Boolean {
        return pigeon_instance.isReachable(timeout.toInt())
    }

    override fun isReachable2(
        pigeon_instance: InetAddress, netif: NetworkInterface?, ttl: Long, timetout: Long
    ): Boolean {
        return pigeon_instance.isReachable(netif, ttl.toInt(), timetout.toInt())
    }

    override fun isSiteLocalAddress(pigeon_instance: InetAddress): Boolean {
        return pigeon_instance.isSiteLocalAddress
    }

    override fun getAllByName(host: String?): List<InetAddress> {
        return InetAddress.getAllByName(host).toList()
    }

    override fun getByAddress1(addr: ByteArray): InetAddress {
        return InetAddress.getByAddress(addr)
    }

    override fun getByAddress2(host: String?, addr: ByteArray): InetAddress {
        return InetAddress.getByAddress(host, addr)
    }

    override fun getByName(host: String?): InetAddress {
        return InetAddress.getByName(host)
    }

    override fun getLocalHost(): InetAddress {
        return InetAddress.getLocalHost()
    }

    override fun getLoopbackAddress(): InetAddress {
        return InetAddress.getLoopbackAddress()
    }
}