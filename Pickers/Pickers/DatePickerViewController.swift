//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by 张圣龙 on 2016/11/20.
//  Copyright © 2016年 张圣龙. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.setDate(Date(), animated: true)
        // Do any additional setup after loading the view.
    }
    @IBAction func showDate(_ sender: UIButton) {
        let date = datePicker.date
        let msg = "你选的时间是：\(date)"
        let alert = UIAlertController(title: "提示", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "知道了", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
