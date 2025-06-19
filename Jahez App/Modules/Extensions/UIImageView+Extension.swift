//
//  UIImageView+Extension.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation

import UIKit

extension UIImageView {

    func loadImage(with url: String) {
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                self.image = image
            }
        }
    }
}
