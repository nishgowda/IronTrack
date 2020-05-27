//
//  LiftingItem.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/10/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI

struct LiftinSelection: Codable, Identifiable {
    var id: UUID
    var name: String
    var items: [ExerciseItem]
}

struct LiftinItem: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
     var restrictions: [String]

    #if DEBUG
      static let example = ExerciseItem(id: UUID(), name: "Barbell Bench Press", description: "Sweet, fluffy, and served piping hot, our French toast is flown in fresh every day from Maple City, Canada, which is where all maple syrup in the world comes from. And if you believe that, we have some land to sell you…", restrictions: ["U"])
      #endif
}
