//
//  NetworkManager.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func sendRequest<ResponseType: Decodable>(endPoint: RequestBuilder,
                                              decodingType: ResponseType.Type,
                                              completion: @escaping (Result<ResponseType, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {

    // MARK: - Properties
    static var environment: Environment = .develop

    // MARK: - Network call
    func sendRequest<ResponseType: Decodable>(endPoint: RequestBuilder,
                                              decodingType: ResponseType.Type,
                                              completion: @escaping (Result<ResponseType, Error>) -> Void) {

        guard let url =  URL.init(string: endPoint.baseURL + endPoint.path) else {
            completion(.failure(NetworkFailure.generalFailure))
            return
        }

        AF.request(url, method: endPoint.method,
                   parameters: endPoint.parameters,
                   encoding: URLEncoding.init(destination: .queryString))
            .validate()
            .responseData { (response) in
                guard let request =  response.request, let networkResponse =  response.response else { return }
                NetworkLogger.log(request: request)

                switch response.result {
                case .success(let responseDate):
                    NetworkLogger.log(response: networkResponse, data: responseDate)

                    do {
                        let model: ResponseType =  try JSONDecoder().decode(decodingType.self, from: responseDate)
                        completion(.success(model))
                    } catch let error {
                        NetworkLogger.log(error: error)
                        completion(.failure(NetworkFailure.failedToParseData))
                    }

                case .failure(let error):
                    NetworkLogger.log(error: error)
                    completion(.failure(error))
                }
            }
    }
}
