//
//  HomePage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/20.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class HomePage: BasePage {

    var isShowLeft:Bool = false
    var leftView:UIView!
    var rightButton:UIButton!
    var centerPage:UserCenterPage?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "主页"
        setNavigationItem(title: "account_icon_up@2x.png", selector: #selector(doShowLeft), isRight: false)
        
        leftView = UIView(frame: CGRect(x: -self.view.frame.size.width+100, y: 0, width: self.view.frame.size.width-100, height: self.view.frame.size.height))
        rightButton = UIButton(frame: CGRect(x: self.view.frame.size.width-100, y: 0, width: 100, height: self.view.frame.size.height))
        rightButton.backgroundColor = UIColor.darkGray
        rightButton.alpha = 0
        leftView.backgroundColor = UIColor.black
        rightButton.addTarget(self, action: #selector(doShowMain), for: .touchUpInside)
        self.view.addSubview(leftView)
        self.view.addSubview(rightButton)
    }

    func doShowLeft(){
        
        centerPage = UserCenterPage()
        centerPage?.view.frame = leftView.bounds
        centerPage?.owner = self
        leftView.addSubview(centerPage!.view)
        
        isShowLeft = true
        let transform = CGAffineTransform(translationX: self.view.frame.size.width-100, y: 0)
        self.navigationController?.navigationBar.isHidden = true
        UIView.animate(withDuration: 0.7) { 
            self.leftView.transform = transform
//            self.view.transform = transform
            self.rightButton.alpha = 0.7
        }
    }
    func doShowMain(){
        isShowLeft = false
        self.navigationController?.navigationBar.isHidden = false
        UIView.animate(withDuration: 0.7) {
            self.leftView.transform = CGAffineTransform.identity
//            self.view.transform = CGAffineTransform.identity
            self.rightButton.alpha = 0
        }
    }
    func doSettings(){
        doShowMain()
        let page = EditUserPage()
        self.navigationController?.pushViewController(page, animated: true)
    }

}
