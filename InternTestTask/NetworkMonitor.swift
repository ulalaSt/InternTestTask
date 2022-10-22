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
    var connectionType: ConnectionType { get }
}

enum ConnectionType {
    case wifi, cellular, unknown
}

class NetworkMonitorImpl: NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global()
    private(set) var isConnected: Bool = false
    private(set) var connectionType: ConnectionType = .unknown
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
            self?.updateConnectionType(by: path)
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    private func updateConnectionType(by path: NWPath){
        if path.usesInterfaceType(.wifi) {
            self.connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            self.connectionType = .cellular
        } else {
            self.connectionType = .unknown
        }
    }
}
