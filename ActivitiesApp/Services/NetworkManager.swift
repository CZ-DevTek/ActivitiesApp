//
//  NetworkManager.swift
//  ActivitiesApp
//
//  Created by Carlos Garcia Perez on 20/3/24.
//

import Foundation

enum Link {
    case randomURL
    case participantsURL(Int)
    case typeURL(String)
    
    var url: URL {
        switch self {
            case .randomURL:
                return URL(string: "https://www.boredapi.com/api/activity/")!
            case .participantsURL(let participants):
                return URL(string: "https://www.boredapi.com/api/activity?participants=\(participants)")!
            case .typeURL(let type):
                return URL(string: "https://www.boredapi.com/api/activity?type=\(type)")!
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
    
    func fetchActivity(from url: URL, completion: @escaping (Result<Activity, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let activity = try JSONDecoder().decode(Activity.self, from: data)
                completion(.success(activity))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
