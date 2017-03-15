//
//  SingleComponentPickerViewController.swift
//  Picker
//
//  Created by 张圣龙 on 16/1/4.
//  Copyright © 2016年 张圣龙. All rights reserved.
//

import UIKit

class SingleComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Properties
    @IBOutlet weak var singlePicker: UIPickerView!
    let letters = ["a","b","c","d","e"]
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: DataSource

    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return letters.count;
    }
    
    // MARK: Action
    @IBAction func btnPressed(sender: UIButton) {
        let row = singlePicker.selectedRowInComponent(0)
        let selected = letters[row]
        let title = "You have selected \(selected)"
        let alertVC = UIAlertController(title: title, message: "Thank you for choosing", preferredStyle: .Alert)
        let action = UIAlertAction(title: "You are welcome", style: .Default, handler: nil)
        alertVC.addAction(action)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    // MARK: Delegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return letters[row]
    }

}
