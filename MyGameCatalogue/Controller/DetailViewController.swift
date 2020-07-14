//
//  DetailViewController.swift
//  GameCatalogue
//
//  Created by Fikri Helmi on 13/07/2020.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var game: Game?
    var gameDetail : GameDetail?
    let api = API()

    
    @IBOutlet weak var judul: UILabel!
    @IBOutlet weak var tanggalRilis: UILabel!
    @IBOutlet weak var peringkat: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var waktuBermain: UILabel!
    @IBOutlet weak var deskripsi: UILabel!
    @IBOutlet weak var gambar: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let game = self.game!
        
        api.loadGameDetail(IDGame: game.id, completionHandler: { gameDetail in
            guard let gameDetail = gameDetail else {return}
            
            DispatchQueue.main.async {
                self.judul.text = gameDetail.name
                self.tanggalRilis.text = gameDetail.released
                self.peringkat.text = (self.peringkat.text ?? "") + String(gameDetail.metacritic)
                self.rating.text = (self.rating.text ?? "") + String(gameDetail.rating)
                self.waktuBermain.text = (self.waktuBermain.text ?? "") + String(gameDetail.playtime)

                let descriptionData = gameDetail.description.data(using: String.Encoding.unicode)!
                let attrStr = try? NSAttributedString(data: descriptionData,options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                    NSAttributedString.DocumentType.html], documentAttributes: nil)
                self.deskripsi.text = attrStr?.string
                
                let url = URL(string: gameDetail.background_image)
                let data = try? Data(contentsOf: url!)
                self.gambar.image = UIImage(data: data!)
             
            }
        })
    }

}
