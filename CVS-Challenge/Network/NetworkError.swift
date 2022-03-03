//
//  NetworkError.swift
//  CVS-Challenge
//
//  Created by Jack Higgins on 3/1/22.
//

import Foundation

enum NetworkError: Error {
    case noData
    case badResponse
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return NSLocalizedString(
                "Something went wrong with this search, please try another.",
                comment: ""
            )
        case .badResponse:
            return NSLocalizedString(
                "Network error, please try again.",
                comment: ""
            )
        }
    }
}
