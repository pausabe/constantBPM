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
            NavigationLink(destination: MainView()) {
                Text("START")
                    .font(.title)
            }
            .buttonStyle(PlainButtonStyle())
            .overlay(
                NavigationLink(destination: SettingsView()) {
                    Text("···")
                }
                .offset(x: 50, y: -60)
                .padding(10)
            )
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
