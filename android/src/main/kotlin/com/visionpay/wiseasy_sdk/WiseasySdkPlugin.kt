package com.visionpay.wiseasy_sdk

import com.visionpay.wiseasy_sdk.wisepos.WisePosPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin

class WiseasySdkPlugin : FlutterPlugin {
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        // Setup WisePos
        WisePosPlugin(flutterPluginBinding.applicationContext).setup(flutterPluginBinding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }
}
