//
//  CustomView.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/12/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI

struct CustomView : View{
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State var itemName = ""
    @State var description = ""
    @ObservedObject var customItem : CustomWork
        @EnvironmentObject var pic : UnitPicker
    var body: some View{
        Form{
            Section(header: Text("Name Of Exercise")){
            TextField("Exercise Name", text: $itemName)
           
        }
            Section(header: Text("Description")){
                TextView(text: $description).frame(numLines: 4).modifier(DismissingKeyboard())
            }
            
            Section{
                Button(action: {
                    self.customItem.customName = self.itemName
                    self.customItem.customDescription = self.description
                    self.pic.work.append(self.customItem.customName)

                                        do {
                                                try self.moc.save()
                                            } catch {
                                        print(error)
                                    }
                               self.presentationMode.wrappedValue.dismiss()
                                         })
                                         {
                                             Text("Save")
                                         }   .onAppear(perform: {
                                           self.itemName = self.customItem.customName
                                            self.description = self.customItem.customDescription
                                         
                           })
            }
        }.navigationBarTitle("Custom Exercise", displayMode: .inline)
}
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView(customItem: CustomWork())
    }
}
