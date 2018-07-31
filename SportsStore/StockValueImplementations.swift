//
//  StockValueImplementations.swift
//  SportsStore
//
//  Created by nagender singh shekhawat on 31/07/18.
//  Copyright © 2018 nagender singh shekhawat. All rights reserved.
//

import Foundation

protocol StockValueFormatter {
    func formatTotal(total: Double) -> String;
}
class DollarStockValueFormatter : StockValueFormatter {
    func formatTotal(total: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: total);
        return "\(formatted)";
    }
}
class PoundStockValueFormatter : StockValueFormatter {
    func formatTotal(total: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(number: total);
        return "£\(formatted.dropFirst())"
        
    }
}
protocol StockValueConverter {
    func convertTotal(total: Double) -> Double;
}
class DollarStockValueConverter : StockValueConverter {
    func convertTotal(total: Double) -> Double {
        return total;
    }
}
class PoundStockValueConverter : StockValueConverter {
    func convertTotal(total: Double) -> Double {
        return 0.60338 * total;
    }
}
