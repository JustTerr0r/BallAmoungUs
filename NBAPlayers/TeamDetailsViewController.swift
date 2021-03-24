
import UIKit

class TeamDetailsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conferenceLabel: UILabel!
    @IBOutlet weak var abbreviationLabel: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var lastGameTable: UITableView!
    
    let gamesApiClient: ApiClient = ApiClientImpl()
    var team: Team?
    var opps: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        let teamId: Int = team?.id ?? 0
        navigationItem.title = team?.name
        cityLabel.text = team?.city
        conferenceLabel.text = team?.conference
        abbreviationLabel.text = team?.abbreviation
        teamLogo.image = UIImage(named: "\(team?.name ?? "nba")")
        lastGameTable.register(GamesTableViewCell.self, forCellReuseIdentifier: "gameCekk")
        reloadGameData()
    print(teamId)
        lastGameTable.dataSource = self
        lastGameTable.rowHeight = 75
        
    }

    func reloadGameData() {
        let teamId = team?.id ?? 0
        gamesApiClient.getOpps(idOpp: teamId, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let games):
                    self.opps = games
                    print(self.opps.count)
                case .failure:
                    self.opps = []
                    print("FAIL API")
                }
                self.lastGameTable.reloadData()
            }
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opps.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GamesTableViewCell
        let game = opps[indexPath.row]
        
        
        cell.team1Name.text = game.homeTeam.abbreviation
        cell.team1Logo.image = UIImage(named: "\(game.homeTeam.name)")

        cell.dateLabel.text = String("\(game.homeTeamScore):\(game.visitorTeamScore)")
        cell.team2Name.text = game.visitorTeam.abbreviation
        cell.team2Logo.image = UIImage(named: "\(game.visitorTeam.name)")
        
        return cell
    }
    
}
