//
//  FetchDataView.swift
//  SimpleNetworkingApp_SwiftUI
//
//  Created by Saša Brezovac on 13.09.2023..
//

import SwiftUI

struct FetchDataView: View {
    @ObservedObject var viewModel = FetchDataViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Networking")
                .font(.headline)
                .padding()
            
            Image(systemName: viewModel.textColor != .black ? viewModel.textColor == .green ? "checkmark" : "xmark" : "globe")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(viewModel.textColor != .black ? viewModel.textColor == .green ? .green : .red : .accentColor)
                .padding()
            
            Text(viewModel.showObject?.name ?? "-> Show <-")
                .foregroundColor(.black)
                .padding()
            
            Spacer()
            
            Section {
                Button {
                    viewModel.fetchDataSimple()
                } label: {
                    Text("Fetch data - Simple")
                }
                .padding()
                
                Button {
                    viewModel.fetchData()
                } label: {
                    Text("Fetch data")
                        .foregroundColor(viewModel.textColor)
                }
                .padding()
            }
            
            Spacer()
            
            Button {
                viewModel.reset()
            } label: {
                Text("Reset UI")
                    .foregroundColor(.black)
            }
            .padding()
        }
        .padding()
    }
}

struct FetchDataView_Previews: PreviewProvider {
    static var previews: some View {
        FetchDataView()
    }
}
