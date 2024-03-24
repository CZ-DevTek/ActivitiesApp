//
//  NetworkManager.swift
//  ActivitiesApp
//
//  Created by Carlos Garcia Perez on 20/3/24.
//

import Foundation
import Alamofire

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
    
    func fetchActivity(from url: URL, completion: @escaping(Result<Activity, Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                    case .success(let data):
                        do {
                            let activity = try JSONDecoder().decode(Activity.self, from: data)
                            completion(.success(activity))
                        } catch {
                            print("Decoding error:", error)
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        print("Network request error:", error)
                        completion(.failure(error))
                }
            }
    }
}
