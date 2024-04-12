//
//  PokemonView.swift
//  pokemon
//
//  Created by Yuki Miyashita on 2024/04/11.
//

import SwiftUI

struct PokemonView: View {
    let itemName:ResultJson
    var body: some View {
        
        VStack{
            Text("No.\(itemName.id)")
                .font(.largeTitle)
            
            AsyncImage(url:URL(string:itemName.sprites.front)){image in
                image.image?.resizable().frame(width: 250, height: 250)
            }
            
            Text(itemName.name)
                .font(.title)
            
            if  itemName.types.count == 1  {
                Text("\(itemName.types[0].type.name)タイプ")
            }else {
                Text("\(itemName.types[0].type.name)タイプ")
                Text("\(itemName.types[1].type.name)タイプ")
            }
        }
    }
}
//#Preview {
//    PokemonView(itemName: ResultJson)
//}
