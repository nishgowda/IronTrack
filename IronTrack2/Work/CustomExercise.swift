//
//  CustomExercise.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/8/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import CoreData

class CustomExercise: NSManagedObject, Identifiable {
    @NSManaged var name: String
}


extension CustomExercise {
    static func getCustomExerciseFetchRequest() -> NSFetchRequest<CustomExercise>{
        let request = CustomExercise.fetchRequest() as! NSFetchRequest<CustomExercise>
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        return request
    }
}

