//
//  ReachabilityService.swift
//  Jahez App
//
//  Created by Ayman Fathy on 21/06/2025.
//

import Foundation
import Network
import Combine

final class ReachabilityService {
    static let shared = ReachabilityService()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ReachabilityMonitor")

    private let statusSubject = CurrentValueSubject<Bool, Never>(true)
    var isConnectedPublisher: AnyPublisher<Bool, Never> {
        return statusSubject.eraseToAnyPublisher()
    }

    var isConnected: Bool {
        return statusSubject.value
    }

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status == .satisfied
            self?.statusSubject.send(isConnected)
        }
        monitor.start(queue: queue)
    }
}
