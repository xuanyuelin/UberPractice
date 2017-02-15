//
//  GDefine.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/15.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import Foundation
import UIKit

let iOS8:Float = 8.0

func GLog(message:String,function:String = #function){
    #if DEBUG
        print("Log:\(message),\(function)")
    #else
        print("it is release version")
    #endif
}
func isSystemEqualOrGreateriOS8()->Bool{
    #if os(iOS)
        GLog(message: "iOS")
    #else
    #endif
    let version = UIDevice.current.systemVersion as NSString;
    if(version.floatValue>=iOS8){
        return true
    }
    return false
}
