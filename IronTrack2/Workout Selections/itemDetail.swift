//
//  itemDetail.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/7/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI

struct itemDetail: View {
    var item: ExerciseItem
    var body: some View {
        
        Form{
            Section{
                DIImage(item.mainImage)
            }
            
            
            Section(header: Text("Steps:")){
                ForEach(item.steps, id: \.self) { step in
                    Text(step).padding(5)
                }
                
      
            }
        }.navigationBarTitle(Text(item.name), displayMode: .inline)
     
    }
}

