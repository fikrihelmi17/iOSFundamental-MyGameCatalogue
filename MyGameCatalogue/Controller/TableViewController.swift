//
//  TableViewController.swift
//  GameCatalogue
//
//  Created by Fikri Helmi on 13/07/2020.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let api = API()
    var array: [Game]?
    var selectedGame: Game?
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.api.loadGameList(completionHandler: reloadTable(games:))
    }
    
    func reloadTable(games: [Game]) {
        array = games
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.game = selectedGame
    }

    
    //datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let jumlahBaris = array?.count
        return jumlahBaris ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell
        
        let game = array![indexPath.row]
        
        cell.gambar.sd_setImage(with: URL(string: game.background_image), placeholderImage: UIImage(named: "placeholder.png"))
   
        cell.judul.text = game.name
        cell.tanggalRilis.text = game.released
        cell.peringkat.text = String(game.metacritic)

        return cell
    }
    
    // delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let array = array else {
            return indexPath
        }
        selectedGame = array[indexPath.row]
        return indexPath
    }
}
