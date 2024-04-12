//
//  pokemonData.swift
//  pokemon
//
//  Created by Yuki Miyashita on 2024/04/05.
//

import Foundation
import SwiftUI

struct Pokemoninfo: Decodable, Identifiable{
    var id: Int
    let name: String
    let sprites:pokemonimage
    let types:[types]
    
    
    struct pokemonimage:Codable{
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

final class PokemonData:ObservableObject{
    @Published var pokemonlist:[Pokemoninfo] = []
    
    init()  {
        Task{
            await FetchPokemonData()
        }
    }
    @MainActor
    
    func FetchPokemonData() async  {
        var num = 0
        for _ in 1...151{
            num = num + 1
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(num)/") else { return }
            
            do {
                let (data , _) = try await URLSession.shared.data(from:url)
                print(data)
                let decoder = JSONDecoder()
                let json = try decoder.decode(Pokemoninfo.self,from: data)
                
                pokemonlist.append(json)
            } catch {
                print("エラー")
            }
        }
        print(pokemonlist)
    }
}

