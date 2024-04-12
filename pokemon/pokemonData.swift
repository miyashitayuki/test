//
//  pokemonData.swift
//  pokemon
//
//  Created by Yuki Miyashita on 2024/04/05.
//

import Foundation
import SwiftUI

struct ResultJson: Decodable, Identifiable{
    var id: Int
    let name: String
    let sprites:ima
    let types:[types]
    
    
    
    struct ima:Codable{
        let front:String
        enum CodingKeys: String, CodingKey {
            case front = "front_default"
        }
    }
    struct types:Codable{
        let type:type
    }
    
    struct type:Codable{
        let name:String
    }
}

class pokemonData:ObservableObject{
    @Published var pokemonlist:[ResultJson] = []


    init()  {
        Task{
            await poke()
        }
    }
    @MainActor
    
    func poke() async  {
        var num = 0
        for _ in 1...151{
            num = num + 1
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(num)/")
            else{
                return
            }
            print(url)
            
            do {
                let (data , _) = try await URLSession.shared.data(from:url)
                print(data)
                let decoder = JSONDecoder()
                let json = try decoder.decode(ResultJson.self,from: data)
                
                pokemonlist.append(json)
//                print(json)
                
            } catch {
                print("エラー")
            }
            
        }
        print(pokemonlist)
    }
}

