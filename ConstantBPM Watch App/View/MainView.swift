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
                Color(mainViewModel.currentColor ?? .darkGray)
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
