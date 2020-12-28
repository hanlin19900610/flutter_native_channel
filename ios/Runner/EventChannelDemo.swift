//
//  EventChannelDemo.swift
//  Runner
//
//  Created by a on 2020/12/28.
//

import Foundation
import Flutter
import UIKit

public class EventChannelDemo: NSObject, FlutterStreamHandler {
    var channel: FlutterEventChannel?
    var count = 0
    var events: FlutterEventSink?
    var timer: Timer?
    
    public override init() {
        super.init()
    }
    
    convenience init(messenger: FlutterBinaryMessenger) {
        self.init()
        
        channel = FlutterEventChannel(name: "com.mufeng.flutterNativeChannel.EventChannel", binaryMessenger: messenger)
        channel?.setStreamHandler(self)
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,selector: #selector(self.tickDown),userInfo: nil,repeats: true)
    }
    
    @objc func tickDown(){
        count += 1
        let args = ["count": count]
        if(events != nil){
            events!(args)
        }
        if(count >= 30){
            if(events != nil){
                events!(FlutterError.init(code: "400", message: "超过30秒,倒计时结束", details: nil))
            }
            timer?.fireDate = Date.distantFuture
            timer?.invalidate()
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.events = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.events = nil
        timer?.invalidate()
        self.timer = nil
        return nil
    }
}
