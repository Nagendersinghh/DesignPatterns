//
//  NetworkPool.swift
//  SportsStore
//
//  Created by nagender singh shekhawat on 29/07/18.
//  Copyright © 2018 nagender singh shekhawat. All rights reserved.
//

import Foundation

class NetworkPool {
    private let connectionCount = 3
    private var connections = [NetworkConnection]()
    private let semaphore: DispatchSemaphore
    private let queue: DispatchQueue
    
    private init() {
        for _ in 0...connectionCount {
            connections.append(NetworkConnection())
        }
        self.semaphore = DispatchSemaphore(value: connectionCount)
        queue = DispatchQueue(label: "networkPoolQ")
    }
    
    private func doGetConnection() -> NetworkConnection {
        semaphore.wait()
        return queue.sync {
            return connections.remove(at: 0)
        }
    }
    
    private func doReturnConnection(conn: NetworkConnection) {
        queue.async {
            self.connections.append(conn)
            self.semaphore.signal()
        }
    }
    
    private class var sharedInstance: NetworkPool {
        struct SingletonWrapper {
            static let singleton = NetworkPool()
        }
        return SingletonWrapper.singleton
    }
    
    class func getConnection() -> NetworkConnection {
        return sharedInstance.doGetConnection()
    }
    
    class func returnConnection(conn: NetworkConnection) {
        sharedInstance.doReturnConnection(conn: conn)
    }
}
