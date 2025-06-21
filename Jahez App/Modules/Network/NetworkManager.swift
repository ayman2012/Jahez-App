//
//  NetworkManager.swift
//  Jahez App
//
//  Created by Ayman Fathy on 19/06/2025.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ endpoint: URLRequest) -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Network call
    func request<T: Decodable>(_ endpoint: URLRequest) -> AnyPublisher<T, Error> {
        
        NetworkLogger.log(request: endpoint)
        
        return URLSession.shared.dataTaskPublisher(for: endpoint)
            .handleEvents(receiveOutput: { output in
                if let response = output.response as? HTTPURLResponse {
                    NetworkLogger.log(response: response, data: output.data)
                }
            })
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .handleEvents(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    if let decodingError = error as? DecodingError {
                        NetworkLogger.log(error: NetworkFailure.failedToParseData)
                    }
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
