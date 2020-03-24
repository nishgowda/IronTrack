//
//  WorkItem.swift
//  IronTrack2
//
//  Created by Nish Gowda on 2/23/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import CoreData

class WorkItem: NSManagedObject, Identifiable {
    @NSManaged var name: String
    @NSManaged var order: Int
    @NSManaged var exercisePicker: Int
    @NSManaged var weightLifted: Double
    @NSManaged var numberOfReps: Double
    @NSManaged var numberOfSets: Double
    @NSManaged var rpe: Double
    @NSManaged var notes: String
    @NSManaged var date : Date?

  
 
    
    

}



extension WorkItem {
    static func getWorkItemFetchRequest() -> NSFetchRequest<WorkItem>{
        let request = WorkItem.fetchRequest() as! NSFetchRequest<WorkItem>
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        return request
    }
}

