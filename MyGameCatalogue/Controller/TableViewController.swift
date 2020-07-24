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
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)

      
        let when = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
        self.api.loadGameList(completionHandler: reloadTable(games:))
        
       //dismiss(animated: false, completion: nil)
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
        
        cell.imageCell.sd_setImage(with: URL(string: game.background_image ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
   
        cell.titleCell.text = game.name
        cell.releasedCell.text = game.released
        cell.chartCell.text = String(game.metacritic)

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
