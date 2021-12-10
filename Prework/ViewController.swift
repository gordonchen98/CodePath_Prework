//
//  ViewController.swift
//  Prework
//
//  Created by Gordon Chen on 2021/12/9.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var rate: UITextField!
    
    func roundToPlaces(_ value:Double, _ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountTextField.keyboardType = UIKeyboardType.numberPad
        billAmountTextField.becomeFirstResponder()
        billAmountTextField.clearButtonMode = .whileEditing
        billAmountTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        rate.keyboardType = UIKeyboardType.numberPad
        rate.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        rate.clearButtonMode = .whileEditing
        // Do any additional setup after loading the view.
    }
    
    @objc func textChanged() {
        let percentage = Double(rate.text!) ?? 0 > 100 ? 100 : Double(rate.text!) ?? 0 < 0 ? 0 : Double(rate.text!) ?? 0
        rate.text = String(format: "%.0f", percentage)
        let bill = Double(billAmountTextField.text!) ?? 0
        let tip = bill * percentage / 100
        let total = bill + tip
        slider.setValue(Float(percentage / 100), animated: true)
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func sliderTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let percentage = Double(slider.value)
        let tip = bill * percentage
        let total = bill + tip
        rate.text = String(format: "%.0f", percentage * 100)
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [0.15, 0.18, 0.2]
        let tip = bill *
            tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        slider.setValue( Float(tipPercentages[tipControl.selectedSegmentIndex]), animated: true)
        rate.text = String(format: "%.0f", tipPercentages[tipControl.selectedSegmentIndex] * 100)
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}
