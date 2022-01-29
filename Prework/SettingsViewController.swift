//
//  SettingsViewController.swift
//  Prework
//
//  Created by Gordon Chen on 2022/1/28.
//

import UIKit

class SettingsViewController: UIViewController {
  
  @IBOutlet weak var themeControl: UISegmentedControl!
  @IBOutlet weak var tipControl: UISegmentedControl!
  @IBOutlet weak var split: UILabel!
  @IBOutlet weak var stepper: UIStepper!
  
  // Set Default
  let defaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    // default theme
    let theme = defaults.integer(forKey: "theme")
    themeControl.selectedSegmentIndex = theme - 1
    
    // change theme
    overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: defaults.integer(forKey: "theme")) ?? .unspecified
    
    // default tip
    let tipPercentages = [0.15, 0.18, 0.2]
    let tipPercentage = defaults.double(forKey: "tipPercentage")
    let index = tipPercentages.firstIndex(where: {$0 == tipPercentage})
    tipControl.selectedSegmentIndex = index ?? 0
    
    // default split
    let step = defaults.integer(forKey: "step")
    stepper.minimumValue = 1
    stepper.autorepeat = true
    stepper.value = Double(step)
    split.text = String(Int(stepper.value))
  }
  
  @IBAction func setTheme(_ sender: Any) {
    let color = themeControl.selectedSegmentIndex + 1
    overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: color) ?? .unspecified
    defaults.set(color, forKey: "theme")
    defaults.synchronize()
  }
  
  @IBAction func setTip(_ sender: Any) {
    let tipPercentages = [0.15, 0.18, 0.2]
    let tip = tipPercentages[tipControl.selectedSegmentIndex]
    defaults.set(tip, forKey: "tipPercentage")
    defaults.synchronize()
  }
  
  @IBAction func UIStepper(_ sender: UIStepper) {
    let step = Int(sender.value).description
    split.text = String(step)
    defaults.set(step, forKey: "step")
    defaults.synchronize()
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
