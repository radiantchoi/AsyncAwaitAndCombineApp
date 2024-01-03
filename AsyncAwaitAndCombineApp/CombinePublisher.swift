//
//  CombinePublisher.swift
//  AsyncAwaitAndCombine
//
//  Created by Gordon Choi on 12/30/23.
//

import Combine

struct CombinePublisher {
    func publish(succeeded result: Bool) -> AnyPublisher<String, MyError> {
        return Future { promise in
            result
            ? promise(.success(Array(1...99).map { String($0) }.randomElement()!))
            : promise(.failure(MyError.anError))
        }
        .eraseToAnyPublisher()
    }
}
