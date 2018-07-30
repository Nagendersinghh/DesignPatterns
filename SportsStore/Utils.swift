//
//  Utils.swift
//  SportsStore
//
//  Created by nagender singh shekhawat on 23/07/18.
//  Copyright © 2018 nagender singh shekhawat. All rights reserved.
//

import Foundation

class Utils {
    class func currencyStringFromNumber(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
