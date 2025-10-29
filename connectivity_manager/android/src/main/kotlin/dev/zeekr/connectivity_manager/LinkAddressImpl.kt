package dev.zeekr.connectivity_manager

import android.net.LinkAddress
import java.net.InetAddress

class LinkAddressImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) :
    PigeonApiLinkAddressProxyApi(registrar) {
    override fun getAddress(pigeon_instance: LinkAddress): InetAddress {
        return pigeon_instance.address
    }

    override fun getFlags(pigeon_instance: LinkAddress): Long {
        return pigeon_instance.flags.toLong()
    }

    override fun getPrefixLength(pigeon_instance: LinkAddress): Long {
        return pigeon_instance.prefixLength.toLong()
    }

    override fun getScope(pigeon_instance: LinkAddress): Long {
        return pigeon_instance.scope.toLong()
    }
}