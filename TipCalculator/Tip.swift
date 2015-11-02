//
//  Tip.swift
//  TipCalculator
//
//  Created by Khuong Pham on 11/3/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation

enum Tip : Int {
    case Low = 0, Medium, High

    func tipPercentage() -> Float {
        switch self {
        case .Low:
            return 0.1
        case .Medium:
            return 0.15
        case .High:
            return 0.2
        }
    }
}