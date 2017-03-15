//
//  CustomPickerViewController.swift
//  Picker
//
//  Created by 张圣龙 on 16/1/4.
//  Copyright © 2016年 张圣龙. All rights reserved.
//

import UIKit
import AudioToolbox

class CustomPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: Properties
    private var images = [UIImage]()
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var spinBtn: UIButton!
    private var winSoundID: SystemSoundID = 0
    private var crunchSoundID: SystemSoundID = 0
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images.append(UIImage(named: "seven")!)
        images.append(UIImage(named: "apple")!)
        images.append(UIImage(named: "cherry")!)
        images.append(UIImage(named: "crown")!)
        images.append(UIImage(named: "lemon")!)
        images.append(UIImage(named: "bar")!)
        winLabel.text = " "
        
        if winSoundID == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("win", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &winSoundID)
        }
        
        if crunchSoundID == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("crunch", withExtension: "wav")! as CFURLRef
            // print("\(soundURL)")
            AudioServicesCreateSystemSoundID(soundURL, &crunchSoundID)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Action
    @IBAction func spin(sender: UIButton) {
        var win = false
        var numInRow = -1
        var lastValue = -1
        
        for i in 0..<5 {
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            if newValue == lastValue {
                numInRow++
            } else {
                numInRow = 1
            }
            lastValue = newValue
            
            pickerView.selectRow(newValue, inComponent: i, animated: true)
            pickerView.reloadComponent(i)
            
            if numInRow >= 3 {
                win = true
            }
        }
        
        
        AudioServicesPlaySystemSound(crunchSoundID)
        
        if win {
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64( 0.5 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue())
                { [unowned self] in
                    self.playWinSound()
            }
        } else {
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue())
                { [unowned self] in
                self.showSpinButton()
            }
        }
        
        spinBtn.hidden = true
        winLabel.text = " "
    }
    
    // MARK: DataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return images.count - 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    // MARK: Delegate
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let image = images[row]
        return UIImageView(image: image)
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64
    }
    
    // MARK: Function
    
    func showSpinButton(){
        spinBtn.hidden = false
    }
    
    func playWinSound(){
        AudioServicesPlaySystemSound(winSoundID)
        winLabel.text = "Winner!"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))) , dispatch_get_main_queue()) { [unowned self] in
            self.showSpinButton()
        }
        
    }
    
    
}
