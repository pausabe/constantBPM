//
//  FetchUserConstantsService.swift
//  ConstantBPM Watch App
//
//  Created by Pau Sabé Martínez on 27/9/22.
//

import Foundation
import HealthKit

class FetchUserConstantsService: FetchUserConstantsServiceProtocol{
    var delegate: FetchUserConstantsServiceDelegate?
    var timer: Timer?
    let timeInterval = 1.0
    let healthStore = HKHealthStore()
    var workoutSession: HKWorkoutSession?
    
    init(){
        autorizeHealthStore()
    }
    
    func autorizeHealthStore(){
        let share = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
        let read = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
        
        healthStore.requestAuthorization(toShare: share, read: read){ (chk, error) in }
    }
    
    func startFetching() {
        startActivitySession()
        fetchLastHeartRate()
        startTimer()
    }
    
    func startActivitySession(){
        if workoutSession == nil{
            do{
                workoutSession = try HKWorkoutSession(healthStore: healthStore, configuration: HKWorkoutConfiguration())
            }
            catch{
                return
            }
        }
        workoutSession!.startActivity(with: Date())
    }
    
    func startTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: timeInterval,
            target: self,
            selector: #selector(fetchLastHeartRate),
            userInfo: nil,
            repeats: true)
    }
    
    func stopFetching() {
        timer?.invalidate()
    }
    
    @objc
    func fetchLastHeartRate(){
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else{
            return
        }
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: sampleType,
            predicate: predicate,
            limit: Int(HKObjectQueryNoLimit),
            sortDescriptors: [sortDescriptor]) {(sample, result, error) in
                guard error == nil && (result != nil) && result!.count > 0 else{
                    return
                }
                let data = result![0] as! HKQuantitySample
                let unit = HKUnit(from: "count/min")
                let latestHeartRate = data.quantity.doubleValue(for: unit)
                var userConstants = UserConstants()
                userConstants.heartRate = latestHeartRate
                self.delegate?.userConstantsUpdated(userConstants)
            }
        healthStore.execute(query)
    }
}
