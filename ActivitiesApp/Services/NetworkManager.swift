//
//  NetworkManager.swift
//  ActivitiesApp
//
//  Created by Carlos Garcia Perez on 20/3/24.
//

import Foundation

enum Link {
    case randomURL
    case participantsURL
    case typeURL

    
    var url: URL {
        switch self {
        case .randomURL:
            return URL(string: "https://www.boredapi.com/api/activity/")!
        case .participantsURL:
            return URL(string: "http://www.boredapi.com/api/activity?participants=1")!
        case .typeURL:
            return URL(string: "http://www.boredapi.com/api/activity?type=recreational")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
