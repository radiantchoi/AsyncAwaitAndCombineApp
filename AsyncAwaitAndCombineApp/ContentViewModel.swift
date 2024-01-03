//
//  ContentViewModel.swift
//  AsyncAwaitAndCombineApp
//
//  Created by Gordon Choi on 1/3/24.
//

import Combine
import Foundation

final class ContentViewModel: ObservableObject {
    @Published private(set) var combineLabel = "Combine Loading..."
    @Published private(set) var asyncAwaitLabel = "async/await Loading..."
    
    private let bridge = AsynchronousBridge()
    private var cancellables = Set<AnyCancellable>()
    
    func callCombine() {
        Task {
            await bridge.asyncAwaitToCombine(succeeds: true)
                .sink(receiveCompletion: { completion in
                    print(completion)
                }) { [weak self] message in
                    self?.combineLabel = message
                }
                .store(in: &cancellables)
        }
    }
    
    func callAsyncAwait() async {
        do {
            asyncAwaitLabel = try await bridge.combineToAsyncAwait(succeeds: true)
        } catch let error {
            print(error)
        }
    }
}
