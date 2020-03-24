//
//  AppView.swift
//  IronTrack2
//
//  Created by Nish Gowda on 2/25/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import SwiftUI

struct AppView: View {
      
    var body: some View {
        TabView{
            TotalGraphView().tabItem{
                           Image(systemName: "chart.bar")
                           Text("Feed")
                       }
            ContentView().tabItem{
                Image(systemName: "book")
                Text("Workouts")
            }
           
            
            StopWatch().tabItem{
                Image(systemName: "clock")
                  Text("Rest Timer")
            }
            
            LoadWorkouts(workItem: WorkItem()).tabItem{
                Image(systemName: "list.dash")
                Text("Exercises")
            }
            menuView().tabItem{
                Image(systemName: "gear")
                  Text("Settings")
            }
        }
    }

}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
