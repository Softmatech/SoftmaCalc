//
//  SettingsViewController.swift
//  SoftmaCalc
//
//  Created by Joseph Andy Feidje on 8/25/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var segment: UISegmentedControl!
    let defaults = UserDefaults.standard
    var segSel = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SoftmaCalc"
        segment.selectedSegmentIndex = defaults.integer(forKey: "mySel")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ValuesChanged(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0
        {
            segSel = 0
        }
        if segment.selectedSegmentIndex == 1
        {
            segSel = 1
        }
        if segment.selectedSegmentIndex == 2
        {
            segSel = 2
        }
        defaults.set(segSel, forKey: "mySel")
        segment.selectedSegmentIndex = defaults.integer(forKey: "mySel")
        defaults.synchronize()
        print("defffff --->> ",defaults.integer(forKey: "mySel"))
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
