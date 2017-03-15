//
//  ViewController.swift
//  Simple Table
//
//  Created by 张圣龙 on 16/1/6.
//  Copyright © 2016年 张圣龙. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    private let simpleIdentifier = "SimpleIdentifier"
    private let dwarves = ["Sleepy","Sneezy","Bashful",
        "Happy","Doc","Grumpy","Dopey",
        "Thorin","Dorin","Nori",
        "Ori","Balin","Dwalin","Fili","kili",
        "Oin","Gloin","Bifur","Bofur","Bombur","ZhangSL"]
    

    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Datasource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleIdentifier) as UITableViewCell?
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: simpleIdentifier)
        }
        cell!.textLabel?.text = dwarves[indexPath.row]
        let image = UIImage(named: "star_normal")!
        let highlightImage = UIImage(named: "star_highlight")!
        cell!.imageView?.image = image
        cell!.imageView?.highlightedImage = highlightImage
        
        if indexPath.row % 2 == 0 {
            cell!.detailTextLabel?.text = "李亚"
        } else {
            cell!.detailTextLabel?.text = "圣龙"
        }
        //cell!.textLabel?.font = UIFont.boldSystemFontOfSize(20)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dwarves.count
    }
    
    // MARK: Delegate
    
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return indexPath.row % 1// 可以进行缩进
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.row == 0 {
            return nil
        } else {
            return indexPath
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let title = dwarves[indexPath.row]
        let alertVC = UIAlertController(title: title, message: "You are so cool", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Cool", style: .Default, handler: nil)
        alertVC.addAction(action)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row % 2 == 0 ? 80 : 50
    }


}

