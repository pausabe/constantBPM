//
//  MainViewModel.swift
//  ConstantBPM Watch App
//
//  Created by Pau Sabé Martínez on 26/9/22.
//

import Foundation

class MainViewModel: ObservableObject, FetchUserConstantsServiceDelegate{
    @Published var userConstants = UserConstants()
    var fetchUserConstantsService: FetchUserConstantsServiceProtocol
    
    var currentlyFetching = false
            
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
    }
    
    func onTapGesture(){
        if currentlyFetching {
            stopFetching()
        }
        else {
            startFetching()
        }
    }

    func userConstantsUpdated(_ userConstants: UserConstants) {
        DispatchQueue.main.async {
            self.userConstants = userConstants
        }
    }
}
