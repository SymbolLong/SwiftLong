//
//  ViewController.swift
//  ShakeImage
//
//  Created by 张圣龙 on 2017/2/9.
//  Copyright © 2017年 张圣龙. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dislike: UIButton!
    let MAX = 10
    var count = 0
    var interval: TimeInterval = 5
    var fileManager = FileManager()
    var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    
    var host = "http://10.1.2.23:8888/picture/order"
    var hostAvailable = true
    var timer: Timer?
    var shaking = false
    var id = UserDefaults.standard.integer(forKey: "id")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //屏幕保持常亮
        UIApplication.shared.isIdleTimerDisabled = true
        
        //获取分辨率
        /**
        let scale = UIScreen.main.scale
        let width = Int(UIScreen.main.bounds.width * scale)
        let height = Int(UIScreen.main.bounds.height * scale)
        host = "\(host)?width=\(width)&height=\(height)"
        */
        //使用Shake模块
        UIApplication.shared.applicationSupportsShakeToEdit = true
        becomeFirstResponder()
        //手势
        addGesture()
        
        //使用定时器
        setTimer(interval: interval)
        
    }
    
    //开始摇晃手机
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        setTimer(interval: 0)
    }
    //结束摇晃手机
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        nextImage()
    }
    
    func preImage(){
        count -= 1
        if count < 0 {
            count = 9
        }
        let name = "timg-\(count % MAX)"
        if let data = NSData(contentsOfFile:"\(path)/\(name)"){
            imageView.image = UIImage(data: data as Data)
        }else{
            imageView.image = UIImage(named: name)
        }
    }
    
    func nextImage(){
        var downloadId = 0;
        if count % MAX == 0 {
            for i in 5...9{
                downloadId += 1
                let loadURL = URL(string: host+"?id=\(id+downloadId)")!
//                print(loadURL)
                downloadImage(manager: fileManager,path: "\(path)/timg-\(i)",url: loadURL)
            }
        }else if count % MAX == 5 {
            for i in 0...4 {
                downloadId += 1
                let loadURL = URL(string: host+"?id=\(id+downloadId)")!
//                print(loadURL)
                downloadImage(manager: fileManager,path: "\(path)/timg-\(i)",url: loadURL)
            }
        }
        
        id += 1
        UserDefaults.standard.set(id, forKey: "id")

        count += 1
        if count >= MAX {
            count = 0
        }
        
        let name = "timg-\(count % MAX)"
//        print("Image name \(name)")
        if let data = NSData(contentsOfFile:"\(path)/\(name)"){
            imageView.image = UIImage(data: data as Data)
        }else{
            imageView.image = UIImage(named: name)
        }
    }
    
    private func downloadImage(manager: FileManager,path: String,url: URL){
//        print(host)
        if(!hostAvailable){
            return;
        }
        // 使用网络请求异步加载data并保存
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil{
                self.hostAvailable = false;
                DispatchQueue.main.async(execute: {
                    let alert = UIAlertController(title: "提示", message: "服务器维护中....", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "坐等恢复", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true,completion: nil)
                })
            }else{
                //保存图片
                manager.createFile(atPath: path, contents: data!, attributes: nil)
            }
        })
        task.resume()
    }
    
  
    //添加手势
    func addGesture(){
        
        let tap2 = UITapGestureRecognizer(target: self, action:#selector(self.tap2Gesture(sender:)))
        //设置手势点击数,双击
        tap2.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tap2)
        //长按
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.handlLongPress(sender:)))
        self.view.addGestureRecognizer(longPress)
        
        //上下左右
        let faster = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(sender:)))
        faster.direction = .up
        self.view.addGestureRecognizer(faster)
        
        let slower = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(sender:)))
        slower.direction = .down
        self.view.addGestureRecognizer(slower)
        
        let pre = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(sender:)))
        pre.direction = .right
        self.view.addGestureRecognizer(pre)
        
        let next = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeGesture(sender:)))
        next.direction = .left
        self.view.addGestureRecognizer(next)
        
    }
    
    //双击屏幕保存到相册
    func tap2Gesture(sender: UITapGestureRecognizer){
//        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, nil, nil)
        hostAvailable = true
        shaking = false
        id = 1
        setTimer(interval: interval)
    }
    //长按重置
    func handlLongPress(sender: UILongPressGestureRecognizer){
        hostAvailable = true
        shaking = false
        setTimer(interval: interval)
    }
    
    //加速||减速播放，上一张||下一张
    func swipeGesture(sender: UISwipeGestureRecognizer){
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.up:
            interval -= 1
            if interval < 1 {
                interval = 1
            }
            setTimer(interval: interval)
        case UISwipeGestureRecognizerDirection.down:
            interval += 1
            if interval > 10 {
                interval = 10
            }
            setTimer(interval: interval)
        case UISwipeGestureRecognizerDirection.left:
            setTimer(interval: 0)
            nextImage()
        case UISwipeGestureRecognizerDirection.right:
            setTimer(interval: 0)
            preImage()
        default:
            print("error")
        }
    }
    
    func setTimer(interval: TimeInterval){
        if timer != nil {
            timer!.invalidate()
        }
        if  interval > 0 {
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.nextImage), userInfo: nil, repeats: true)
        }
    }
    
    
    @IBAction func disLike(_ sender: UIButton) {
        let loadURL = URL(string: "http://10.1.2.23:8888/picture/fix?id=\(id)")!
//        print(loadURL)
        let session = URLSession.shared
        let task = session.dataTask(with: loadURL)

        task.resume()
    }
    
    //-----系统级别
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true;
    }
    
    
    
}

