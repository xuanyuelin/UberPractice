//
//  UserInfoPage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/19.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class UserInfoPage: BasePage,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var userView:UIView!
    var imgPage:UIImagePickerController?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "用户信息"
        userView.layer.cornerRadius = 10
        userView.layer.masksToBounds = true
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
        setNavigationItem(title: "返回", selector: #selector(doBack), isRight: false)
        setNavigationItem(title: "下一步", selector: #selector(doNext), isRight: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func doBack() {
        self.navigationController?.popViewController(animated: true)
    }
    override func doNext() {
        let page = PayPage()
        self.navigationController?.pushViewController(page, animated: true)
    }
    @IBAction func buttonClick(){
        imgPage = UIImagePickerController()
        imgPage?.sourceType = .photoLibrary
        imgPage?.delegate = self
        self.present(imgPage!, animated: true, completion: nil)
    }
//    func imagePickerController(picker: UIImagePickerController,
//    didFinishPickingImage image: UIImage,
//    editingInfo: [String : AnyObject]?) {
//        headImage.image = image
//        picker.dismiss(animated: true, completion: nil)
//    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        headImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
}
