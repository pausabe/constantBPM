//
//  SettingsViewModel.swift
//  ConstantBPM Watch App
//
//  Created by Pau Sabé Martínez on 27/9/22.
//

import Foundation

class SettingsViewModel: ObservableObject{
    @Published var heartRateTarget: Int
    let step = 5
    let defaultHeartRateTarger = 150
    let minimumHeartRateTarget = 20
    let maximumHeartRateTarget = 250
    let defaults = UserDefaults.standard
    
    init(){
        if defaults.object(forKey: DefaultsKeys.heartRateTarget) == nil{
            heartRateTarget = defaultHeartRateTarger
            saveHeartRateTarget()
        }
        else{
            heartRateTarget = defaults.integer(forKey: DefaultsKeys.heartRateTarget)
        }
    }
    
    func increaseHeartRate(){
        if heartRateTarget + step > maximumHeartRateTarget {
            heartRateTarget = maximumHeartRateTarget
        }
        else{
            heartRateTarget += step
        }
        saveHeartRateTarget()
    }
    
    func decreaseHeartRate(){
        if heartRateTarget - step < minimumHeartRateTarget {
            heartRateTarget = minimumHeartRateTarget
        }
        else{
            heartRateTarget -= step
        }
        saveHeartRateTarget()
    }
    
    func saveHeartRateTarget(){
        defaults.set(heartRateTarget, forKey: DefaultsKeys.heartRateTarget)
    }
}
