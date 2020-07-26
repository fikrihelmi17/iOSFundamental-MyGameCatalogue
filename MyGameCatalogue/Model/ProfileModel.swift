//
//  UserDefault.swift
//  MyGameCatalogue
//
//  Created by Fikri on 24/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import Foundation

class ProfileModel{
    static let instance = ProfileModel()
    
    private let def = UserDefaults.standard
    
    fileprivate let nameKey = "nameKey"
    fileprivate let emailKey = "emailKey"
    fileprivate let profileGithubKey = "githubKey"
    fileprivate let profileImageKey = "imageKey"
    fileprivate let profileAboutMeKey = "aboutMeKey"
    fileprivate let hasLaunchedKey = "hasLaunchedKey"
    
    var profileName: String {
        get {
            return def.string(forKey: nameKey) ?? ""
        }
        set {
            def.set(newValue, forKey: nameKey)
        }
    }
    
    var profileEmail: String {
        get {
            return def.string(forKey: emailKey) ?? ""
        }
        set {
            def.set(newValue, forKey: emailKey)
        }
    }
    
    var profileGithub: String {
        get {
            return def.string(forKey: profileGithubKey) ?? ""
        }
        set {
            def.set(newValue, forKey: profileGithubKey)
        }
    }
    
    var profileImage: Data? {
        get {
            return def.data(forKey: profileImageKey)
        }
        set {
            def.set(newValue, forKey: profileImageKey)
        }
    }
    
    var profileAboutMe: String {
        get {
            return def.string(forKey: profileAboutMeKey) ?? ""
        }
        set {
            def.set(newValue, forKey: profileAboutMeKey)
        }
    }
    
    var hasLaunched: Bool {
        get {
            return def.bool(forKey: hasLaunchedKey)
        }
        set {
            def.set(newValue, forKey: hasLaunchedKey)
        }
    }
}

