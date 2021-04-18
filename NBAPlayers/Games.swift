//
//  Games.swift
//  NBAPlayers
//
//  Created by Stanislav Frolov on 13.03.2021.
//

import Foundation
struct GamesResponse: Decodable {
    let data: [Game]
}

struct Game: Decodable {
    let dateGet: String
    var date: String {
        String(dateGet.split(separator: "T")[0])
        }
    
    let homeTeam: Team
    let homeTeamScore: Int
    let visitorTeam: Team
    let visitorTeamScore: Int
    
    enum CodingKeys: String, CodingKey {
            case dateGet = "date"
            case homeTeam = "home_team"
            case homeTeamScore = "home_team_score"
            case visitorTeam = "visitor_team"
            case visitorTeamScore = "visitor_team_score"
        }
}
