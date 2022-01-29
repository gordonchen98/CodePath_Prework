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
    @IBOutlet weak var splitControl: UISegmentedControl!
    @IBOutlet weak var people: UILabel!
    @IBOutlet weak var split: UILabel!
    
    // Set Default
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the title in the Navigation Bar
        self.title = "Tip Calculator"
        
        billAmountTextField.keyboardType = UIKeyboardType.decimalPad
        billAmountTextField.becomeFirstResponder()
        billAmountTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        rate.keyboardType = UIKeyboardType.numberPad
        rate.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        rate.clearButtonMode = .whileEditing
        
        // change tip amount
        let tipPercentages = [0.15, 0.18, 0.2]
        let tipPercentage = defaults.double(forKey: "tipPercentage")
        let index = tipPercentages.firstIndex(where: {$0 == tipPercentage})
        tipControl.selectedSegmentIndex = index ?? 0
        slider.setValue(Float(tipPercentage), animated: true)
        rate.text = String(format: "%.0f", tipPercentage * 100)
    }
    
    // dynamic change with any input change with textfield
    @objc func textChanged() {
        let count = [1,2,3,4,5,6]
        
        let percentage = Double(rate.text!) ?? 0 > 100 ? 100 : Double(rate.text!) ?? 0 < 0 ? 0 : Double(rate.text!) ?? 0
        rate.text = String(format: "%.0f", percentage)
        let bill = Double(billAmountTextField.text!) ?? 0
        let tip = bill * percentage / 100
        let total = bill + tip
        
        slider.setValue(Float(percentage / 100), animated: true)
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        split.text = String(format: "$%.2f", total / Double(count[splitControl.selectedSegmentIndex]))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // change theme
        overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: defaults.integer(forKey: "theme")) ?? .unspecified
    }
    
    // for slider
    @IBAction func sliderTip(_ sender: Any) {
        let count = [1,2,3,4,5,6]
        
        let bill = Double(billAmountTextField.text!) ?? 0
        let percentage = Double(Int(slider.value * 100)) / 100
        let tip = bill * percentage
        let total = bill + tip
        
        rate.text = String(format: "%.0f", percentage * 100)
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        split.text = String(format: "$%.2f", total / Double(count[splitControl.selectedSegmentIndex]))
    }
    
    // for rate segment
    @IBAction func calculateTip(_ sender: Any) {
        let count = [1,2,3,4,5,6]
        let tipPercentages = [0.15, 0.18, 0.2]
        
        let bill = Double(billAmountTextField.text!) ?? 0
        let tip = bill *
            tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        slider.setValue( Float(tipPercentages[tipControl.selectedSegmentIndex]), animated: true)
        rate.text = String(format: "%.0f", tipPercentages[tipControl.selectedSegmentIndex] * 100)
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        split.text = String(format: "$%.2f", total / Double(count[splitControl.selectedSegmentIndex]))
    }
    
    // for splitting segment
    @IBAction func splitTip(_ sender: Any) {
        let count = [1,2,3,4,5,6]
        
        let bill = Double(billAmountTextField.text!) ?? 0
        let percentage = Double(slider.value)
        let tip = bill * percentage
        let total = bill + tip
        
        people.text = count[splitControl.selectedSegmentIndex] == 1
                        ? "person" : "people"
        split.text = String(format: "$%.2f", total / Double(count[splitControl.selectedSegmentIndex]))
    }
}
