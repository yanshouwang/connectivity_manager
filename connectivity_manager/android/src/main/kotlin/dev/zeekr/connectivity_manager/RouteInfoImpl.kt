package dev.zeekr.connectivity_manager

import android.net.IpPrefix
import android.net.RouteInfo
import android.os.Build
import java.net.InetAddress

class RouteInfoImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) : PigeonApiRouteInfoProxyApi(registrar) {
    override fun getDestination(pigeon_instance: RouteInfo): IpPrefix {
        return pigeon_instance.destination
    }

    override fun getGateway(pigeon_instance: RouteInfo): InetAddress? {
        return pigeon_instance.gateway
    }

    override fun getInterface(pigeon_instance: RouteInfo): String? {
        return pigeon_instance.`interface`
    }

    override fun getType(pigeon_instance: RouteInfo): RouteTypeApi {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) pigeon_instance.type.routeTypeApi
        else throw UnsupportedOperationException("Call requires API level 33")

    }

    override fun hasGateway(pigeon_instance: RouteInfo): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) pigeon_instance.hasGateway()
        else throw UnsupportedOperationException("Call requires API level 29")
    }

    override fun isDefaultRoute(pigeon_instance: RouteInfo): Boolean {
        return pigeon_instance.isDefaultRoute
    }

    override fun matches(pigeon_instance: RouteInfo, destination: InetAddress): Boolean {
        return pigeon_instance.matches(destination)
    }
}

val Int.routeTypeApi
    get() = when (this) {
        RouteInfo.RTN_UNICAST -> RouteTypeApi.UNICAST
        RouteInfo.RTN_UNREACHABLE -> RouteTypeApi.UNREACHABLE
        RouteInfo.RTN_THROW -> RouteTypeApi.THROWS
        else -> throw IllegalArgumentException("illegal value $this")
    }