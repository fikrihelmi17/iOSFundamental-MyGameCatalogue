//
//  AboutViewController.swift
//  MyGameCatalogue
//
//  Created by Fikri on 26/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var github: UILabel!
    @IBOutlet weak var aboutMe: UITextView!
    
    var def = ProfileModel.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(profileUpdated(_:)), name: NOTIF_PROFILE_UPDATED, object: nil)
        
        setupUI()
    }
    
    func setupUI() {
        name.text = def.profileName
        github.text = def.profileGithub
        email.text = def.profileEmail
        aboutMe.text = def.profileAboutMe
        if let profileImage = def.profileImage {
            image.image = UIImage(data: profileImage)
        }
    }
    
    @objc func profileUpdated(_ notif: Notification) {
        setupUI()
    }
}
