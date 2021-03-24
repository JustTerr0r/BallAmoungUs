//
//  GamesTableViewController.swift
//  NBAPlayers
//
//  Created by Stanislav Frolov on 12.03.2021.
//

import UIKit

class GamesTableViewController: UITableViewController {
    
    var games: [Game] = []
    let gamesApiClient: ApiClient = ApiClientImpl()
    var team: Team?
    
    func reloadGameData() {
        gamesApiClient.getGames(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let games):
                    self.games = games
                case .failure:
                    self.games = []
                }
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Games List"
        reloadGameData()
    }

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GamesTableViewCell
        let game = games[indexPath.row]
        
        cell.team1Name.text = game.homeTeam.abbreviation
        cell.team1Logo.image = UIImage(named: "\(game.homeTeam.name)")

        cell.dateLabel.text = String("\(game.homeTeamScore):\(game.visitorTeamScore)")
        cell.team2Name.text = game.visitorTeam.abbreviation
        cell.team2Logo.image = UIImage(named: "\(game.visitorTeam.name)")
        
        return cell
    }

}
