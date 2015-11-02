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
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
    }
}

extension SettingViewController {
    @IBAction func backButtonTouched(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}