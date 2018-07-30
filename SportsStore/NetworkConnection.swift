//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by nagender singh shekhawat on 29/07/18.
//  Copyright © 2018 nagender singh shekhawat. All rights reserved.
//

import Foundation

class NetworkConnection {
    private let stockData = [
        "kayak": 10, "Lifejacket": 14, "Soccer Ball": 32,"Corner Flags": 1,
        "Stadium": 4, "Thinking Cap": 8, "Unsteady Chair": 3,
        "Human Chess Board": 2, "Bling-Bling King":4
    ]
    
    func getStockLevel(name: String) -> Int? {
        Thread.sleep(forTimeInterval: Double(arc4random() % 2))
        return self.stockData[name]
    }
}
