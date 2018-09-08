//
//  SettingsViewController.swift
//  SoftmaCalc
//
//  Created by Joseph Andy Feidje on 8/25/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    let defaults = UserDefaults.standard
    let currencyData = ["Haïti -- HT G","USA -- USD $","Europe -- EUR €","Canada -- CAD $","Dominican Republique -- DOP $","Hongkong -- HKD $","Brazil -- BRL $"]
    var segSel = 0
    var currencySelected = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencySelected = currencyData[row]
        defaults.set(currencySelected, forKey: "myCurrency") //assign the select currency to save
//        segment.selectedSegmentIndex = defaults.integer(forKey: "mySel")//set the segment to the default
        print("***************************",defaults.string(forKey: "myCurrency") ?? "$-")
        defaults.synchronize() //here the default currency is saved for posterior usage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SoftmaCalc 2" //the title
        self.pickerView?.dataSource = self
        self.pickerView?.delegate = self
        currencySelected = defaults.string(forKey: "myCurrency")!
        
        print("-------------curr:",currencySelected)
        segment.selectedSegmentIndex = defaults.integer(forKey: "mySel") //select the saved default tip
        // Do any additional setup after loading the view.
    }

        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        
    @IBAction func ValuesChanged(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 //for the first segement select
        {
            segSel = 0
        }
        if segment.selectedSegmentIndex == 1 //for the second segement select
        {
            segSel = 1
        }
        if segment.selectedSegmentIndex == 2 //for the third segement select
        {
            segSel = 2
        }
        defaults.set(segSel, forKey: "mySel") //assign the select segment to save
        segment.selectedSegmentIndex = defaults.integer(forKey: "mySel")//set the segment to the default
        defaults.synchronize() //here the default tip is saved for posterior usage
    }
    
}



