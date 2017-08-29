//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Tisa Segovic on 25.08.2017..
//  Copyright © 2017. Tisa Segovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen: Double = 0;
    var tipAmount: Double!
    
    var data = [15, 18, 20, 25]
    
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipUpdated: UILabel! // For updating the tip amount
    @IBOutlet weak var totalUpdated: UILabel! // For updating the total amount

    
    @IBAction func numInput(_ sender: Any) {// For the individual button pressed - relates to individually made buttons by me
        billAmount.text = billAmount.text! + String((sender as AnyObject).tag - 1)
        numberOnScreen = Double(billAmount.text!)!
    }
    
    // Button for correcting the user input - cleaning entire input
    @IBAction func buttons(_ sender: UIButton) {
        if sender.tag == 11{
            billAmount.text = ""
            numberOnScreen = 0;
        }
    }
    
    // For choosing the percentage in the Picker View
    @IBOutlet weak var percentageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPercentagePicker()
        createPickerToolbar()
    }
    
    func createPickerToolbar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        percentageField.inputAccessoryView = toolBar
        
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createPercentagePicker() {
        let percentagePicker = UIPickerView()
        percentagePicker.delegate = self
        
        percentageField.inputView = percentagePicker
        
        percentagePicker.backgroundColor = .white // Customization
    }
    
    // For updating the "Tip Amount" and the "Total Amount", which will be calculated 
    // as soon as the percentage value is selected in the picker view
    @IBAction func calculateTip(_ sender: UITextField) {
//        let tip = Double(billAmount.text!)! * tipAmount
//        let total = Double(billAmount.text!)! + tip
//        
//        tipUpdated.text = String(format: "$ %.2f", tip)
//        totalUpdated.text = String(format: "$ %.2f", total)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    /* Set of PickerView Functions which are used for manipulating the
     * PickerView itself. */
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(data[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        percentageField.text = String(data[row])
        
        // To be able to calculate with the tip amount
        if (row == 0){
            tipAmount = 0.15;
        }else if (row == 1){
            tipAmount = 0.18;
        }else if (row == 2){
            tipAmount = 0.20;
        }else if (row == 3){
            tipAmount = 0.25;
        }
        
        let tip = Double(billAmount.text!)! * tipAmount
        let total = Double(billAmount.text!)! + tip
        
        tipUpdated.text = String(format: "$ %.2f", tip)
        totalUpdated.text = String(format: "$ %.2f", total)
    }
    
}

