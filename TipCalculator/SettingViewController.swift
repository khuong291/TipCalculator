//
//  SettingViewController.swift
//  TipCalculator
//
//  Created by Khuong Pham on 11/2/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController : UIViewController {
    var tip: Tip!

    var callback: ((Tip) -> Void)?

    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        tipSegmentedControl.selectedSegmentIndex = tip.rawValue
    }
}

extension SettingViewController {
    @IBAction func backButtonTouched(sender: UIButton) {
        let tip = Tip(rawValue: tipSegmentedControl.selectedSegmentIndex)!
        callback?(tip)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}