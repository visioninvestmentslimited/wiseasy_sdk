package com.visionpay.wiseasy_sdk.wisepos

import android.app.Activity
import android.content.Context
import android.util.Log
import com.visionpay.wiseasy_sdk.FlutterError
import com.visionpay.wiseasy_sdk.WisePosChannel
import com.visionpay.wiseasy_sdk.WisePosDeviceChannel
import com.visionpay.wiseasy_sdk.WisePosPrinterChannel
import com.wisepos.smartpos.InitPosSdkListener
import com.wisepos.smartpos.WisePosSdk
import io.flutter.plugin.common.BinaryMessenger

private const val TAG = "WisePosPlugin"

class WisePosPlugin(private val context: Context) : WisePosChannel {
    private lateinit var wisePosSdk: WisePosSdk
    private lateinit var binaryMessenger: BinaryMessenger

    fun setup(binaryMessenger: BinaryMessenger) {
        WisePosChannel.setUp(binaryMessenger, this)
        wisePosSdk = WisePosSdk.getInstance()
        this.binaryMessenger = binaryMessenger
    }

    fun setupInterfaces() {
        WisePosPrinterChannel.setUp(binaryMessenger, WisePosPrinter(wisePosSdk.printer))
        WisePosDeviceChannel.setUp(binaryMessenger, WisePosDevice(wisePosSdk.device))
    }

    override fun initialize(callback: (Result<Unit>) -> Unit) {
        wisePosSdk.initPosSdk(context, object : InitPosSdkListener {
            override fun onInitPosSuccess() {
                setupInterfaces()
                callback(Result.success(Unit))
            }

            override fun onInitPosFail(errorCode: Int) {
                callback(
                    Result.failure(
                        FlutterError(
                            errorCode.toString(),
                            "Failed to initialize: $errorCode"
                        )
                    )
                )
            }
        })
    }

}