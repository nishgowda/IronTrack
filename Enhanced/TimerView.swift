//
//  TimerView.swift
//  IronTrack2
//
//  Created by Nish Gowda on 2/25/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//
import SwiftUI
struct TimerView: View{
    
@State var timeRemaining = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isActive = true

@State var liftType = ["Heavy Weight", "Moderate Weight", "Light Weight"]
    @State var type = 0
    @EnvironmentObject var pic : UnitPicker
   
    var body: some View {
        NavigationView{
        Form{
            Section{
                Picker("", selection: $pic.timePicker)
                {
                    ForEach(0..<liftType.count)
                    {
                        Text(self.liftType[$0]).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
       
            }
            Section(header: Text("Rest Timer")){
                Button(action: {
                    self.timeCount()
                })
                {
                    Text("Start Timer")
                }
                Text("\(timeRemaining) seconds")
         .onReceive(timer) { time in
                guard self.isActive else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
            }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    self.isActive = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    self.isActive = true
                }
            }
            Section{
                CountDownView(referenceDate: Date())
            }
            
        }.navigationBarTitle("Timer")
        }
    }
    func timeCount(){
         timeRemaining=0
           if(type == 0)
           {
               timeRemaining+=180
               }
           if(type == 1)
           {
               timeRemaining+=120
           }
           if (type == 2)
           {
               timeRemaining+=60
           }
       }
}

struct CountDownView : View {
    
    @State var nowDate: Date = Date()
    let referenceDate: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        
      
            Section{

                    Text(self.countDownString(from: self.referenceDate))
                       .onAppear(perform: {
                           _ = self.timer
                       })
        }
        }
       
    

    func countDownString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.hour, .minute, .second],
                            from: nowDate,
                            to: referenceDate)
        return String(format: "%02dh:%02dm:%02ds",
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }

}

