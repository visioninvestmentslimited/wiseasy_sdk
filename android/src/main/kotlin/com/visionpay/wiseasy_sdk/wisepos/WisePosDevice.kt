package com.visionpay.wiseasy_sdk.wisepos

import android.util.Log
import com.visionpay.wiseasy_sdk.WisePosDeviceChannel
import com.wisepos.smartpos.device.Device

class WisePosDevice(private val device: Device) : WisePosDeviceChannel {

    override fun getVersionInfo(): Map<String, String> {
        return device.versionInfo
    }

    override fun getKernelVersion(): Map<String, String> {
        return device.kernelVersion
    }

    override fun getTamperStatus(): Map<String, Long> {
        return device.tamperStatus.mapValues { entry ->
            try {
                val value = entry.value
                return@mapValues value.toString().toLongOrNull() ?: -1L
            } catch (e: Exception) {
                Log.e("GetTamperStatus", e.toString())
                return@mapValues -1L
            }
        }
    }

    override fun getDeviceSn(): String {
        return device.deviceSn
    }
}