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
    
    @IBOutlet weak var gambar: UIImageView!
    @IBOutlet weak var judul: UILabel!
    @IBOutlet weak var tanggalRilis: UILabel!
    @IBOutlet weak var peringkat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gambar.layer.cornerRadius = gambar.frame.height / 2
        gambar.clipsToBounds = true
    }

}

