//
//  ActivityRequest.swift
//  restApi
//
//  Created by Ксения Чепурных on 25.04.2022.
//

import Foundation

enum CodingKeys: String, CodingKey {
    case activity
    case type
    case participants
    case price
    case minprice
    case maxprice
}

public struct Activity: Codable {

    public let participants: String?
    public let type: String?
    public let minprice: Double?
    public let maxprice: Double?
    public let price: Double?
    public let activity: String?

    public init(participants: String? = nil,
                type: String? = nil,
                minprice: String? = nil,
                maxprice: String? = nil,
                price: Double? = nil,
                activity: String? = nil) {
        self.participants = participants
        self.type = type
        self.minprice = NumberFormatter().number(from: minprice ?? "")?.doubleValue
        self.maxprice = NumberFormatter().number(from: maxprice ?? "")?.doubleValue
        self.price = price
        self.activity = activity
    }

    public init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.activity = try? container?.decode(String.self, forKey: .activity)
        self.type = try? container?.decode(String.self, forKey: .type)
        self.participants = nil
        self.price = nil
        self.minprice = nil
        self.maxprice = nil
    }

}
