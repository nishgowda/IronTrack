//
//  TImerManager.swift
//  IronTrack2
//
//  Created by Nish Gowda on 3/1/20.
//  Copyright © 2020 Nish Gowda. All rights reserved.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject{
    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
    var timer = Timer()
    
   
    
    func start(){
        timerMode = .running
      timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {Timer in
                   if self.secondsLeft == 0{
                    self.reset()
                       self.secondsLeft = 60
                    self.timer.invalidate()
                   }
        self.secondsLeft -= 1
               })
    }
    func reset(){
        self.timerMode = .initial
       self.secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
       
    }
    func pause(){
        self.timerMode = .paused
        timer.invalidate()
    }
    func setTimerLength(minutes: Int){
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
    }
}
