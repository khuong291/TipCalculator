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

    let numberFormatter = NSNumberFormatter()

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
        calculateResult()
    }
}

extension TipViewController {
    func calculateResult() {
        guard let amountString = amountTextField.text where amountString.characters.count > 0,
            let amount = numberFormatter.numberFromString(amountString)?.floatValue else {
                return
        }

        let tip = determineTip()
        let tipAmount = amount * tip
        let total = amount + tipAmount

        tipLabel.text = numberFormatter.stringFromNumber(NSNumber(float: tipAmount))
        totalLabel.text = numberFormatter.stringFromNumber(NSNumber(float: total))
    }

    func determineTip() -> Float {
        switch tipSegmentedControl.selectedSegmentIndex {
        case 0:
            return 0.1
        case 1:
            return 0.15
        case 2:
            return 0.2
        default:
            return 0
        }
    }
}

extension TipViewController {
    @IBAction func tipSegmentedControlValueChanged(sender: UISegmentedControl) {
        calculateResult()
    }
}

extension TipViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TipViewController {
    @IBAction func settingButtonTouched(sender: UIBarButtonItem) {
        let settingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SettingViewController")

        navigationController?.pushViewController(settingViewController, animated: true)
    }
}