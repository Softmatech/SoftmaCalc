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
    var myCurrency:String! = ""
    var cc = ""
    
    var labelNumber:Double = 0 // to take the number on screen
    var lastScreenString:String = "" // to take the last screen Number
    var varDelete:String = ""
    var tipValue:Double = 0
    var Total:Double = 0
    var tipTotal:Double = 0
    var lbl = "0"
    
    @IBAction func ValuesChanged(_ sender: UISegmentedControl) {
                if seg.selectedSegmentIndex == 0 { //for the first segment selected
                    tipValue = 10
                }
                else if seg.selectedSegmentIndex == 1 {//for the second segment selected
                    tipValue = 20
                }
                else if seg.selectedSegmentIndex == 2 {//for the third segment selected
                    tipValue = 30
                }
        tipCalculator(amount: labelNumber) //function to calculate tip
    }

    func tipCalculator(amount:Double){
        tipTotal = ((amount * tipValue)/100) // calculate the total amount of tip
        Total = amount + tipTotal // here is the total of amount + totaltip
        labelTwo.text = "Total = "+String(Double(Total).formattedWithSeparator)+currencySign(currencyString: myCurrency)// asgin the total to the secong label in the screen
        labelThree.text = "Tip = "+String(Double(tipTotal).formattedWithSeparator)+currencySign(currencyString: myCurrency)  //this for the total amount
    }
    
    @IBAction func numbersAction(_ sender: UIButton) {// if the button (del or .) is pressed
        
        labelNumber = Double(lbl)! //label number convert the label text
            // the label receive function button pressed (del or .) and take the right decision
            if sender.tag == 12 //if the . button is pressed
            {
                label.text = label.text! + "." //add . to the label
                lbl = lbl + "."
            }
            else if sender.tag != 11 || sender.tag != 12 //if no verify the pressed button is different to(del or .)
                {
                    if label.text == "0"//if exist zero on the label (the principal screen)
                    {
                        label.text = ""//set the label to null
                        lbl = ""
                    }
                label.text = Double(lbl + String(sender.tag - 1))?.formattedWithSeparator //label take the number hited
                lbl = lbl + String(sender.tag - 1)
                labelNumber = Double(lbl)! // convert the label string
                }
        tipCalculator(amount: labelNumber)// tipcalculator function

    }
    
    @IBAction func setButton(_ sender: UIButton) {
        lastScreenString = label.text! //this variable take the text displayed in the label
        if sender.tag == 11 // if the del button is pressed
        {
            let arrayCharacter = Array(lastScreenString) // casting of the variable lasScreenString who take the  principal label content
            for n in 0..<arrayCharacter.count - 1 { //here a bucle for
                varDelete += String(arrayCharacter[n]) // assignement of array content minus the last
            }
            print(varDelete)
            label.text = varDelete //asignement of label for the new value
            lbl = quitCommaOnString(numberString: varDelete)
            varDelete = "" // assignemtn of null valor to this variable
            zeroFunc() // function to assign zero to the principal label if is null
            zeroLblFunc()
            labelNumber = Double(lbl)! //casting of the label content
            tipCalculator(amount: labelNumber) //tipCalcultor
        }
    }
    
    func quitCommaOnString(numberString : String) -> String {
        var curString = ""
        let arrayCharacter = Array(numberString) // casting of the variable who take the  principal label content
        if arrayCharacter.count > 0 {
        for n in 0..<arrayCharacter.count - 1 { //here a bucle for
            if(arrayCharacter[n] != Character(",")){
                curString += String(arrayCharacter[n]);
            }
        }
        }
        return curString
    }
    

    func zeroFunc(){ //zero function
        if (label.text?.isEmpty)!// if the label is null
        {
            label.text = "0"// assign zero to it
        }
    }
    
    func zeroLblFunc(){ //zero function
        if (lbl.isEmpty)// if the label is null
        {
            lbl = "0"// assign zero to it
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SoftmaCalc" //the title
        mySelect = defaults.integer(forKey: "mySel") //read the variable stocked in the memory for the default tip percentage
        cc = defaults.string(forKey: "myCurrency") ?? "_"
        if ( cc == "_") {
            defaults.set("Haïti-HT G", forKey: "myCurrency")
        }
        myCurrency = defaults.string(forKey:"myCurrency") //read the variable stocked in the memory for the default currency
        tipCalculator(amount: labelNumber) //tipCalcultor
        // Do any additional setup after loading the view, typically from a nib.
        zeroFunc() // to print the zero on screen at begining
        seg.selectedSegmentIndex = mySelect //assign the stored value for default tip
        ValuesChanged(seg) //call the value change method to make the operation
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
        mySelect = defaults.integer(forKey: "mySel")// read the saved default tip
        myCurrency = defaults.string(forKey: "myCurrency")!//read the variable stocked in the memory for the default currency
        tipCalculator(amount: labelNumber) //tipCalcultor
        seg.selectedSegmentIndex = mySelect //set the segment to the default tip
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        mySelect = defaults.integer(forKey: "mySel") // read the saved default tip
        myCurrency = defaults.string(forKey: "myCurrency")!//read the variable stocked in the memory for the default currency
        tipCalculator(amount: labelNumber) //tipCalcultor
        seg.selectedSegmentIndex = mySelect //set the segment to the default tip
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did disappear")
        mySelect = defaults.integer(forKey: "mySel") // read the saved default tip
        myCurrency = defaults.string(forKey: "myCurrency")!//read the variable stocked in the memory for the default currency
        tipCalculator(amount: labelNumber) //tipCalcultor
        seg.selectedSegmentIndex = mySelect //set the segment to the default tip
    }
    
    func currencySign(currencyString : String) -> String {
        var cur = ""
        
        let arrayCharacter = Array(currencyString) // casting of the variable lasScreenString who take the  principal label content
        if (arrayCharacter.count > 0){
        for n in arrayCharacter.count - 1..<arrayCharacter.count { //here a bucle for
            cur = String(arrayCharacter[n]) // assignement of array content minus the last
        }
        }
        return cur
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Double {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
