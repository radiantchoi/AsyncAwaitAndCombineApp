//
//  MyError.swift
//  AsyncAwaitAndCombine
//
//  Created by Gordon Choi on 12/30/23.
//

import Foundation

enum MyError: Error, LocalizedError {
    case anError
    
    var errorDescription: String? { "An error occured." }
    var recoverySuggestion: String? { "Please retry." }
}
