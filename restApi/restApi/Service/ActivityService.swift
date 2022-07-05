//
//  ActivityService.swift
//  restApi
//
//  Created by Ксения Чепурных on 26.04.2022.
//

import Foundation

public class ActivityService {

    public static let shared = ActivityService()

    func getActivities(activity: Activity, completion: @escaping (Activity) -> Void) {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "www.boredapi.com"
        components.path = "/api/activity"
        components.queryItems = getParametrs(for: activity)

        guard let url = components.url else { return }
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let task = URLSession.shared.dataTask(with: request) { data, response, _ in
                guard
                    let data = data,
                    let activity: Activity = try? JSONDecoder().decode(Activity.self, from: data)
                else { return }
                completion(activity)
            }
            task.resume()
        }
    }

}

private extension ActivityService {

    func getParametrs(for model: Activity) -> [URLQueryItem] {
        var params: [URLQueryItem] = []

        if let participants = model.participants, !participants.isEmpty {
            params.append(URLQueryItem(name: "participants", value: participants))
        }

        if let type = model.type, !type.isEmpty {
            params.append(URLQueryItem(name: "type", value: type))
        }

        if let minPrice = model.minprice {
            params.append(URLQueryItem(name: "minprice", value: String(minPrice)))
        }

        if let maxPrice = model.maxprice {
            params.append(URLQueryItem(name: "maxprice", value: String(maxPrice)))
        }

        return params
    }
}
