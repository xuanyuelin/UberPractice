//
//  EditUserPage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/20.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class EditUserPage: BasePage {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "用户编辑"
        setNavigationItem(title: "返回", selector: #selector(doBack), isRight: false)
    }
    override func doBack() {
        self.navigationController?.popViewController(animated: true)
    }

}
