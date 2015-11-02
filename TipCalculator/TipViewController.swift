//
//  TipViewController.swift
//  TipCalculator
//
//  Created by Khuong Pham on 11/2/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit
import BubbleTransition

class TipViewController : UIViewController {
    @IBOutlet weak var amountContainerView: UIView!
    @IBOutlet weak var resultContainerView: UIView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    let transition = BubbleTransition()
    let numberFormatter = NSNumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestureRecognizer()
        setupAmountTextField()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        amountTextField.becomeFirstResponder()
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

        let tipPercentage = determineTip().tipPercentage()
        let tipAmount = amount * tipPercentage
        let total = amount + tipAmount

        tipLabel.text = numberFormatter.stringFromNumber(NSNumber(float: tipAmount))
        totalLabel.text = numberFormatter.stringFromNumber(NSNumber(float: total))
    }

    func determineTip() -> Tip {
        return Tip(rawValue: tipSegmentedControl.selectedSegmentIndex) ?? .Low
    }

    func updateTip(tip: Tip) {
        tipSegmentedControl.selectedSegmentIndex = tip.rawValue
        calculateResult()
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
        guard let settingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SettingViewController") as? SettingViewController
            else {
            return
        }

        settingViewController.transitioningDelegate = self
        settingViewController.modalPresentationStyle = .Custom

        settingViewController.tip = determineTip()

        settingViewController.callback = { [weak self] tip in
            self?.updateTip(tip)
        }

        presentViewController(settingViewController, animated: true, completion: nil)
    }
}

extension TipViewController : UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = view.center
        transition.bubbleColor = UIColor.yellowColor()
        return transition
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = view.center
        transition.bubbleColor = UIColor.yellowColor()
        return transition
    }
}