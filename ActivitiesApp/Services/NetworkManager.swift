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
    
    func fetchActivity(from url: URL, completion: @escaping(Result<[Activity], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                    case .success(let value):
                        let activities = Activity.getActivities(from: value)
                        completion(.success(activities))
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                }
            }
    }
}
