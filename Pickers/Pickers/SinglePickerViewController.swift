//
//  SinglePickerViewController.swift
//  Pickers
//
//  Created by 张圣龙 on 2016/11/20.
//  Copyright © 2016年 张圣龙. All rights reserved.
//

import UIKit

class SinglePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let names = ["老赵","小钱","小孙","老李","老周","老吴","老郑","老王"]

    @IBOutlet weak var singlePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tip(_ sender: UIButton) {
        let row = singlePicker.selectedRow(inComponent: 0);
        let selected = names[row]
        let title = "你的选择是\(selected)"
        let alert = UIAlertController(title: "提示", message: title, preferredStyle: .alert)
        let action = UIAlertAction(title: "就是TA了", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true
            , completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return names[row]
    }
    

   

}
