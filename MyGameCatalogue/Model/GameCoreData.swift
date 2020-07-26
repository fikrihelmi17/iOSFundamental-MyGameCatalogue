//
//  GameCoreData.swift
//  MyGameCatalogue
//
//  Created by Fikri on 24/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit
import CoreData

class GameCoreData {
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    static func loadFavoritList() -> [Game] {
        var games = [Game]()
        
        if let appDelegate = appDelegate {
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameData")
            
            do {
                let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                
                result?.forEach { game in
                    games.append(
                        Game(id: game.value(forKey: value.id) as! Int,
                             name: (game.value(forKey: value.name) as? String)!,
                             released: game.value(forKey: value.released) as? String ?? "",
                             background_image: game.value(forKey: value.background_image) as? String ?? "",
                             metacritic: game.value(forKey: value.metacritic) as? Int ?? 0)
                    )
                }
            } catch let err {
                print("Failed to load data, \(err)")
            }
        }
        return games
    }
    
    static func saveToFavorite(_ game: Game) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: value.entityName, in: managedContext) else {return}
            
            let insert = NSManagedObject(entity: entity, insertInto: managedContext)
            insert.setValue(game.id, forKey: value.id)
            insert.setValue(game.name, forKey: value.name)
            insert.setValue(game.released, forKey: value.released)
            insert.setValue(game.background_image, forKey: value.background_image)
            insert.setValue(game.metacritic, forKey: value.metacritic)
            
            do {
                try managedContext.save()
            } catch let err {
                print("Failed to save data, \(err)")
            }
        }
    }
    
    static func isFavorite(_ game: Game) -> Bool {
        var isFavorite = false
        
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: value.entityName)
            fetchRequest.predicate = NSPredicate(format: "\(value.id) = %ld", game.id)
            do {
                let fetch = try managedContext.fetch(fetchRequest)
                    if !fetch.isEmpty {
                        isFavorite = true
                    }
            } catch let err {
                print("error check isFavorite: ", err)
            }
        }
        
        return isFavorite
    }
    
    static func deleteFromFavorite(_ game: Game) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: value.entityName)
            fetchRequest.predicate = NSPredicate(format: "\(value.id) = %ld", game.id)
            
            do {
                let fetch = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                
                if fetch.isEmpty {return}
                
                for f in fetch {
                    managedContext.delete(f)
                }
                try managedContext.save()
            } catch let err {
                print("error check isFavorite: ", err)
            }
        }
    }
}
