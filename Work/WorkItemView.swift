//
//  WorkItemView.swift
//  IronTrack2
//
//  Created by Nish Gowda on 2/23/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI
import MessageUI
import UIKit
struct WorkItemView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var itemName: String = ""
    @State var weight: Double = 0
    @State var reps: Double = 0
    @State var sets: Double = 0
    @State var rpe: Double = 0
    @State var unit : String = "lbs"
    @ObservedObject var workItem: WorkItem
    @State var goal = true
    @State  var notes : String = ""
    @State var goalAlert = false
    @State var message = ""
    @State var show = false
    @EnvironmentObject var pic : UnitPicker
    @State private var showingSheet = false
    @State var exPic = 0
    @State var customPick = true
    @State private var ispickershowing = false
    @State var dateAdded = Date()
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State var rpeAlert = true
    
    @State var rpeArray = [
        "10 – At your max, you have no more reps",
        "9 – There’s another rep in the tank, but it’s a grind",
        "8 – You’re beginning to hit your 2-4 rep stride",
        "7 – Often the weight that can be moved with power, but still facilitate strength (5-7ish reps)",
        "6 – Weight that can moved quick and utilized with speed work (+/- 8 reps depending on speed/training goal)",
        "5 – This weight that can be used as warmup and prep for heavier weights",
        "4 & below – Lightweight that can be used for mobility, recovery, and form emphasis"]
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    var onDismissKeyboard: (() -> Void)?
    var GoalWeight: Double{
        var newWeight = Double(weight)
        if weight == 0
        {
            newWeight *= 0
        }
        if (weight) > 0 {
            newWeight *= 0
            if weight < 120{
                newWeight += (weight * 1.1) + ((10-rpe) * 1.1)
            }
            else if weight >= 120 && weight < 200 {
                newWeight += (weight * 1.05) + ((10-rpe) * 1.05)
            }
            else if weight >= 200 && weight < 300 {
                newWeight += (weight * 1.025) + ((10-rpe) * 1.025)
            }
            else if weight >= 300 {
                newWeight += (weight * 1.015) + ((10-rpe) * 1.015)
            }
            
        }
        return newWeight
    }
    var GoalReps: Int{
        let total = Int(reps)
        var newTotal = 0
        if total == 0
        {
            newTotal *= 0
        }
        if total <= 5  && total != 0{
            newTotal += Int(reps) + 1
        }
        else if total >= 5 && total < 10
        {
            newTotal += Int(reps) + 2
        }
        else if total >= 10 {
            newTotal += Int(reps) + 3
        }
        return newTotal
    }
    var Unit: String{
        var unit = ""
        if pic.picker == 0
        {
            unit = "lb\(weightChange > 1 ? "s": "")"
        }
        if pic.picker == 1
        {
            unit = "kg\(weightChange > 1 ? "s": "")"
        }
        return unit
    }
    var GoalWeightChange: Int{
        var goalWeight = 0
        if pic.picker == 0
        {
            goalWeight += Int(GoalWeight)
        }
        if pic.picker == 1
        {
            goalWeight += Int(GoalWeight*0.45359200000016791643)
        }
        return goalWeight
    }
    var weightChange: Int{
        var newWeight = 0.0
        let weight1 =  Double(weight)
        if pic.picker == 0
        {
            newWeight += Double(weight)
        }
        if pic.picker == 1
        {
            newWeight += Double(weight1 * 0.45359200000016791643)
        }
        return Int(newWeight)
    }
    
    var profGoalWeight : String{
        return (String(GoalWeightChange)) + " " + Unit
    }
    var ogWeight : String{
        var ans = ""
        if(weight > 0)
        {
            ans = (String(weightChange)) + " " + Unit
        }
        else{
            ans = (String(0)) + " " + Unit
        }
        return ans
    }
    
    var someNumberProxy: Binding<String> {
        Binding<String>(
            get: { String(format: "%.0f", Double(self.weight)) },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.weight = value.doubleValue
                }
        }
        )
    }
    
    var body: some View {
        
        Form{
            
            
            Section{
                Toggle(isOn: $goal.animation()){
                    Text("Recommended Goals").font(.headline)
                }
                if goal{
                    Text("Weight Goal: \(profGoalWeight)" + " X \(Int(reps)) rep\(reps > 1 ? "s": "")")
                    Text("Rep Goal: \(ogWeight)" + " X \(GoalReps) rep\(GoalReps > 1 ? "s": "")")
                }
            }
            Section{
                DatePicker(selection: $dateAdded, in: ...Date(), displayedComponents: .date){
                    Text("Select a date")
                }
            }
            
            Section(header: Text("Comments")){
                TextView(text: $notes).frame(numLines: 4).modifier(DismissingKeyboard())
            }
            
            
            Section(header: Text("Choose an exericse")){
                Picker("Exercises: ", selection: $workItem.exercisePicker)
                {
                    ForEach(0..<pic.work.count)
                    {
                        Text(self.pic.work[$0]).tag($0)
                    }
                    
                }
                
            }
            
            
            Section(header: Text("Weight Lifted: \(weightChange) "+Unit)){
                UBSTextField(myText: someNumberProxy, placeHolderText: "\(weightChange) "+Unit)
            }
            
            
            
            Section(header: Text("Number of Sets and Reps: ")){
                VStack(alignment: .leading){
                    
                    HStack(alignment: .top){
                        Stepper("\(sets, specifier: "%.0f") sets", value:self.$sets, in:0...100)
                        Spacer()
                        Stepper("\(reps, specifier: "%.0f") reps", value:self.$reps, in:0...100)
                        
                    }
                    
                }
            }
            
            Section{
                Toggle(isOn: $rpeAlert.animation()){
                    HStack{
                        
                        Button(action:{
                            self.showingSheet.toggle()
                        }){
                            Image(systemName: "info.circle")
                        }.sheet(isPresented: $showingSheet) {
                            NavigationView{
                                Form{
                                    ForEach(self.rpeArray, id: \.self){ item in
                                        Text(item)
                                        
                                    }.navigationBarTitle("About R.P.E")
                                }
                            }
                        }
                        Text("RPE")
                    }
                    if rpeAlert{
                        Stepper(": \(rpe, specifier: "%.0f")", value:self.$rpe, in:0...10)
                    }
                }
                
            }
            
            
            
            
            Section{
                Button(action: {
                    self.goalAlert = true
                    self.itemName = self.pic.work[self.workItem.exercisePicker]
                    self.workItem.name = self.itemName
                    
                    self.workItem.weightLifted = self.weight
                    self.workItem.numberOfSets = self.sets
                    self.workItem.numberOfReps = self.reps
                    self.workItem.rpe = self.rpe
                    self.workItem.date = self.dateAdded
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                })
                {
                    HStack{
                        Image(systemName: "checkmark")
                        Text("Finish Workout")
                    }
                }   .onAppear(perform: {
                    self.itemName = self.workItem.name
                    
                    self.weight = self.workItem.weightLifted
                    
                    self.sets = self.workItem.numberOfSets
                    
                    self.reps = self.workItem.numberOfReps
                    self.rpe = self.workItem.rpe
                    self.dateAdded = self.workItem.date ?? self.dateAdded
                }).alert(isPresented: $goalAlert) { () -> Alert in
                    Alert(title: Text("Finish Workout"), message: Text("Finished with your workout?"), primaryButton: .default(Text("Yes"), action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }), secondaryButton: .default(Text("No")))
                }
                
            }
            
            
        }.navigationBarTitle("Add a Workout", displayMode: .inline)
        
        
    }
    
    
    
    
    
}

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}

