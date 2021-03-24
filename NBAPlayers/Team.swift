//
//  Team.swift
//  NBAPlayers
//
//  Created by Stanislav Frolov on 23.01.2021.
//

import Foundation

struct TeamsResponse: Decodable {
    let data: [Team]
}

struct Team: Decodable {
    let id: Int
    let name: String
    let city: String
    let conference: String
    let abbreviation: String
    
    var fullName: String {
        city + " " + name
    }
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case city = "city"
        case abbreviation = "abbreviation"
        case name = "name"
        case conference = "conference"
    }
    
}
