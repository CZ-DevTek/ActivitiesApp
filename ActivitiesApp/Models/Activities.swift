//
//  Activities.swift
//  ActivitiesApp
//
//  Created by Carlos Garcia Perez on 17/3/24.
//

import Foundation

struct Activity: Codable {
    let activity: String
    let type: String
    let participants: Int
    let price: Float
    
    init(activityDetails: [String: Any]) {
    activity = activityDetails["activity"] as? String ?? ""
    type = activityDetails["type"] as? String ?? ""
    participants = activityDetails["participants"] as? Int ?? 0
    price = activityDetails["price"] as? Float ?? 0.00
    }
    
    static func getActivities(from value: Any) -> [Activity] {
        guard let activitiesDetails = value as? [[String: Any]] else {return [] }
        return activitiesDetails.map { Activity(activityDetails: $0) }
    }
}
