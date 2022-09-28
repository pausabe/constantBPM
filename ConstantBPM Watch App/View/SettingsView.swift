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
        HStack(alignment: .center, spacing: 0.0){
            Button("-", action: settingsViewModel.decreaseHeartRate)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .font(.title2)
            Text(String(Int(settingsViewModel.heartRateTarget)))
                .font(.title)
                .lineLimit(1)
            Button("+", action: settingsViewModel.increaseHeartRate)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .font(.title2)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
