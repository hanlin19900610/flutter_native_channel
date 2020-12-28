package com.mufeng.flutter_native_channel

import android.app.Activity
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import java.util.*
import kotlin.concurrent.timerTask

class EventChannelDemo(private var activity: Activity, messenger: BinaryMessenger) : EventChannel.StreamHandler {

    private var channel: EventChannel = EventChannel(messenger, "com.mufeng.flutterNativeChannel.EventChannel")
    private var count = 0
    private var events: EventChannel.EventSink? = null
    init {
        channel.setStreamHandler(this)
        startTimer()
    }

    private fun startTimer() {
        var timer = Timer().schedule(timerTask {
            count++
            val map = mapOf("count" to count)
            activity.runOnUiThread {
                events?.success(map)
            }
            if(count >= 30){
                activity.runOnUiThread {
                    events?.error("400", "超过30秒,倒计时结束", null)
                }
                cancel()
            }
        }, 0, 1000)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        this.events = events
    }

    override fun onCancel(arguments: Any?) {
        this.events = null
    }
}