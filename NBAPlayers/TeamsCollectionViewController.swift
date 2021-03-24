//
//  TeamsCollectionViewController.swift
//  NBAPlayers
//
//  Created by Stanislav Frolov on 17.03.2021.
//

import UIKit


func showTeamDetailsViewController(from controller: UIViewController, with team: Team) {
    let storyboard = UIStoryboard(name: "Main", bundle: .main)
    let viewController = storyboard.instantiateViewController(identifier: "TeamDetailsViewController") as! TeamDetailsViewController
    
    viewController.team = team
    
    controller.navigationController?.pushViewController(viewController, animated: true)
}

class TeamsCollectionViewController: UICollectionViewController {

    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    let itemsPerRow: CGFloat = 3
    
    let teamsApiClient: ApiClient = ApiClientImpl()
    var teams: [Team] = []
    var player: Player?
    
    func reloadTeamData() {
        teamsApiClient.getTeams(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let teams):
                    self.teams = teams
                case .failure:
                    self.teams = []
                }
                self.collectionView.reloadData()
            }
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        showTeamDetailsViewController(from: self, with: teams[indexPath.item])
        collectionView.deselectItem(at: indexPath, animated: true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showsVerticalScrollIndicator = false
        reloadTeamData()
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return teams.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamsCollectionViewCell
        let team = teams[indexPath.row]
        
        cell.teamLogo.image = UIImage(named: "\(team.name)")
        
        return cell
    }

}

extension TeamsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize (width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
