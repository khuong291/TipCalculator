//
//  DataManager.swift
//  TipCalculator
//
//  Created by Khuong Pham on 11/3/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation

struct DataManager {
    static func saveTip(tip: Tip) {
        NSUserDefaults.standardUserDefaults().setInteger(tip.rawValue, forKey: "tip")
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    static func loadTip() -> Tip {
        let value = NSUserDefaults.standardUserDefaults().integerForKey("tip")
        return Tip(rawValue: value) ?? .Low
    }
}