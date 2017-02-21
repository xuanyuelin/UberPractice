//
//  GuidePage.swift
//  Uber
//
//  Created by 小儿黑挖土 on 2017/2/17.
//  Copyright © 2017年 小儿黑挖土. All rights reserved.
//

import UIKit
import AVFoundation

class GuidePage: BasePage {

    @IBOutlet var backImg:UIImageView!
    var player:AVPlayer!
    var playerItem:AVPlayerItem!
    var location:GLocation?//需声明为全局变量，方法内调用完被释放，一闪而过
    override func viewDidLoad() {
        super.viewDidLoad()

//        initPlayVideo()
//        doAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func doAnimation()
    {
        var images:[UIImage]=[]
        var image:UIImage?
        var imageName:String?
        
        for index in 0...67{
            imageName = "logo-" + String(format: "%03d", index)
            image = UIImage(named: imageName!)
            
            images.insert(image!, at: index)
        }
        
        backImg.animationImages = images
        backImg.animationRepeatCount = 1
        backImg.animationDuration = 5
        
        backImg.startAnimating()
        
        UIView.animate(withDuration: 0.7, delay:5, options: .curveEaseIn, animations: {
            self.backView.alpha = 1.0
            self.player.play()
        }, completion: {
            finished in
            print("Animation End")
        })
    }
    
    func initPlayVideo ()
    {
        let path = Bundle.main.path(forResource: "welcome_video", ofType: "mp4")
        let url = NSURL.fileURL(withPath: path!)
        
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = backView.bounds
        playerLayer.videoGravity =  AVLayerVideoGravityResizeAspect
        
        backView.layer.insertSublayer(playerLayer, at: 0)
        backView.alpha = 0.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    func didFinishVideo(sender:NSNotification){
        let item = sender.object as! AVPlayerItem
        item.seek(to: kCMTimeZero)
        player.play()
    }

    @IBAction func doLogin(_ sender: UIButton) {
        location = GLocation()
        location?.startLocation()
    }
    @IBAction func doRegister(_ sender: UIButton) {
        let page = CreateAccountPage()
        let navPage = UINavigationController(rootViewController: page)
        self.present(navPage, animated: true, completion: nil)
    }
}
