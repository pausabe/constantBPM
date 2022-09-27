//
//  ContentView.swift
//  ConstantBPM Watch App
//
//  Created by Pau Sabé Martínez on 26/9/22.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var mainViewModel = MainViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.00))
                HStack {
                    Text(String(Int(mainViewModel.userConstants.heartRate)))
                        .font(.title)
                    Text("BPM")
                        .font(.title)
                }
            }
        }
        .onAppear(){
            mainViewModel.onAppear()
        }
        .onDisappear(){
            mainViewModel.onDisappear()
        }
        .onTapGesture {
            mainViewModel.onTapGesture()
        }
        .navigationBarBackButtonHidden(true)
        .onLongPressGesture {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
