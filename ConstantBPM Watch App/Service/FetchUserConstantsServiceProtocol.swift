//
//  FetchUserConstantsServiceProtocol.swift
//  ConstantBPM Watch App
//
//  Created by Pau Sabé Martínez on 27/9/22.
//

import Foundation

protocol FetchUserConstantsServiceProtocol{
    var delegate: FetchUserConstantsServiceDelegate? { get set }
    
    func startFetching()
    func stopFetching()
}
