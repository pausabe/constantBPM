//
//  MainViewModel.swift
//  ConstantBPM Watch App
//
//  Created by Pau Sabé Martínez on 26/9/22.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject, FetchUserConstantsServiceDelegate{
    let okColor = UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.00)
    let notOkColor = UIColor(red: 0.80, green: 0.00, blue: 0.00, alpha: 1.00)
    
    @Published var userConstants = UserConstants()
    @Published var currentColor: UIColor?
    
    var fetchUserConstantsService: FetchUserConstantsServiceProtocol
    var currentlyFetching = false
    let heartRateTargetOffset = 10
    
    let defaults = UserDefaults.standard
            
    init(){
        fetchUserConstantsService = FetchUserConstantsService()
        fetchUserConstantsService.delegate = self
    }
    
    func onAppear(){
        startFetching()
    }
    
    func startFetching(){
        currentlyFetching = true
        fetchUserConstantsService.startFetching()
    }
    
    func onDisappear(){
        stopFetching()
    }
    
    func stopFetching(){
        currentlyFetching = false
        fetchUserConstantsService.stopFetching()
        currentColor = nil
    }
    
    func onTapGesture(){
        if currentlyFetching {
            stopFetching()
        }
        else {
            startFetching()
        }
    }

    func correctHeartRate() -> Bool{
        let heartRateTarget = defaults.integer(forKey: DefaultsKeys.heartRateTarget)
        if Int(userConstants.heartRate) > heartRateTarget + heartRateTargetOffset {
            return false
        }
        else if Int(userConstants.heartRate) < heartRateTarget - heartRateTargetOffset {
            return false
        }
        return true
    }
    
    func userConstantsUpdated(_ userConstants: UserConstants) {
        DispatchQueue.main.async {
            self.userConstants = userConstants
            var backgroundColor = self.notOkColor
            if self.correctHeartRate(){
                backgroundColor = self.okColor
            }
            self.currentColor = backgroundColor
        }
    }
}
