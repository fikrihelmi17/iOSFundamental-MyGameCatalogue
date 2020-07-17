//
//  API.swift
//  GameCatalogue
//
//  Created by Fikri Helmi on 13/07/2020.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit

class API {
    
    func loadGameList(completionHandler: @escaping ([Game]) -> Void) {
        
        
        
        
        let request = URLRequest(url: URL(string: "https://api.rawg.io/api/games")!)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse else {return}
            
            if response.statusCode == 200 {
                if let gameResults = try? JSONDecoder().decode(GameResult.self, from: data) {
                        let array = gameResults.results
                        completionHandler(array)
                }
            }
            
            if let error = error {
                print(error.localizedDescription)
            }
            
        })
        task.resume()
        
    }
    
    func loadGameDetail(IDGame: Int, completionHandler: @escaping (GameDetail?) -> Void) {
        
        let urlString: String = "https://api.rawg.io/api/games/" + String(IDGame)
            guard let url = URL(string: urlString) else {return}
        
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {return}
                
                    if let gameDetailResult = try? JSONDecoder().decode(GameDetail.self, from: data) {                        completionHandler(gameDetailResult)
                    }
                
                if let error = error {
                    print(error.localizedDescription)
                }
            })
            task.resume()
        
    }
}
