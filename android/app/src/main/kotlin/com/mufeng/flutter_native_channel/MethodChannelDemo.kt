package com.mufeng.flutter_native_channel

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MethodChannelDemo (messenger: BinaryMessenger): MethodChannel.MethodCallHandler{

    private var channel: MethodChannel = MethodChannel(messenger, "com.mufeng.flutterNativeChannel.MethodChannel")

    init {
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when(call.method){
            "add" -> {
                val params1 = call.argument<Int>("params1")
                val params2 = call.argument<Int>("params2")
                val params3 = call.argument<Int>("params3")
                val params = params1!! + params2!! + params3!!
                result.success(params)
            }
        }
    }
}