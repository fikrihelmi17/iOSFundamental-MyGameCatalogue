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
    let name: String
    let released: String
    let background_image: String
    let metacritic: Int
}

class GameDetail: Codable {
    let name: String
    let metacritic: Int
    let released: String
    let description: String
    let background_image: String
    let rating: Double
    let playtime: Int

}
