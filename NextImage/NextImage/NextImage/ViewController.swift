//
//  ViewController.swift
//  NextImage
//
//  Created by 张圣龙 on 2017/2/15.
//  Copyright © 2017年 张圣龙. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //初始化信息
    let MAX = 10
    let HOST = "http://192.168.31.133:8888/bizhi/random"
    //var HOST = "http://qq877857078.oicp.net/picture/random";
    let FILEMANAGER = FileManager()
    var count = 0
    var path = ""
    var hostFlag = true
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //保持常亮
        UIApplication.shared.isIdleTimerDisabled = true
        //初始化Path
        path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        //添加手势
        let preGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.preGesture(sender:)))
        preGesture.direction = .right
        self.view.addGestureRecognizer(preGesture)
        let nextGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.nextGesture(sender:)))
        nextGesture.direction = .left
        self.view.addGestureRecognizer(nextGesture)
        //是否有缓存图片
        if let data = NSData(contentsOfFile: "\(path)/\(count)"){
            imageView.image = UIImage(data:  data as Data)
        }else{
            for i in 0...9{
                downloadImage(manager: FILEMANAGER,path: "\(path)/\(i)")
            }
        }
    }
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func preGesture(sender: UISwipeGestureRecognizer){
//        print("previous")
        count -= 1
        changeImage()
    }
    
    func nextGesture(sender: UISwipeGestureRecognizer){
//        print("next")
        count += 1
        if count == 9 {
            for i in 0...9{
                downloadImage(manager: FILEMANAGER,path: "\(path)/\(i)")
            }
        }
        changeImage()
    }
    
    func changeImage(){
        if count < 0 {
            count = 9
        }else if count >= MAX {
            count = 0
        }
        let name = count % MAX
        if let data = NSData(contentsOfFile: "\(path)/\(name)"){
            imageView.image = UIImage(data:  data as Data)
        }else {
            imageView.image = UIImage(named: "\(name)")
        }
    }
    
    private func downloadImage(manager: FileManager,path: String){
        if(!hostFlag){
            return;
        }
        // 使用网络请求异步加载data并保存
        let loadURL = URL(string: HOST)!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: loadURL, completionHandler: { (data, response, error) in
            if error != nil{
                self.hostFlag = false;
                DispatchQueue.main.async(execute: {
                    let alert = UIAlertController(title: "提示", message: "服务器维护中....", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "静候佳音", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true,completion: nil)
                })
            }else{
                //保存图片
                manager.createFile(atPath: path, contents: data!, attributes: nil)
            }
        })
        task.resume()
    }
    
    
}

