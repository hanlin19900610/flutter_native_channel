//
//  MethodChannelDemo.swift
//  Runner
//
//  Created by a on 2020/12/28.
//

import Foundation

import Flutter
import UIKit

public class MethodChannelDemo {
    init(messenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(name: "com.mufeng.flutterNativeChannel.MethodChannel", binaryMessenger: messenger)
        channel.setMethodCallHandler{ (call: FlutterMethodCall, result:@escaping FlutterResult)in
            if(call.method == "add"){
                if let dict = call.arguments as? Dictionary<String, Any>{
                    let params1: Int = dict["params1"] as? Int ?? 0
                    let params2: Int = dict["params2"] as? Int ?? 0
                    let params3: Int = dict["params3"] as? Int ?? 0
                    result(params1 + params2 + params3)
                }
            }
        }
    }
}
