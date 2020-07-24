//
//  Game.swift
//  GameCatalogue
//
//  Created by Fikri Helmi on 13/07/2020.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import Foundation

class GameResult: Codable {
    let results: [Game]
}

class Game: Codable {
    let id: Int
    let name: String?
    let released: String?
    let background_image: String?
    let metacritic: Int
    
    init(id: Int, name: String, released: String, background_image: String, metacritic: Int) {
        self.id = id
        self.name = name
        self.released = released
        self.background_image = released
        self.metacritic = metacritic
    }
}

class GameDetail: Codable {
    let name: String?
    let metacritic: Int
    let released: String?
    let description: String?
    let background_image: String?
    let rating: Double
    let playtime: Int
}

struct K {
    struct Core {
        static let entityGame = "GameData"
        static let id = "id"
        static let metacritic = "metacritic"
        static let playtime = "playtime"
        static let rating = "rating"
        static let background_image = "background_image"
        static let name = "name"
        static let released = "released"
    }
}
