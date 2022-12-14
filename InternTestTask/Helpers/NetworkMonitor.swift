//
//  NetworkManager.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import Foundation
import Network

protocol NetworkMonitor {
    var isConnected: Bool { get }
}

class NetworkMonitorImpl: NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private(set) var isConnected: Bool = false
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
