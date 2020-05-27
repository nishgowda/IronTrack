//
//  GraphView.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/14/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI

struct TotalGraphView: View{
    @State var picker = 0
    var body: some View{
        NavigationView{
            VStack(alignment: .center){
                Picker("Exercises: ", selection: $picker)
                {
                    Text("D").tag(0)
                    Text("W").tag(1)
                    Text("M").tag(2)
                    
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 24)
                if picker == 0{
                    DayGraphView()
                }
                else if picker == 1{
                    WeekGraphView()
                }
                else if picker == 2{
                    MonthGraphView()
                }
                
            }.navigationBarTitle("Feed")
        }
    }
}

struct DayGraphView: View {
    @FetchRequest(fetchRequest: WorkItem.getWorkItemFetchRequest()) var workItems: FetchedResults<WorkItem>
    
    func sumWorkWeek(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.weekday, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.weightLifted }
    }
    func sumRepsWeek(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.weekday, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.numberOfReps }
    }
    
    func sumSetsWeek(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.weekday, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.numberOfSets }
    }
    
    func totalWorkWeek(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.weekday, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + ($1.weightLifted * $1.numberOfReps * $1.numberOfSets) }
    }
    
    func dayAbbreviationFromInt(_ day: Int) -> String {
        let da = Calendar.current.shortWeekdaySymbols
        return da[day]
    }
    
    @State var showingSheet = false
    @State var graphData = ["D","M"]
    @State var picker = 0
    var body: some View {
        // 1
        Form{
            Section(header: Text("Total Work Performed per Day")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<7) { day in
                        // 3
                        VStack{
                            // 4
                            Spacer()
                            Text("\(self.totalWorkWeek(day), specifier: "%.0f")")
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.totalWorkWeek(day))/500)
                            
                            // 6
                            Text("\(self.dayAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
            
            
            Section(header: Text("Total Weight Lifted per Day")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<7) { day in
                        // 3
                        VStack{
                            // 4
                            Spacer()
                            Text("\(self.sumWorkWeek(day), specifier: "%.0f")").font(.headline).fontWeight(.light)
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.sumWorkWeek(day)) / 20)
                            
                            // 6
                            Text("\(self.dayAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
            Section(header: Text("Total Reps Performed per Day")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<7) { day in
                        // 3
                        VStack{
                            // 4
                            Spacer()
                            Text("\(self.sumRepsWeek(day), specifier: "%.0f")").font(.headline).fontWeight(.light)
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.sumRepsWeek(day)) / 5)
                            
                            // 6
                            Text("\(self.dayAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
            
            Section(header: Text("Total Sets Performed per Day")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<7) { day in
                        // 3
                        VStack {
                            // 4
                            Spacer()
                            Text("\(self.sumSetsWeek(day), specifier: "%.0f")").font(.headline).fontWeight(.light)
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.sumSetsWeek(day)))
                            
                            // 6
                            Text("\(self.dayAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
        }
        
    }
}

struct WeekGraphView: View{
    @FetchRequest(fetchRequest: WorkItem.getWorkItemFetchRequest()) var workItems: FetchedResults<WorkItem>
    
    func sumWorkWeek(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.weekOfMonth, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.weightLifted }
    }
    func sumRepsWeek(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.weekOfMonth, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.numberOfReps }
    }
    
    func sumSetsWeek(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.weekOfMonth, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.numberOfSets }
    }
    
    func totalWorkWeek(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.weekOfMonth, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.weightLifted * $1.numberOfReps * $1.numberOfSets }
    }
    
    func weekAbbreviationFromInt(_ day: Int) -> String {
        let da = Calendar.current.shortQuarterSymbols
        return da[day]
    }
    var body: some View{
        Form{
            
            Section(header: Text("Total Work Done per Week")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<4) { day in
                        // 3
                        VStack{
                            // 4
                            Spacer()
                            Text("\(self.totalWorkWeek(day), specifier: "%.0f")")
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.totalWorkWeek(day))/300)
                            
                            // 6
                            Text("\(self.weekAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
            Section(header: Text("Total Weight Lifted per Week")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<4) { day in
                        // 3
                        VStack{
                            // 4
                            Spacer()
                            Text("\(self.sumWorkWeek(day), specifier: "%.0f")").font(.headline).fontWeight(.light)
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.sumWorkWeek(day)) / 20)
                            
                            // 6
                            Text("\(self.weekAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
            Section(header: Text("Total Reps Performed per Week")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<4) { day in
                        // 3
                        VStack{
                            // 4
                            Spacer()
                            Text("\(self.sumRepsWeek(day), specifier: "%.0f")").font(.headline).fontWeight(.light)
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.sumRepsWeek(day)) / 5)
                            
                            // 6
                            Text("\(self.weekAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
            
            Section(header: Text("Total Sets Performed per Week")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<4) { day in
                        // 3
                        VStack {
                            // 4
                            Spacer()
                            Text("\(self.sumSetsWeek(day), specifier: "%.0f")").font(.headline).fontWeight(.light)
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.sumSetsWeek(day)))
                            
                            // 6
                            Text("\(self.weekAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
        }
    }
}




struct MonthGraphView : View{
    @FetchRequest(fetchRequest: WorkItem.getWorkItemFetchRequest()) var workItems: FetchedResults<WorkItem>
    
    func sumWorkMonth(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.month, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.weightLifted }
    }
    func sumRepsMonth(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.month, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.numberOfReps }
    }
    
    func sumSetsMonth(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.month, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.numberOfSets }
    }
    
    func totalWorkMonth(_ day: Int) -> Double {
        self.workItems
            .filter {
                Calendar.current.component(.month, from: $0.date ?? Date()) == day + 1
        }
        .reduce(0) { $0 + $1.weightLifted * $1.numberOfReps * $1.numberOfSets }
    }
    
    func monthAbbreviationFromInt(_ day: Int) -> String {
        let da = Calendar.current.shortMonthSymbols
        return da[day]
    }
    var body: some View{
        Form{
            
            Section(header: Text("Total Work Performed per Month")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<12) { day in
                        // 3
                        VStack{
                            // 4
                            Spacer()
                            Text("\(self.totalWorkMonth(day), specifier: "%.0f")")
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.totalWorkMonth(day))/300)
                            
                            // 6
                            Text("\(self.monthAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
            Section(header: Text("Total Weight Lifted per Month")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<12) { day in
                        // 3
                        VStack{
                            // 4
                            Spacer()
                            Text("\(self.sumWorkMonth(day), specifier: "%.0f")").font(.headline).fontWeight(.light)
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.sumWorkMonth(day)) / 20)
                            
                            // 6
                            Text("\(self.monthAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
            Section(header: Text("Total Reps Performed per Month")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<12) { day in
                        // 3
                        VStack{
                            // 4
                            Spacer()
                            Text("\(self.sumRepsMonth(day), specifier: "%.0f")").font(.headline).fontWeight(.light)
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.sumRepsMonth(day)) / 5)
                            
                            // 6
                            Text("\(self.monthAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
            
            Section(header: Text("Total Sets Performed per Month")){
                HStack (alignment: .center){
                    // 2
                    ForEach(0..<12) { day in
                        // 3
                        VStack {
                            // 4
                            Spacer()
                            Text("\(self.sumSetsMonth(day), specifier: "%.0f")").font(.headline).fontWeight(.light)
                                .font(.footnote)
                                .rotationEffect(.degrees(-90))
                                //  .offset(y: self.sumWork(day) < 2.4 ? 0 : 35)
                                .zIndex(1)
                            // 5
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 20, height: CGFloat(self.sumSetsMonth(day)))
                            
                            // 6
                            Text("\(self.monthAbbreviationFromInt(day))")
                                .font(.footnote)
                                .frame(height: 20)
                        }
                    }
                }
            }
        }
    }
}

