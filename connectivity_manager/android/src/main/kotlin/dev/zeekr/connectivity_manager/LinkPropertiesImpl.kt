package dev.zeekr.connectivity_manager

import android.net.IpPrefix
import android.net.LinkAddress
import android.net.LinkProperties
import android.net.ProxyInfo
import android.net.RouteInfo
import android.os.Build
import java.net.Inet4Address
import java.net.InetAddress

class LinkPropertiesImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) :
    PigeonApiLinkPropertiesProxyApi(registrar) {
    override fun addRoute(pigeon_instance: LinkProperties, route: RouteInfo): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.addRoute(route)
        else throw UnsupportedOperationException("Call requires API level 29")

    }

    override fun clear(pigeon_instance: LinkProperties) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.clear()
        else throw UnsupportedOperationException("Call requires API level 29")

    }

    override fun getDhcpServerAddress(pigeon_instance: LinkProperties): Inet4Address? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) pigeon_instance.dhcpServerAddress
        else throw UnsupportedOperationException("Call requires API level 30")

    }

    override fun getDnsServers(pigeon_instance: LinkProperties): List<InetAddress> {
        return pigeon_instance.dnsServers
    }

    override fun getDomains(pigeon_instance: LinkProperties): String? {
        return pigeon_instance.domains
    }

    override fun getHttpProxy(pigeon_instance: LinkProperties): ProxyInfo? {
        return pigeon_instance.httpProxy
    }

    override fun getInterfaceName(pigeon_instance: LinkProperties): String? {
        return pigeon_instance.interfaceName
    }

    override fun getLinkAddresses(pigeon_instance: LinkProperties): List<LinkAddress> {
        return pigeon_instance.linkAddresses
    }

    override fun getMtu(pigeon_instance: LinkProperties): Long {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.mtu.toLong()
        else throw UnsupportedOperationException("Call requires API level 29")

    }

    override fun getNat64Prefix(pigeon_instance: LinkProperties): IpPrefix? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) pigeon_instance.nat64Prefix
        else throw UnsupportedOperationException("Call requires API level 30")

    }

    override fun getPrivateDnsServerName(pigeon_instance: LinkProperties): String? {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) pigeon_instance.privateDnsServerName
        else throw UnsupportedOperationException("Call requires API level 28")

    }

    override fun getRoutes(pigeon_instance: LinkProperties): List<RouteInfo> {
        return pigeon_instance.routes
    }

    override fun isPrivateDnsActive(pigeon_instance: LinkProperties): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) pigeon_instance.isPrivateDnsActive
        else throw UnsupportedOperationException("Call requires API level 28")

    }

    override fun isWakeOnLanSupported(pigeon_instance: LinkProperties): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) pigeon_instance.isWakeOnLanSupported
        else throw UnsupportedOperationException("Call requires API level 30")

    }

    override fun setDhcpServerAddress(pigeon_instance: LinkProperties, serverAddress: Inet4Address?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) pigeon_instance.dhcpServerAddress = serverAddress
        else throw UnsupportedOperationException("Call requires API level 30")

    }

    override fun setDnsServers(pigeon_instance: LinkProperties, dnsServers: List<InetAddress>) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.setDnsServers(dnsServers)
        else throw UnsupportedOperationException("Call requires API level 29")
    }

    override fun setDomains(pigeon_instance: LinkProperties, domains: String?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.domains = domains
        else throw UnsupportedOperationException("Call requires API level 29")
    }

    override fun setHttpProxy(pigeon_instance: LinkProperties, proxy: ProxyInfo?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.httpProxy = proxy
        else throw UnsupportedOperationException("Call requires API level 29")
    }

    override fun setInterfaceName(pigeon_instance: LinkProperties, iface: String?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.interfaceName = iface
        else throw UnsupportedOperationException("Call requires API level 29")
    }

    override fun setLinkAddresses(pigeon_instance: LinkProperties, addresses: List<LinkAddress>) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.setLinkAddresses(addresses)
        else throw UnsupportedOperationException("Call requires API level 29")
    }

    override fun setMtu(pigeon_instance: LinkProperties, mtu: Long) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.mtu = mtu.toInt()
        else throw UnsupportedOperationException("Call requires API level 29")
    }

    override fun setNat64Prefix(pigeon_instance: LinkProperties, prefix: IpPrefix?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) pigeon_instance.nat64Prefix = prefix
        else throw UnsupportedOperationException("Call requires API level 29")
    }
}