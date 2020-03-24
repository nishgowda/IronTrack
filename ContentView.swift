//
//  ContentView.swift
//  IronTrack2
//
//  Created by Nish Gowda on 2/23/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: WorkItem.getWorkItemFetchRequest()) var workItems: FetchedResults<WorkItem>
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }

    var body: some View {
        
        NavigationView {
           
            VStack(alignment: .center){
                List {
                    ForEach(workItems, id: \.self) { item in
                        NavigationLink(destination: WorkItemView(workItem: item)) {
                            HStack{
                                VStack(alignment: .leading){
                            Text("\(item.name)")
                            Text(item.date != nil ? "-  \(item.date!, formatter: self.dateFormatter)" : "" ).font(.caption)
                        }
                        }
                        }
                    }
                            
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                    
                   
                }.navigationBarTitle("Workouts").navigationBarItems(leading:
                                Button(action: addItem) {
                                    Image(systemName: "square.and.pencil").resizable()
                                    .frame(width: 20, height: 20)
                                             }, trailing: EditButton())
         
               
            }
        }
    }
    func moveItem(indexSet: IndexSet, destination: Int) {
        let source = indexSet.first!
        
        if source < destination {
            var startIndex = source + 1
            let endIndex = destination - 1
            var startOrder = workItems[source].order
            while startIndex <= endIndex {
                workItems[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            
            workItems[source].order = startOrder
            
        } else if destination < source {
            var startIndex = destination
            let endIndex = source - 1
            var startOrder = workItems[destination].order + 1
            let newOrder = workItems[destination].order
            while startIndex <= endIndex {
                workItems[startIndex].order = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            workItems[source].order = newOrder
        }
        
        saveItems()
    }
    
    func deleteItem(indexSet: IndexSet) {
        let source = indexSet.first!
        let listItem = workItems[source]
        managedObjectContext.delete(listItem)
        saveItems()
    }
    
    func addItem() {
          
        let newItem = WorkItem(context: managedObjectContext)
        newItem.name = "New Exercise"
        newItem.order = (workItems.last?.order ?? 0) + 1
        newItem.date? = Date()
        saveItems()
    }
    
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
