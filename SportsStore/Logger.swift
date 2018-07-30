//
//  Logger.swift
//  SportsStore
//
//  Created by nagender singh shekhawat on 25/07/18.
//  Copyright © 2018 nagender singh shekhawat. All rights reserved.
//

import Foundation

var handler = { (p:Product) in
    print("Change: \(p.name) \(p.stockLevel) items in stock");
};

let productLogger = Logger<Product>(callback: handler)

final class Logger<T> where T:NSObject, T:NSCopying {
    var dataItems: [T] = [];
    var callback: (T) -> Void
    var arrayQ = DispatchQueue(label: "arrayQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    var callbackQ = DispatchQueue(label: "callbackQ", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)

    fileprivate init(callback: @escaping (T) -> Void, protect: Bool = true) {
        self.callback = callback
        if (protect) {
            self.callback = {(item: T) in
                self.callbackQ.sync {
                    callback(item)
                }
            }
        }
    }
    
    func logItem(item: T) {
        arrayQ.async(flags: .barrier) {
            self.dataItems.append((item.copy() as? T)!)
            self.callback(item)
        }
    }
    
    func processItems(callback: @escaping (T) -> Void) {
        arrayQ.sync {
            for item in self.dataItems {
                callback(item)
            }
        }
    }
}
