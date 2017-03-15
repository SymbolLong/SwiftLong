//
//  DatePickerViewController.swift
//  Picker
//
//  Created by 张圣龙 on 16/1/4.
//  Copyright © 2016年 张圣龙. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        let date = NSDate()
        datePicker.setDate(date, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPressed(sender: UIButton) {
        let date = datePicker.date
        let msg = "The date and time you selected is \(date)"
        let alertVC = UIAlertController(title: "Date and Time selected", message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "That's so true!", style: .Default, handler: nil)
        alertVC.addAction(action)
        presentViewController(alertVC, animated: true, completion: nil)
    }


}
