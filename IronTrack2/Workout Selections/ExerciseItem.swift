//
//  ExerciseItem.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/7/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI

struct ExerciseSelection: Codable, Identifiable {
    var id: UUID
    var name: String
    var items: [ExerciseItem]
}

struct ExerciseItem: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var steps: [String]
     var muscleGroups: [String]
    var imageURL : String
    
    var mainImage : String{
         name.replacingOccurrences(of: " ", with: "-")
    }

    #if DEBUG
    static let example = ExerciseItem(id: UUID(), name: "Barbell Bench Press", steps: ["Sweet, fluffy, and served piping hot, our French toast is flown in fresh every day from Maple City, Canada, which is where all maple syrup in the world comes from. And if you believe that, we have some land to sell you…"], muscleGroups: ["U"], imageURL: "https://upload.wikimedia.org/wikipedia/commons/8/86/Bicep-hammer-curl-2.png")

      #endif
}
