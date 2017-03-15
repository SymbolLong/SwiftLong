//
//  DobuleComponentPickerViewController.swift
//  Picker
//
//  Created by 张圣龙 on 16/1/4.
//  Copyright © 2016年 张圣龙. All rights reserved.
//

import UIKit

class DobuleComponentPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Properties
    let first = 0
    let second = 1
    
    let firstArray = ["1","2","3","4","5","6"]
    let secondArray = ["A","B","C","D","E","F","G"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == first {
            return firstArray.count
        } else if component == second {
            return secondArray.count
        }
        return 0
    }
    
    // MARK: Delegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == first {
            return firstArray[row]
        }else if component == second {
            return secondArray[row]
        }
        return "NULL"
    }
    
    // MARK: Action
    
    @IBAction func btnPressed(sender: UIButton) {
        let firstRow = pickerView.selectedRowInComponent(first)
        let secondRow = pickerView.selectedRowInComponent(second)
        let title = firstArray[firstRow]
        let msg = secondArray[secondRow]
        
        let alertVC = UIAlertController(title: "First is \(title)", message: "Second is \(msg)", preferredStyle: .Alert)
        let action = UIAlertAction(title: "So Cool!", style: .Default, handler: nil)
        alertVC.addAction(action)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    
    
    

}
