//
//  SettingsView.swift
//  ConstantBPM Watch App
//
//  Created by Pau Sabé Martínez on 27/9/22.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsViewModel = SettingsViewModel()

    var body: some View {
        HStack{
            Button("-", action: settingsViewModel.decreaseHeartRate)
            Text("150 BPM")
                .font(.title)
            Button("+", action: settingsViewModel.increaseHeartRate)
        }
    }
}