struct menuView: View{
    var fielname = "Switch"
    @State var show = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var rpePic = ["Yes", "No"]
    @EnvironmentObject var pic : UnitPicker
    let strNumber = "https://apps.apple.com/us/app/irontrack/id1501092038?ls=1"
    var body: some View{
        NavigationView{
            Form{
                Section
                    {
                        NavigationLink(destination: unitsView())
                        {
                            Text("General")
                            
                        }
                        
                }
                
                Section
                    {
                        Button(action: {
                            self.isShowingMailView.toggle()
                        }) {
                            HStack(alignment: .center){
                                Text("Send Feedback")
                                Text("                                                  ")
                                Image(systemName: "paperplane")
                            }
                        }
                            //.disabled(!MFMailComposeViewController.canSendMail())
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(result: self.$result)
                        }
                        
                        
                        Button(action: {
                            
                            let formattedString = self.strNumber
                            let url = URL(string: formattedString)!
                            UIApplication.shared.open(url)
                        }) {
                            Text("Rate IronTrack")
                        }
                        
                }
                
                
                
            }.navigationBarTitle("Settings")
            
        }
    }
}


struct unitsView: View{
    @State var units = ["Imperial (lb)", "Metric (kg)"]
    
    @EnvironmentObject var pic : UnitPicker
    @Environment(\.presentationMode) var presentationMode
    @State var show = false
    @State var rpePic = ["Yes", "No"]
    var body: some View{
        
        Form{
            Section{
                Picker(selection: $pic.picker, label: Text("Weight Units"))
                {
                    ForEach(0..<units.count){
                        Text(self.units[$0]).tag($0)
                    }
                    
                    
                }
                
                
            }
            Section{
                Button(action: {
                    let defaults = UserDefaults.standard
                    defaults.set(self.pic.picker, forKey: "picker")
                    
                })
                {
                    Text("Save Units")
                }
            }
            
            
        }.navigationBarTitle("General", displayMode: .inline)
    }
    
}





struct WorkItemView_Previews: PreviewProvider {
    static var previews: some View {
        WorkItemView(workItem: WorkItem())
    }
}



/* Section(header: Text("Choose a Custom Exercise"))
 {
 
 
 TextField("Custom Exercise", text: self.$itemName)
 Button(action: {
 self.workItem.name = self.itemName
 self.customPick = false
 
 do {
 try self.managedObjectContext.save()
 } catch {
 print(error)
 }
 
 }){
 Text("Save")
 }
 
 
 .onAppear(perform: {
 self.itemName = self.workItem.name
 })
 }.disabled(newPick == false)
 */
