//
//  AsyncAwaitHandler.swift
//  AsyncAwaitAndCombine
//
//  Created by Gordon Choi on 12/30/23.
//

import Foundation

struct AsyncAwaitHandler {
    func handle(succeeded result: Bool) async throws -> String {
        guard result else { throw MyError.anError }
        return Array(1...99).map { String($0) }.randomElement()!
    }
}
