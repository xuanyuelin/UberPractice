//
//  YinLianPage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/21.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class YinLianPage: BasePage,UPPayPluginDelegate,NSURLConnectionDataDelegate{

    var responseData:NSMutableData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "银联测试"
        setNavigationItem(title: "Close.png", selector: #selector(doBack), isRight: false)
    }

    @IBAction func doPay(){
        let url = URL(string: URL_TN_Normal)
        startPay(url: url!)
    }
    func startPay(url:URL){
        let urlRequest = URLRequest(url: url)
        //nsurlconnection弃用后不走代理？？？？？
        let connect = NSURLConnection(request: urlRequest, delegate: self)
        connect?.start()
    }
    //支付回调函数
    func upPayPluginResult(_ result: String!) {
        GLog(message: result)
    }
//    MARK:-nsurlConnectionDelegate
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        let urlResponse = response as! HTTPURLResponse
        
        if urlResponse.statusCode != 200 {
            GLog(message: "error status code")
        }
        else {
            responseData = NSMutableData()
        }
    }
    
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        responseData?.append(data as Data)
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        let result = String(data: responseData! as Data, encoding: String.Encoding.utf8)
        
        if result != nil {
            FxPayPlugin.startPayFx(result, mode: "01", viewController: self, delegate: self)
        }
    }
    
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        GLog(message: error.localizedDescription)
    }
}
