//
//  PlayerDetailsViewController.swift
//  NBAPlayers
//
//  Created by Stanislav Frolov on 04.11.2020.
//

import UIKit

class PlayerDetailsViewController: UIViewController {

    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var teamButton: UIButton!
    
    var player: Player?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = player?.fullName
        positionLabel.text = "Position: \(player?.position ?? "Uknown")"
        heightLabel.text = player?.height
        teamButton.setTitle(player?.team.fullName, for: .normal)
    }
    
    @IBAction func onTeamButtonTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "TeamDetailsViewController") as! TeamDetailsViewController

        viewController.team = player?.team

        navigationController?.pushViewController(viewController, animated: true)
    }

}
