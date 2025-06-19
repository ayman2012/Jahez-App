//
//  Collection+Extension.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
