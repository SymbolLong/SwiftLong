//
//  DependComponentPickerViewController.swift
//  Picker
//
//  Created by 张圣龙 on 16/1/4.
//  Copyright © 2016年 张圣龙. All rights reserved.
//

import UIKit

class DependComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Properties
    private let provinceComponent = 0
    private let cityComponent = 1
    private let districtComponent = 2
    private var dict = [String: [[String:[String]]]]()
    private var provinces = [String]()
    private var cities = [String]()
    private var districts = [String]()
    private var provinceCities = [String: [String]]()
    private var cityDistricts = [String: [String]]()
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = NSBundle.mainBundle()
        let plistURL = bundle.URLForResource("Address", withExtension: "plist")
        
        dict = NSDictionary(contentsOfURL: plistURL!) as! [String: [[String:[String]]]]
        
        let allProvinces = dict.keys
        provinces = allProvinces.sort()
        
        let selectedProvince = provinces.first!
        let allCities = dict[selectedProvince]!.first!.keys
        cities = allCities.sort()
        
        let selectedCity = cities.first!
        districts = dict[selectedProvince]!.first![selectedCity]!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Delegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == provinceComponent {
            return provinces[row]
        } else if component == cityComponent {
            return cities[row]
        } else {
            return districts[row]
        }
    }
   
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == provinceComponent {
            let selectedProvince = provinces[row]
            cities = dict[selectedProvince]!.first!.keys.sort()
            pickerView.reloadComponent(cityComponent)
            pickerView.selectRow(0, inComponent: cityComponent, animated: true)
            let selectedCity = cities.first!
            districts = dict[selectedProvince]!.first![selectedCity]!
            pickerView.reloadComponent(districtComponent)
        } else if component == cityComponent {
            let provinceRow = pickerView.selectedRowInComponent(provinceComponent)
            let selectedProvince = provinces[provinceRow]
            let selectedCity = cities[row]
            districts = dict[selectedProvince]!.first![selectedCity]!
            pickerView.reloadComponent(districtComponent)
            pickerView.selectRow(0, inComponent: districtComponent, animated: true)
        }
    }
    
    // MARK:  DataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == provinceComponent {
            return provinces.count
        } else if component == cityComponent {
            return cities.count
        }else {
            return districts.count
        }
    }
    
    // MARK: Action
    
    @IBAction func btnPressed(sender: UIButton) {
        
        let provinceRow = pickerView.selectedRowInComponent(provinceComponent)
        let cityRow = pickerView.selectedRowInComponent(cityComponent)
        let districtRow = pickerView.selectedRowInComponent(districtComponent)
        
        let province = provinces[provinceRow]
        let city = cities[cityRow]
        let district = districts[districtRow]
        
        let msg = "您选择了：\(province)--\(city)--\(district)"
        let alertVC = UIAlertController(title: "All Done", message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Well Done", style: .Default, handler: nil)
        alertVC.addAction(action)
        presentViewController(alertVC, animated: true, completion: nil)
    }
    


}
