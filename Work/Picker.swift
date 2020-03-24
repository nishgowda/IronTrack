//
//  Picker.swift
//  IronTrack2
//
//  Created by Nish Gowda on 2/25/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI

class UnitPicker : ObservableObject{
    @Published var picker = UserDefaults.standard.integer(forKey: "picker")
    @Published var timePicker : Int = 0
    //@Published var exercisePicker = UserDefaults.standard.integer(forKey: "exercisePick")
    @Published var work = ["Barbell Bench Press","Barbell Shoulder Press","Lat Pull Down","Barbell Row","Dumbbell Bench Press","Close Grip Babrell Bench Press","Incline Barbell Bench Press","Decline Barbell Bench Press","Dumbbell Shoulder Press","Arnold Press","Incline Dumbbell Press","Barbell Shrug", "Barbell Upright Row", "Barbell Back Squat","Barbell Deadlift","Barbell Romanian Deadlift","Dumbell Romanian Deadlift","Dumbell Step Ups","Barbell Front Squat","Hyperextensions","Hack Squat","Dumbell Lunge","Leg Press" ,"Dumbell Bicep Curl","Chest Fly","Leg Extension","Seated Hamstring Curl","Skull Crushers","Hammer Curl","Crunch","Leg Raises","Air Bike","Side Plank","Ab-Rollouts","Cross Body Crunch"]

}


