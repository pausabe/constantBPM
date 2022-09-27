//
//  StartView.swift
//  ConstantBPM Watch App
//
//  Created by Pau Sabé Martínez on 27/9/22.
//

import SwiftUI

struct StartView: View {

    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: SettingsView()) {
                    Text("...")
                        .font(.title)
                }
                NavigationLink(destination: MainView()) {
                    Text("START")
                        .font(.title)
                }
            }
        }
    }
}
