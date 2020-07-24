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
    
    static func getFavoriteGames() -> [Game] {
        var games = [Game]()
        
        if let appDelegate = appDelegate {
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GameData")
            
            do {
                let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                
                result?.forEach { game in
                    games.append(
                        Game(id: game.value(forKey: K.Core.id) as! Int,
                             name: (game.value(forKey: K.Core.name) as? String)!,
                             released: game.value(forKey: K.Core.released) as? String ?? "",
                             background_image: game.value(forKey: K.Core.background_image) as? String ?? "",
                             metacritic: game.value(forKey: K.Core.metacritic) as? Int ?? 0)
                    )
                }
            } catch let err {
                print("Failed to load data, \(err)")
            }
        }
        return games
    }
    
    static func saveToFavorite(_ model: Game) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: K.Core.entityGame, in: managedContext) else {return}
            
            let insert = NSManagedObject(entity: entity, insertInto: managedContext)
            insert.setValue(model.id, forKey: K.Core.id)
            insert.setValue(model.name, forKey: K.Core.name)
            insert.setValue(model.released, forKey: K.Core.released)
            insert.setValue(model.background_image, forKey: K.Core.background_image)
            insert.setValue(model.metacritic, forKey: K.Core.metacritic)
            
            do {
                try managedContext.save()
            } catch let err {
                print("Failed to save data, \(err)")
            }
        }
    }
    
    static func isFavorite(_ model: Game) -> Bool {
        var isFavorite = false
        
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityGame)
            fetchRequest.predicate = NSPredicate(format: "\(K.Core.id) = %ld", model.id)
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
    
    static func deleteFromFavorite(_ model: Game) {
        if let appDelegate = appDelegate {
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.Core.entityGame)
            fetchRequest.predicate = NSPredicate(format: "\(K.Core.id) = %ld", model.id)
            
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
