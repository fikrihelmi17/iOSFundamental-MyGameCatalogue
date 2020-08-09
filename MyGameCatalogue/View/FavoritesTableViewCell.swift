//
//  FavoritesTableViewCell.swift
//  MyGameCatalogue
//
//  Created by Fikri on 24/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit
import SDWebImage

@IBDesignable
class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var chartLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func prepareForInterfaceBuilder() {
        custom()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        custom()
    }
    
    func custom() {
        imageLabel.layer.cornerRadius = 10.0
        imageLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
