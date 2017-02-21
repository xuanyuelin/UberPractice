//
//  BaseViewCtr.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/17.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class BaseViewCtr: UIViewController {

    var activity:FxActivity?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func showActivityInView(view:UIView)->FxActivity{
        let tempActivity = FxActivityIndicator(view: view)
        tempActivity?.frame = view.bounds
        tempActivity?.labelText = ""
        view.addSubview(tempActivity!)
        return tempActivity!
    }
    func hideIndicator(){
        activity?.hide(true)
    }
    func showIndicator(tipMsg:String?,hide:Bool,afterDelay:Bool){
        if activity == nil{
            activity = showActivityInView(view: self.view)
        }
        if(tipMsg != nil){
            activity?.labelText = tipMsg
            activity?.show(false)
        }
        if(hide && (activity?.alpha)! == 1.0){
            if(afterDelay){
                activity?.hide(true, afterDelay: 2)
            }else{
                activity?.hide(true)
            }
        }
    }
    func doBack(){
        self.dismiss(animated: true, completion: nil)
    }
    func doNext(){
        
    }
}
