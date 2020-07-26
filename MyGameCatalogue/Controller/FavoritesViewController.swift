//
//  FavoritesViewController.swift
//  MyGameCatalogue
//
//  Created by Fikri on 24/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableFav: UITableView!
    
    var games: [Game]?

    
    var defService = ProfileModel.instance
    var cdService = GameCoreData.self
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableFav.delegate = self
            tableFav.dataSource = self
            
            games = cdService.loadFavoritList()
            emptyCheck()
            
            tableFav.reloadData()
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            games = cdService.loadFavoritList()
            tableFav.reloadData()
            emptyCheck()
        }
        
        func showAlert(message: String) {
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
        func emptyCheck() {
            if games?.count == 0 {
                showAlert(message: "Favorite List is empty. Click 'Star' icon in the game info")
        }

    }
}

    extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return games?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableFav.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoritesTableViewCell
                 
            let game = games![indexPath.row]
                 cell.titleLabel.text = game.name
                 cell.releasedLabel.text = game.released
                 cell.chartLabel.text = String(game.metacritic)
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showDetail", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail" {
                let detailViewController = segue.destination as! DetailViewController
                
                if let indexPath = tableFav.indexPathForSelectedRow {
                    detailViewController.game = games?[indexPath.row]
                }
            }
        }
        

}
