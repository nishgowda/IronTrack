//
//  LoadWorkouts.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/7/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI

struct LoadWorkouts: View {
let works = Bundle.main.decode([ExerciseSelection].self, from: "myWorkouts.json")
    @Environment(\.managedObjectContext) var moc
        @FetchRequest(fetchRequest: CustomWork.getCustomWorkFetchRequest()) var customItems: FetchedResults<CustomWork>
     @State  var showingSheet = false
          @State var exerciseName = ""
        @ObservedObject var workItem: WorkItem
    @EnvironmentObject var pic : UnitPicker
    var body: some View {
        NavigationView{
           
            List{
                ForEach(works){ work in
                    Section(header: Text(work.name)) {
                                   ForEach(work.items) { item in
                                    ItemRow(item: item)
                }
                
            }
                }
                                                 
                Section(header: Text("Custom Exercises")){
       
                        ForEach(self.customItems, id: \.self) { item in
                            NavigationLink(destination: CustomView(customItem: item)){
                                Text("\(item.customName)- \(item.customOrder)").font(.headline)
                                }
                        }
                                    
                        .onDelete(perform: self.deleteItem)
                                    
                                        Button(action: self.addItem){
                                            HStack{
                                    Image(systemName: "plus")
                                    Text("Create Custom Exercise")
                                            }
                                }
                
                }
                    }.navigationBarTitle("Exercises")
                }.listStyle(GroupedListStyle())

                    }

        func deleteItem(indexSet: IndexSet) {
            let source = indexSet.first!
            let customItem = customItems[source]
            moc.delete(customItem)
        
            saveItems()
        }
        func addItem() {
                 
               let newItem = CustomWork(context: moc)
               newItem.customName = "New Exercise"
          
               newItem.customOrder = (customItems.last?.customOrder ?? 0) + 1
               saveItems()
           }
           
           func saveItems() {
               do {
                   try moc.save()
               } catch {
                   print(error)
               }
      
           }
    }
struct LoadWorkouts_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




