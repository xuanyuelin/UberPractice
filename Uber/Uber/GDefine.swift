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
/*
 #define kURL_TN_Normal                @"http://101.231.204.84:8091/sim/getacptn"
 #define kURL_TN_Configure             @"http://101.231.204.84:8091/sim/app.jsp?user=123456789"
 */
let URL_TN_Normal = "http://101.231.204.84:8091/sim/getacptn"
let URL_TN_Configure = "http://101.231.204.84:8091/sim/app.jsp?user=123456789"

func GLog(message:String,function:String = #function){
    #if DEBUG
        print("Log:\(message),\(function)")
    #else
//        print("it is release version")
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
func getFirstCharFromString(str:String)->String{
//    //转成了可变字符串
//    NSMutableString *str = [NSMutableString stringWithString:aString];
//    //先转换为带声调的拼音
//    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
//    //再转换为不带声调的拼音
//    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
//    //转化为大写拼音
//    NSString *pinYin = [str capitalizedString];
//    //获取并返回首字母
//    return [pinYin substringToIndex:1];
    let mutableStr = NSMutableString.init(string: str)
    CFStringTransform(mutableStr as CFMutableString,nil, kCFStringTransformMandarinLatin,false)
    CFStringTransform(mutableStr as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
    let resultStr:NSString = mutableStr.capitalized as NSString
    return resultStr.substring(to: 1)
}
