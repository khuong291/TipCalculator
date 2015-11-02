//
//  TipViewController.swift
//  TipCalculator
//
//  Created by Khuong Pham on 11/2/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit

class TipViewController : UIViewController {
    @IBOutlet weak var amountContainerView: UIView!
    @IBOutlet weak var resultContainerView: UIView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestureRecognizer()
        setupAmountTextField()
    }
}

extension TipViewController {
    func setupGestureRecognizer() {
        let gr = UITapGestureRecognizer(target: self, action: Selector("viewTapped:"))
        view.addGestureRecognizer(gr)
    }

    func viewTapped(sender: AnyObject) {
        view.endEditing(true)
    }
}

extension TipViewController {
    func setupAmountTextField() {
        amountTextField.addTarget(self,
            action: Selector("amountTextFieldValueChanged:"),
            forControlEvents: .EditingChanged)
    }

    func amountTextFieldValueChanged(sender: AnyObject) {
        totalLabel.text = amountTextField.text
    }
}

extension TipViewController {
    @IBAction func tipSegmentedControlValueChanged(sender: UISegmentedControl) {
        
    }
    
}

extension TipViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}