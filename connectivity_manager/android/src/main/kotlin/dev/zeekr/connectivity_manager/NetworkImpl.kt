package dev.zeekr.connectivity_manager

import android.net.Network
import android.os.Build
import java.io.FileDescriptor
import java.net.DatagramSocket
import java.net.InetAddress
import java.net.Proxy
import java.net.Socket
import java.net.URL
import java.net.URLConnection
import javax.net.SocketFactory

class NetworkImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) : PigeonApiNetworkProxyApi(registrar) {
    override fun bindSocket1(pigeon_instance: Network, socket: Socket) {
        pigeon_instance.bindSocket(socket)
    }

    override fun bindSocket2(pigeon_instance: Network, socket: DatagramSocket) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) pigeon_instance.bindSocket(socket)
        else throw UnsupportedOperationException("Call requires API level 22")
    }

    override fun bindSocket3(pigeon_instance: Network, fd: FileDescriptor) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) pigeon_instance.bindSocket(fd)
        else throw UnsupportedOperationException("Call requires API level 23")
    }

    override fun getAllByName(pigeon_instance: Network, host: String): List<InetAddress> {
        return pigeon_instance.getAllByName(host).toList()
    }

    override fun getByName(pigeon_instance: Network, host: String): InetAddress {
        return pigeon_instance.getByName(host)
    }

    override fun getNetworkHandle(pigeon_instance: Network): Long {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) pigeon_instance.networkHandle
        else throw UnsupportedOperationException("Call requires API level 23")
    }

    override fun getSocketFactory(pigeon_instance: Network): SocketFactory {
        return pigeon_instance.socketFactory
    }

    override fun openConnection(pigeon_instance: Network, url: URL, proxy: Proxy?): URLConnection {
        return if (proxy == null) pigeon_instance.openConnection(url)
        else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) pigeon_instance.openConnection(url, proxy)
        else throw UnsupportedOperationException("Call requires API level 23")

    }

    override fun fromNetworkHandle(networkHandle: Long): Network {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) Network.fromNetworkHandle(networkHandle)
        else throw UnsupportedOperationException("Call requires API level 28")
    }
}