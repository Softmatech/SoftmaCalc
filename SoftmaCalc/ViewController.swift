//
//  ViewController.swift
//  SoftmaCalc
//
//  Created by Joseph Andy Feidje on 8/23/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var seg: UISegmentedControl!
    @IBOutlet weak var labelThree: UILabel!
    let defaults = UserDefaults.standard
    var mySelect = 0;
    
    var labelNumber:Double = 0 // to take the number on screen
    var lastScreenString:String = "" // to take the last screen Number
    var varDelete:String = ""
    var tipValue:Double = 0
    var Total:Double = 0
    var tipTotal:Double = 0
    
    @IBAction func ValuesChanged(_ sender: UISegmentedControl) {
                if seg.selectedSegmentIndex == 0 {
                    tipValue = 10
                    print("Option 1----",tipValue)
                }
                else if seg.selectedSegmentIndex == 1 {
                    tipValue = 20
                    print("Option 2----",tipValue)
                }
                else if seg.selectedSegmentIndex == 2 {
                    tipValue = 30
                    print("Option 3----",tipValue)
                }
        tipCalculator(amount: labelNumber)
    }

    func tipCalculator(amount:Double){
        tipTotal = ((amount * tipValue)/100)
        Total = amount + tipTotal
        labelTwo.text = "Total = "+String(Total)+"$"
        labelThree.text = "Tip = "+String(tipTotal)+"$"
    }
    
    @IBAction func numbersAction(_ sender: UIButton) {

            labelNumber = Double(label.text!)! //label number convert the label text
            // the label receive the number pressed by the user and convert it
            if sender.tag == 12
            {
                label.text = label.text! + "."
            }
            else if sender.tag != 11 || sender.tag != 12
                {
                    if label.text == "0"
                    {
                        label.text = ""
                    }
                label.text = label.text! + String(sender.tag - 1) //label take the number hited
                labelNumber = Double(label.text!)! // convert the label string
                }
        tipCalculator(amount: labelNumber)
    }
    
    @IBAction func setButton(_ sender: UIButton) {
        lastScreenString = label.text!
        if sender.tag == 11
        {
            let arrayCharacter = Array(lastScreenString)
            print("char----",arrayCharacter)
            for n in 0..<arrayCharacter.count - 1 {
                print("nn----",n)
                varDelete += String(arrayCharacter[n])
            }
            print(varDelete)
            label.text = varDelete
            varDelete = ""
            zeroFunc()
            labelNumber = Double(label.text!)!
            print("label-------",labelNumber)
            tipCalculator(amount: labelNumber)
        }
    }
    
    func zeroFunc(){
        if (label.text?.isEmpty)!
        {
            label.text = "0"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SoftmaCalc"
        mySelect = defaults.integer(forKey: "mySel")
        // Do any additional setup after loading the view, typically from a nib.
        zeroFunc() // to print the zero on screen at begining
        labelTwo.text = ""
        seg.selectedSegmentIndex = mySelect
        ValuesChanged(seg)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        mySelect = defaults.integer(forKey: "mySel")
        seg.selectedSegmentIndex = mySelect
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        mySelect = defaults.integer(forKey: "mySel")
        seg.selectedSegmentIndex = mySelect
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
        mySelect = defaults.integer(forKey: "mySel")
        seg.selectedSegmentIndex = mySelect
    }
    
}

