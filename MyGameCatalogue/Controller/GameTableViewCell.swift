//
//  GameTableViewCell.swift
//  GameCatalogue
//
//  Created by Fikri Helmi on 13/07/2020.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit
import SDWebImage

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var releasedCell: UILabel!
    @IBOutlet weak var chartCell: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageCell.layer.cornerRadius = imageCell.frame.height / 2
        imageCell.clipsToBounds = true
    }

}

