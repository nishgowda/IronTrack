//
//  CustomWork.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/11/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import CoreData

class CustomWork: NSManagedObject, Identifiable {
    @NSManaged var customName: String
    @NSManaged var customOrder: Int    
    @NSManaged var customDescription: String

    

}



extension CustomWork {
    static func getCustomWorkFetchRequest() -> NSFetchRequest<CustomWork>{
        let request = CustomWork.fetchRequest() as! NSFetchRequest<CustomWork>
        request.sortDescriptors = [NSSortDescriptor(key: "customOrder", ascending: true)]
        return request
    }
}
