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
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let game = self.game!
    
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

    @IBAction func btnFav(_ sender: Any) {
        if coreData.isFavorite(game!) == true {
            coreData.deleteFromFavorite(game!)
        } else {
            coreData.saveToFavorite(game!)
        }
    }
    
}
