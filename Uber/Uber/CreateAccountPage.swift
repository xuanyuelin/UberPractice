//
//  CreateAccountPage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/18.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class CreateAccountPage: BasePage,SelectCountryPageDelegate{

    @IBOutlet var button:UIButton!
    var page:SelectCountryPage?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "创建用户"
        setNavigationItem(title: "下一步", selector: #selector(doNext), isRight:true)
        setNavigationItem(title: "取消", selector: #selector(doBack), isRight:false)
        
        backView.layer.cornerRadius = 8
        backView.layer.masksToBounds = true
        
        page = SelectCountryPage()
        page?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func doNext(){
        let userPage = UserInfoPage()
        self.navigationController?.pushViewController(userPage, animated: true)
    }
    @IBAction func buttonClick(){
        
        self.navigationController?.pushViewController(page!, animated: true)
    }
    func didSelectCountry(code: String) {
//        button.setImage(UIImage.init(named:code), for: UIControlState.normal)
        button.setBackgroundImage(UIImage.init(named: code), for: .normal)
        button.setTitle("", for: .normal)
    }
}
