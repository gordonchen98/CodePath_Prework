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
  @IBOutlet weak var tip: UILabel!
  @IBOutlet weak var tipControl: UISegmentedControl!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var total: UILabel!
  @IBOutlet weak var each: UILabel!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var rate: UITextField!
  @IBOutlet weak var average: UILabel!
  @IBOutlet weak var splitAmount: UILabel!
  @IBOutlet weak var stepper: UIStepper!
  @IBOutlet weak var percent: UILabel!
  @IBOutlet weak var split: UILabel!
  
  // set Default
  let defaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // sets the title in the Navigation Bar
    self.title = "Tip Calculator"
    
    // basic setup
    billAmountTextField.keyboardType = UIKeyboardType.decimalPad
    billAmountTextField.becomeFirstResponder()
    billAmountTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    rate.keyboardType = UIKeyboardType.numberPad
    rate.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    rate.clearButtonMode = .whileEditing
    
    // restore billAmount
    let bill = defaults.integer(forKey: "bill")
    billAmountTextField.text = bill > 0 ? String(defaults.integer(forKey: "bill")) : ""
    
    // change tip amount
    let tipPercentages = [0.15, 0.18, 0.2]
    let tipPercentage = defaults.double(forKey: "tipPercentage")
    let index = tipPercentages.firstIndex(where: {$0 == tipPercentage})
    tipControl.selectedSegmentIndex = index ?? 0
    slider.setValue(Float(tipPercentage), animated: true)
    rate.text = String(format: "%.0f", tipPercentage * 100)
    
    // setup stepper
    stepper.minimumValue = 1
    stepper.autorepeat = true
    stepper.value = Double(defaults.integer(forKey: "step"))
    splitAmount.text = String(Int(stepper.value))
  }
  
  // dynamic change with any input change with textfield
  @objc func textChanged() {
    let percentage = Double(rate.text!) ?? 0 > 100 ? 100 : Double(rate.text!) ?? 0 < 0 ? 0 : Double(rate.text!) ?? 0
    calculate(bill: Double(billAmountTextField.text!) ?? 0,
              percentage: percentage / 100, step: Int(stepper.value))
    onTap()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // change theme
    overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: defaults.integer(forKey: "theme")) ?? .unspecified
    
    // change tip amount
    let tipPercentages = [0.15, 0.18, 0.2]
    let tipPercentage = defaults.double(forKey: "tipPercentage")
    let index = tipPercentages.firstIndex(where: {$0 == tipPercentage})
    tipControl.selectedSegmentIndex = index ?? 0
    slider.setValue(Float(tipPercentage), animated: true)
    rate.text = String(format: "%.0f", tipPercentage * 100)
    
    // setup stepper
    stepper.minimumValue = 1
    stepper.autorepeat = true
    stepper.value = Double(defaults.integer(forKey: "step"))
    splitAmount.text = String(Int(stepper.value))
    textChanged()
  }
  
  private func onTap() {
    if (billAmountTextField.text == "") {
      UIView.animate(withDuration: 1, animations: {
        self.tipAmountLabel.isHidden = true
        self.tip.isHidden = true
        self.tipControl.isHidden = true
        self.totalLabel.isHidden = true
        self.total.isHidden = true
        self.each.isHidden = true
        self.slider.isHidden = true
        self.rate.isHidden = true
        self.average.isHidden = true
        self.splitAmount.isHidden = true
        self.stepper.isHidden = true
        self.percent.isHidden = true
        self.split.isHidden = true
      })
    } else {
      UIView.animate(withDuration: 1, animations: {
        self.tipAmountLabel.isHidden = false
        self.tip.isHidden = false
        self.tipControl.isHidden = false
        self.totalLabel.isHidden = false
        self.total.isHidden = false
        self.each.isHidden = false
        self.slider.isHidden = false
        self.rate.isHidden = false
        self.average.isHidden = false
        self.splitAmount.isHidden = false
        self.stepper.isHidden = false
        self.percent.isHidden = false
        self.split.isHidden = false
      })
    }
  }
  
  // for slider
  @IBAction func sliderTip(_ sender: Any) {
    calculate(bill: Double(billAmountTextField.text!) ?? 0,
              percentage: Double(Int(slider.value * 100)) / 100,
              step: Int(stepper.value))
  }
  
  // for rate segment
  @IBAction func segmentTip(_ sender: Any) {
    let tipPercentages = [0.15, 0.18, 0.2]
    calculate(bill: Double(billAmountTextField.text!) ?? 0,
              percentage: tipPercentages[tipControl.selectedSegmentIndex],
              step: Int(stepper.value))
  }
  
  // for split stepper
  @IBAction func UIStepper(_ sender: UIStepper) {
    splitAmount.text = Int(sender.value).description
    
    calculate(bill: Double(billAmountTextField.text!) ?? 0,
              percentage: Double(slider.value),
              step: Int(stepper.value))
  }
  
  // locale currency
  private func localCurrency(amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale.current
    return formatter.string(from: NSNumber(value: amount)) ?? "Error"
  }
  
  // display calculations
  private func calculate(bill: Double, percentage: Double, step: Int) {
    let tip = bill * percentage
    let total = bill + tip
    
    defaults.set(Int(bill), forKey: "bill")
    defaults.synchronize()
    
    slider.setValue(Float(percentage), animated: true)
    rate.text = String(format: "%.0f", percentage * 100)
    tipAmountLabel.text = localCurrency(amount: tip)
    totalLabel.text = localCurrency(amount: total)
    average.text = localCurrency(amount: total / Double(step))
  }
}
