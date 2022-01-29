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
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
