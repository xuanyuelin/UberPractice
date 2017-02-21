//
//  BasePage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/17.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class BasePage: BaseViewCtr {

    @IBOutlet var backView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavigationItem(title:String,selector:Selector,isRight:Bool){
        let item:UIBarButtonItem!
        if title.hasSuffix(".png"){
            item = UIBarButtonItem(image: UIImage.init(named: title), style: .plain, target: self, action: selector)
        }else{
            item = UIBarButtonItem(title: title, style: .plain, target: self, action: selector)
        }
        if isRight{
            self.navigationItem.setRightBarButton(item, animated: true)
        }else{
            self.navigationItem.setLeftBarButton(item, animated: true)
        }
    }
}
