//
//  AsynchronousBridge.swift
//  AsyncAwaitAndCombine
//
//  Created by Gordon Choi on 12/30/23.
//

import Combine
import Foundation

struct AsynchronousBridge {
    private let combinePublisher: CombinePublisher
    private let asyncAwaitHandler: AsyncAwaitHandler
    
    init(combinePublisher: CombinePublisher = CombinePublisher(),
         asyncAwaitHandler: AsyncAwaitHandler = AsyncAwaitHandler()) {
        self.combinePublisher = combinePublisher
        self.asyncAwaitHandler = asyncAwaitHandler
    }
    
    func combineToAsyncAwait(succeeds result: Bool) async throws -> String {
        return try await combinePublisher.publish(succeeded: result).asyncThrows()
    }
    
    func asyncAwaitToCombine(succeeds result: Bool) async -> AnyPublisher<String, MyError> {
        guard let executionResult = try? await asyncAwaitHandler.handle(succeeded: result) else {
            return Future { promise in
                promise(.failure(MyError.anError))
            }
            .eraseToAnyPublisher()
        }
        
        return Future { promise in
            promise(.success(executionResult))
        }
        .eraseToAnyPublisher()
    }
}

extension AnyPublisher where Failure: Error {
    func asyncThrows() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?
            cancellable = first()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                } receiveValue: { value in
                    continuation.resume(with: .success(value))
                }
        }
    }
}
