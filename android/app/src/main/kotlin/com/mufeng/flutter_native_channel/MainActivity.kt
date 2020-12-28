package com.mufeng.flutter_native_channel

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannelDemo(flutterEngine.dartExecutor.binaryMessenger)
        EventChannelDemo(this, flutterEngine.dartExecutor.binaryMessenger)
    }
}
