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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(profileUpdated(_:)), name: NOTIF_PROFILE_UPDATED, object: nil)
        
        setupUI()
        
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
    }
    
    func setupUI() {
        name.text = ProfileModel.instance.profileName
        github.text = ProfileModel.instance.profileGithub
        email.text = ProfileModel.instance.profileEmail
        aboutMe.text = ProfileModel.instance.profileAboutMe
        if let profileImage = ProfileModel.instance.profileImage {
            image.image = UIImage(data: profileImage)
        }
    }
    
    @objc func profileUpdated(_ notif: Notification) {
        setupUI()
    }
}
