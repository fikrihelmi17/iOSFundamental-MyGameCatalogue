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
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
          let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
          loadingIndicator.hidesWhenStopped = true
          loadingIndicator.style = UIActivityIndicatorView.Style.gray
          loadingIndicator.startAnimating();

          alert.view.addSubview(loadingIndicator)
          present(alert, animated: true, completion: nil)

        
          let when = DispatchTime.now() + 5
          DispatchQueue.main.asyncAfter(deadline: when){
              alert.dismiss(animated: true, completion: nil)
          }
    
        api.loadGameDetail(IDGame: game.id, completionHandler: { gameDetail in
            guard let gameDetail = gameDetail else {return}
            
            DispatchQueue.main.async {
                self.titleLabel.text = gameDetail.name
                self.releasedLabel.text = (self.releasedLabel.text ?? "") + String(gameDetail.released)
                self.chart.text = (self.chart.text ?? "") + String(gameDetail.metacritic)
                self.rating.text = (self.rating.text ?? "") + String(gameDetail.rating)
                self.playtime.text = (self.playtime.text ?? "") + String(gameDetail.playtime)

                let descriptionData = gameDetail.description.data(using: String.Encoding.unicode)!
                let attrStr = try? NSAttributedString(data: descriptionData,options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                    NSAttributedString.DocumentType.html], documentAttributes: nil)
                self.descView.text = attrStr?.string
                
                let url = URL(string: gameDetail.background_image)
                let data = try? Data(contentsOf: url!)
                self.image.image = UIImage(data: data!)
             
            }
        })
    
    }

}
