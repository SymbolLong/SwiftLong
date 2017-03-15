//
//  DependPickerViewController.swift
//  Pickers
//
//  Created by 张圣龙 on 2016/11/20.
//  Copyright © 2016年 张圣龙. All rights reserved.
//

import UIKit

class DependPickerViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    private let PROVINCE = 0
    private let CITY = 1
    
    
    private var map: [String:AnyObject]!
    private var provinces: [String]!
    private var cities: [String]!
    @IBOutlet weak var dependPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle.main
        let plistUrl = bundle.url(forResource: "address", withExtension: "plist")!
        map = NSDictionary(contentsOf: plistUrl) as! [String: AnyObject]
        
        
        
        provinces = map.keys.sorted()
        let temp = map[provinces[0]] as! [String: AnyObject]
        cities = temp.keys.sorted()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case PROVINCE:
            return provinces.count
        case CITY:
            return cities.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case PROVINCE:
            return provinces[row]
        case CITY:
            return cities[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == PROVINCE {
            let province = provinces[row]
            let tem = map[province] as! [String: AnyObject]
            cities = tem.keys.sorted()
            dependPicker.reloadComponent(CITY)
             dependPicker.selectRow(0, inComponent: CITY, animated: true)
            
        }
    }
    
    
    
    @IBAction func tip(_ sender: UIButton) {
        let provinceIndex = dependPicker.selectedRow(inComponent: PROVINCE)
        let cityIndex = dependPicker.selectedRow(inComponent: CITY)
        
        let provinceName = provinces[provinceIndex]
        let cityName = cities[cityIndex]
        let msg = "你想去：\(provinceName)->\(cityName)"
        
        let alert = UIAlertController(title: "提示", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "是的", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }



}
