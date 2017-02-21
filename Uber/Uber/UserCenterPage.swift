//
//  UserCenterPage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/20.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class UserCenterPage: BasePage {

    var owner:BasePage?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doSetting(_ sender: UIButton) {
        let own = owner as! HomePage
        own.doSettings()
    }
}
