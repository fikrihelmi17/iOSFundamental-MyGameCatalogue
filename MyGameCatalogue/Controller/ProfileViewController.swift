//
//  ProfileViewController.swift
//  MyGameCatalogue
//
//  Created by Fikri on 26/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var getImageProfile: UIButton!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameProfile: UITextField!
    @IBOutlet weak var emailProfile: UITextField!
    @IBOutlet weak var githubProfile: UITextField!
    @IBOutlet weak var aboutProfile: UITextField!
    @IBOutlet weak var updateProfile: UIButton!
    
    private let imagePicker = UIImagePickerController()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getImageProfile.layer.cornerRadius = 15
        updateProfile.layer.cornerRadius = 15
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        imageProfile.contentMode = .scaleToFill

        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        nameProfile.text = ProfileModel.instance.profileName
        emailProfile.text = ProfileModel.instance.profileEmail
        githubProfile.text = ProfileModel.instance.profileGithub
        aboutProfile.text = ProfileModel.instance.profileAboutMe
        if let profileImage = ProfileModel.instance.profileImage {
            imageProfile.image = UIImage(data: profileImage)
        }
    }


@objc func viewTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func alert(_ field: String ){
        let alertController = UIAlertController(title: "Warning", message: "\(field) cannot be empty", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnGetImagePressed(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnUpdateClicked(_ sender: Any) {
        if nameProfile.text!.isEmpty {
            alert("Name")
            return
        }

        if emailProfile.text!.isEmpty {
            alert("Email")
            return
        }

        if githubProfile.text!.isEmpty {
            alert("Phone Number")
            return
        }

        if aboutProfile.text!.isEmpty{
            alert("About")
            return
        }


        if let name = nameProfile.text, let email = emailProfile.text, let github = githubProfile.text, let image = imageProfile.image, let about = aboutProfile.text, let data = image.pngData() as Data? {

            ProfileModel.instance.profileName = name
            ProfileModel.instance.profileEmail = email
            ProfileModel.instance.profileGithub = github
            ProfileModel.instance.profileAboutMe = about
            ProfileModel.instance.profileImage = data as Data
        }

        NotificationCenter.default.post(name: NOTIF_PROFILE_UPDATED, object: nil)
        navigationController?.popViewController(animated: true)
        
        
    }

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let result = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.imageProfile.image = result
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Failed", message: "Image can't be loaded.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
