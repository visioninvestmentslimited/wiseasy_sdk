package com.visionpay.wiseasy_sdk.wisepos

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
        return device.tamperStatus.mapValues {
            return mapOf(it.key to it.key.toLong())
        }
    }

    override fun getDeviceSn(): String {
        return device.deviceSn
    }
}