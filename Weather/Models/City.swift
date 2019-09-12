//
//  City.swift
//  Weather
//
//  Created by Keyi Zhu on 9/11/19.
//  Copyright © 2019 Keyi Zhu. All rights reserved.
//

import Foundation
struct City:Codable {
    let id : Int?
    let name, country: String?
    let coord: Coord?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case country = "country"
        case coord = "coord"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
    }
}
