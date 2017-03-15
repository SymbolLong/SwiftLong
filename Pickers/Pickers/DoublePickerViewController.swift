//
//  DoublePickerViewController.swift
//  Pickers
//
//  Created by 张圣龙 on 2016/11/20.
//  Copyright © 2016年 张圣龙. All rights reserved.
//

import UIKit

class DoublePickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    @IBOutlet weak var doublePicker: UIPickerView!
    
    private static let names = ["小陈","小冯","小张","小俞","老白"]
    private static let moneys = ["100","150","200","250","300"]
    private let components = [names,moneys]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return components[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components[component].count
    }
    
    
    
    @IBAction func tip(_ sender: UIButton) {
        let firstIndex = doublePicker.selectedRow(inComponent: 0)
        let secondIndex = doublePicker.selectedRow(inComponent:
            1)
        let firstMsg = components[0][firstIndex]
        let secondMsg = components[1][secondIndex]
        let msg = "\(firstMsg)应发：\(secondMsg)元"
        let alert = UIAlertController(title: "提示", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "嗯", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
