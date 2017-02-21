//
//  VerifyPhonePage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/20.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class VerifyPhonePage: BasePage {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "手机验证"
        setNavigationItem(title: "Close.png", selector: #selector(doBack), isRight: false)
    }
    override func doBack() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func doChangeField(field:UITextField){
        field.resignFirstResponder()
        
        if (field.text?.isEmpty)!{
            if field.tag>101{
                let preField = self.view.viewWithTag(field.tag-1)
                preField?.becomeFirstResponder()
            }
        }else{
            if field.tag<104{
                let nextField = self.view.viewWithTag(field.tag+1)
                nextField?.becomeFirstResponder()
            }
            
            if field.tag == 104{
                showIndicator(tipMsg: "验证", hide: true, afterDelay: true)
                self.perform(#selector(doShowHomePage), with: nil, afterDelay: 1)
            }
        }
    }
    func doShowHomePage(){
        let page = HomePage()
        let navPage = UINavigationController(rootViewController: page)
        self.present(navPage, animated: true, completion: nil)
    }
}
