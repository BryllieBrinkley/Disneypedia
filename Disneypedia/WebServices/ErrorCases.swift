//
//  ErrorCases.swift
//  Disneypedia
//
//  Created by Jibryll Brinkley on 10/16/24.
//

import Foundation

enum ErrorCases: LocalizedError {
    case invalidURL, invalidResponse, invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "invalid url"
        case .invalidResponse: return "invalid response"
        case .invalidData: return "invalid data"
        }
    }
    
}
