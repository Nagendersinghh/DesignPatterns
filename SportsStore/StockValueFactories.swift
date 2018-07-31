//
//  StockValueFactories.swift
//  SportsStore
//
//  Created by nagender singh shekhawat on 31/07/18.
//  Copyright © 2018 nagender singh shekhawat. All rights reserved.
//

import Foundation

class StockTotalFactory {
    enum Currency {
        case USD
        case GBP
    }
    
    fileprivate(set) var formatter: StockValueFormatter?
    fileprivate(set) var converter: StockValueConverter?
    
    class func getFactory(curr: Currency) -> StockTotalFactory {
        if (curr == .USD) {
            return DollarStockTotalFactory.sharedInstance
        } else {
            return PoundStockTotalFactory.sharedInstance
        }
    }
}

private class DollarStockTotalFactory: StockTotalFactory {
    private override init() {
        super.init()
        formatter = DollarStockValueFormatter()
        converter = DollarStockValueConverter()
    }
    
    class var sharedInstance: StockTotalFactory {
        get {
            struct SingletonWrapper {
                static let singleton = DollarStockTotalFactory()
            }
            return SingletonWrapper.singleton
        }
    }
}

private class PoundStockTotalFactory: StockTotalFactory {
    private override init() {
        super.init()
        formatter = PoundStockValueFormatter()
        converter = PoundStockValueConverter()
    }
    
    class var sharedInstance: StockTotalFactory {
        get {
            struct SingletonWrapper {
                static let singleton = PoundStockTotalFactory()
            }
            return SingletonWrapper.singleton
        }
    }
}
