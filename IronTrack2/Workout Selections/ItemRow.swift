//
//  ItemRow.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/7/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI

struct ItemRow: View {
  //  let brown = Color(red: 0.55, green: 0.00, blue:0.00)
    static let colors: [String: Color] = ["P": .orange, "A": .red, "B": Color(red:0,green: 0, blue:128), "S": Color(red: 0.55, green: 0.00, blue:0.00), "Q": .green, "H": .purple, "G": .pink, "C": .blue ]

    var item : ExerciseItem
    var body: some View {
        NavigationLink(destination: itemDetail(item: item)){
            HStack{
            VStack (alignment: .leading){
                Text(item.name).font(.headline)
            }
                
            
        Spacer()
                   ForEach(item.muscleGroups, id: \.self) { restriction in
                       Text(restriction).font(.caption)
                       .fontWeight(.black)
                       .padding(5)
                       .background(Self.colors[restriction, default: .black])
                       .clipShape(Circle())
                       .foregroundColor(.white)
                   }
            }
        
    }
            
        }
}
    


