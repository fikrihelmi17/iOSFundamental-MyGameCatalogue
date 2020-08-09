//
//  FavoritesViewController.swift
//  MyGameCatalogue
//
//  Created by Fikri on 24/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit
import SDWebImage

var gameDetail : GameDetail?

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeholder: UILabel!
    
    var games: [Game]?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.delegate = self
            tableView.dataSource = self
            games = GameCoreData.self.loadFavoritList()
            emptyCheck()
            
            tableView.reloadData()
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            games = GameCoreData.self.loadFavoritList()
            tableView.reloadData()
            emptyCheck()
        }
        
        func emptyCheck() {
            if games?.count == 0 {
                tableView.isHidden = true
                placeholder.isHidden = false
            } else {
                tableView.isHidden = false
                placeholder.isHidden = true
            }

    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return games?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavoritesTableViewCell
                 
            let game = games![indexPath.row]
                 cell.imageLabel.sd_setImage(with: URL(string: game.background_image ?? ""))
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
                
                if let indexPath = tableView.indexPathForSelectedRow {
                    detailViewController.game = games?[indexPath.row]
                }
            }
        }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 200
       }
}
