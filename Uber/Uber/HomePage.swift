//
//  HomePage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/20.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit

class HomePage: BasePage,BMKMapViewDelegate,BMKLocationServiceDelegate {

    var isShowLeft:Bool = false
    var leftView:UIView!
    var rightButton:UIButton!
    var centerPage:UserCenterPage?
    
    var _mapView:BMKMapView?
    var _coordinate:CLLocationCoordinate2D?
    var _annotation:BMKPointAnnotation?
    var _mapService:BMKLocationService?
    var _timer:Timer?
    
    @IBOutlet var _bottomView:UIView!
    @IBOutlet var _firstButton:UIButton!
    var isMoveUp:Bool!
    @IBOutlet var _backImageView:UIImageView!
    @IBOutlet var _spentLabel:UILabel!
    @IBOutlet var _destinationLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "主页"
        setNavigationItem(title: "account_icon_up@2x.png", selector: #selector(doShowLeft), isRight: false)
        self.navigationItem.titleView = UIImageView(image: UIImage(named:"logo_uber_grey_zh_CN@2x"))
        
//        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        leftView = UIView(frame: CGRect(x: -self.view.frame.size.width+100, y: 0, width: self.view.frame.size.width-100, height: self.view.frame.size.height))
        rightButton = UIButton(frame: CGRect(x: self.view.frame.size.width-100, y: 0, width: 100, height: self.view.frame.size.height))
        rightButton.backgroundColor = UIColor.darkGray
        rightButton.alpha = 0
        leftView.backgroundColor = UIColor.black
//        leftView.alpha = 0.7
        rightButton.addTarget(self, action: #selector(doShowMain), for: .touchUpInside)
        
        addMapview()
        self.view.addSubview(leftView)
        self.view.addSubview(rightButton)
        
        self.view.bringSubview(toFront: _bottomView)
        doClickCarBtn(sender: _firstButton)
        isMoveUp = false
        addTapGesture()
        _destinationLabel.text = "北京南站"
        _destinationLabel.isHidden = true
    }

    func doShowLeft(){
        
        centerPage = UserCenterPage()
        centerPage?.view.frame = leftView.bounds
        centerPage?.owner = self
        leftView.addSubview(centerPage!.view)
        
        isShowLeft = true
        let transform = CGAffineTransform(translationX: self.view.frame.size.width-100, y: 0)
        self.navigationController?.navigationBar.isHidden = true
        self.view.sendSubview(toBack: _bottomView)
//        self.navigationController?.view.bringSubview(toFront: rightButton)
        UIView.animate(withDuration: 0.7) {
            self.leftView.transform = transform
//            self.view.transform = transform
            self.rightButton.alpha = 0.7
//            self.navigationController?.navigationBar.frame.origin.x = self.view.frame.size.width-100
        }
    }
    func doShowMain(){
        isShowLeft = false
        self.navigationController?.navigationBar.isHidden = false
        self.view.bringSubview(toFront: _bottomView)
//        self.navigationController?.view.sendSubview(toBack: rightButton)
        UIView.animate(withDuration: 0.7) {
            self.leftView.transform = CGAffineTransform.identity
//            self.view.transform = CGAffineTransform.identity
            self.rightButton.alpha = 0
//            self.navigationController?.navigationBar.frame.origin.x = 0
        }
    }
    func doSettings(){
        doShowMain()
        let page = EditUserPage()
        self.navigationController?.pushViewController(page, animated: true)
    }
    @IBAction func doClickCarBtn(sender:UIButton){
        for i in 21...24{
            let tempBtn:UIButton = self.view.viewWithTag(i) as! UIButton
            tempBtn.setImage(nil, for: UIControlState.normal)
        }
        sender.setImage(UIImage(named:"CarBtn"), for: UIControlState.normal)
    }
    func addTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(doMoveup))
        _bottomView.addGestureRecognizer(tap)
    }
    func doMoveup(){
        isMoveUp = !isMoveUp
        bottomViewAnimation(flag: isMoveUp)
    }
    func bottomViewAnimation(flag:Bool){
        var frame = _bottomView.frame
        if flag{
            frame.origin.y = self.view.frame.size.height-_bottomView.frame.size.height
        }else{
            frame.origin.y = self.view.frame.size.height-80
            
            let sender:UIButton = self.view.viewWithTag(25) as! UIButton
            sender.isHidden = false
            _destinationLabel.isHidden = true
            _backImageView.image = UIImage(named:"CarInfoBack")
            _spentLabel.text = "￥20-40"
        }
        _bottomView.frame = frame
    }
    @IBAction func doClickSpentBtn(sender:UIButton){
        sender.isHidden = true
        _destinationLabel.isHidden = false
        _backImageView.image = UIImage(named:"FeiYongBack@2x")
        _spentLabel.text = "￥60-100"
    }
}
