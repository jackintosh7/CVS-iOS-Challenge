//
//  APIService.swift
//  CVS-Challenge
//
//  Created by Jack Higgins on 3/1/22.
//

import Foundation
import Alamofire

struct APIService {
    static let shared = APIService()
    
    func search(searchText: String, completion: @escaping (Result<FlickrResponseModel, NetworkError>) -> Void) {
        // Remove spaces from searchText to prevent .badResponse
        let endpoint = AppConstants.baseURL + searchText.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        // We need to cancel previous requests as one typing really fast can result in a race condition where and old search finishes
        // before the last one. Other options would be DispatchQueue and Sephamores that would guarantee the requests are made sequentially,
        // however this can result in slower performance.
        cancelRequests {
            AF.request(endpoint, method: .get).responseDecodable(of: FlickrResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    if !error.isExplicitlyCancelledError {
                        completion(.failure(.badResponse))
                    }
                }
            }
        }
    }
    
    func cancelRequests(completion: (() -> Void)? = nil) {
        AF.cancelAllRequests(completion: completion)
    }
}

