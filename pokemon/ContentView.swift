//
//  ContentView.swift
//  pokemon
//
//  Created by Yuki Miyashita on 2024/04/05.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pokemonDatalist = pokemonData()
    
    let columns = [GridItem(.fixed(180)),GridItem(.fixed(180))]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(pokemonDatalist.pokemonlist){pokemon in
                        NavigationLink{
                            PokemonView(itemName:pokemon)
                        }label:{
                            ZStack{
                                Circle()
                                    .trim(from: 0.5, to:1)
                                    .overlay(Circle()
                                        .stroke(Color.black))
                                    .foregroundColor(.red)
                                    .frame(width: 150 , height: 150)
                                
                                AsyncImage(url:URL(string:pokemon.sprites.front)){image in
                                    image.image?.resizable()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}

