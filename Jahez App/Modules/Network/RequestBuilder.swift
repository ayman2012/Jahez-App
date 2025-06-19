//
//  RequestBuilder.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import Alamofire

enum Environment {
    case develop
    case staging
    case production
}

protocol RequestBuilder {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
}

extension RequestBuilder {
   private var environmentBaseUrl: String {
        switch NetworkManager.environment {
        case .develop :
            return APIConstants.developBaseURL
        case  .staging:
            return APIConstants.stagingBaseURL
        case .production:
            return APIConstants.ProductionBaseURL

        }
    }

    var baseURL: String {
        return environmentBaseUrl
    }
}
