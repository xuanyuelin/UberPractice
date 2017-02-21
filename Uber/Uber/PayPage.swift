//
//  PayPage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/20.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class PayPage: BasePage ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet var _tableview:UITableView!
    var dataArr:[PayInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择支付方式"
        setNavigationItem(title: "返回", selector: #selector(doBack), isRight: false)
        setNavigationItem(title: "手机验证", selector: #selector(doVerifyPhone), isRight: true)
        initDatas()
        
        _tableview.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        _tableview.delegate = self
        _tableview.dataSource = self
        _tableview.reloadData()
    }
    override func doBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func doVerifyPhone() {
        let page = VerifyPhonePage()
        self.navigationController?.pushViewController(page, animated: true)
    }
    func initDatas(){
        let dic = ["百度钱包":"BaiDuWallet",
                   "银联":"YinLian",
                   "支付宝":"AliPay",
                   "国际信用卡":"CreditCard"]
        dataArr = []
        
        for (key,value) in dic{
            let tempInfo = PayInfo()
            tempInfo.name = key
            tempInfo.png = value
            dataArr?.append(tempInfo)
        }
    }
//    MARK:-tableviewDelegate&&datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = _tableview.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.imageView?.image = UIImage(named:dataArr![indexPath.row].png)
        cell.accessoryType = UITableViewCellAccessoryType.none
        cell.textLabel?.text = dataArr![indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 2){
            let page = YinLianPage()
            let navPage = UINavigationController(rootViewController: page)
            self.present(navPage, animated: true, completion: nil)
        }
    }
}
