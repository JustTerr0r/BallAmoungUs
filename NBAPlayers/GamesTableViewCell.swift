//
//  GamesTableViewCell.swift
//  NBAPlayers
//
//  Created by Stanislav Frolov on 12.03.2021.
//

import UIKit

class GamesTableViewCell: UITableViewCell {

    @IBOutlet weak var team1Logo: UIImageView!
    @IBOutlet weak var team2Logo: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
