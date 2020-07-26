//
//  DetailViewController.swift
//  GameCatalogue
//
//  Created by Fikri Helmi on 13/07/2020.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    var game: Game?
    var gameDetail : GameDetail?
    let api = API()
    var coreData = GameCoreData.self
    
    @IBOutlet weak var descView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var chart: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var playtime: UILabel!
    @IBOutlet weak var favorite: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let game = self.game!
        
        if coreData.isFavorite(game) == true {
            favorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favorite.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        api.loadGameDetail(IDGame: game.id, completionHandler: { gameDetail in
            guard let gameDetail = gameDetail else {return}
            
            DispatchQueue.main.async {
                self.titleLabel.text = gameDetail.name
                self.releasedLabel.text = (self.releasedLabel.text ?? "") + String(gameDetail.released ?? "")
                self.chart.text = (self.chart.text ?? "") + String(gameDetail.metacritic)
                self.rating.text = (self.rating.text ?? "") + String(gameDetail.rating)
                self.playtime.text = (self.playtime.text ?? "") + String(gameDetail.playtime)

                let descriptionData = gameDetail.description?.data(using: String.Encoding.unicode)!
                let attrStr = try? NSAttributedString(data: descriptionData!,options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                    NSAttributedString.DocumentType.html], documentAttributes: nil)
                self.descView.text = attrStr?.string
                
                let url = URL(string: gameDetail.background_image ?? "")
                let data = try? Data(contentsOf: url!)
                self.image.image = UIImage(data: data!)
             
            }
        })
    
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func btnFav(_ sender: Any) {
        if coreData.isFavorite(game!) == true {
            coreData.deleteFromFavorite(game!)
            favorite.setImage(UIImage(systemName: "star"), for: .normal)
            showAlert(message: "This game is deleted from favorite list!")
        } else {
            coreData.saveToFavorite(game!)
            favorite.setImage(UIImage(systemName: "star.fill"), for: .normal)
            showAlert(message: "This game is saved to favorite list!")
        }
    }
    
}
