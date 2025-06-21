//
//  CacheService.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation

protocol CacheServiceProtocol {
    func save<T: Codable>(_ data: T, forKey key: String)
    func load<T: Codable>(forKey key: String, type: T.Type) -> T?
}

final class CacheService: CacheServiceProtocol {
    private let defaults = UserDefaults.standard
    private let expirationInterval: TimeInterval = 7 * 24 * 60 * 60 // 1 week

    func save<T: Codable>(_ data: T, forKey key: String) {
        let wrapper = CacheWrapper(data: data, timestamp: Date())
        if let encoded = try? JSONEncoder().encode(wrapper) {
            defaults.set(encoded, forKey: key)
        }
    }

    func load<T: Codable>(forKey key: String, type: T.Type) -> T? {
        guard let data = defaults.data(forKey: key),
              let wrapper = try? JSONDecoder().decode(CacheWrapper<T>.self, from: data) else {
            return nil
        }
        guard Date().timeIntervalSince(wrapper.timestamp) < expirationInterval else {
            defaults.removeObject(forKey: key)
            return nil
        }
        return wrapper.data
    }

    private struct CacheWrapper<T: Codable>: Codable {
        let data: T
        let timestamp: Date
    }
}
