//
//  ContentView.swift
//  AsyncAwaitAndCombineApp
//
//  Created by Gordon Choi on 1/3/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.combineLabel)
            Text(viewModel.asyncAwaitLabel)
        }
        .padding()
        
        VStack {
            Button("Call Combine") {
                viewModel.callCombine()
            }
            
            Button("Call async/await") {
                Task {
                    await viewModel.callAsyncAwait()
                }
            }
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
