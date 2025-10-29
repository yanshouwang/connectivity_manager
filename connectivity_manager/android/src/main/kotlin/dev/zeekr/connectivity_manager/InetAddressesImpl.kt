package dev.zeekr.connectivity_manager

import android.net.InetAddresses
import android.os.Build
import androidx.annotation.RequiresApi
import java.net.InetAddress

@RequiresApi(Build.VERSION_CODES.Q)
class InetAddressesImpl(registrar: ConnectivityManagerApiPigeonProxyApiRegistrar) :
    PigeonApiInetAddressesProxyApi(registrar) {
    override fun isNumericAddress(address: String): Boolean {
        return InetAddresses.isNumericAddress(address)
    }

    override fun parseNumericAddress(address: String): InetAddress {
        return InetAddresses.parseNumericAddress(address)
    }
}