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
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    let api = API()
    var array: [Game]?
    var selectedGame: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
      
        setProfile()
        
        loading.startAnimating()
        loading.isHidden = false
        tableView.isHidden = true
        
        self.api.loadGameList(completionHandler: reloadTable(games:))
    }
    
    func reloadTable(games: [Game]) {
        array = games
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            self.loading.stopAnimating()
            self.loading.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
    func setProfile() {
        if ProfileModel.instance.hasLaunched == false {
            ProfileModel.instance.profileName = "Fikri Helmi Setiawan"
            ProfileModel.instance.profileEmail = "fikrihelmi17@gmail.com"
            ProfileModel.instance.profileGithub = "github.com/fikrihelmi17"
            ProfileModel.instance.profileAboutMe = "Perkenalkan, nama saya adalah Fikri Helmi Setiawan. Saya lahir pada tanggal 27 Juli 1999. Saya bertempat tinggal di Soreang, Kab Bandung. Saat ini saya sedang menempuh pendidikan S1 di Universtas Widyatama. Informatika. Dengan mengikuti beasiswa IDCamp dan Dicoding ini, saya ingin menjadi iOS Developer."
            ProfileModel.instance.profileImage = nil
            ProfileModel.instance.hasLaunched = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
