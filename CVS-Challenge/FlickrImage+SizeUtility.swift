//
//  FlickrImage+SizeUtility.swift
//  CVS-Challenge
//
//  Created by Jack Higgins on 3/2/22.
//

import Foundation
import SwiftSoup

struct ImageSize {
    let width: String
    let height: String
}

enum ImageSizeError: Error {
    case noWidth
    case noHeight
    case noImgSource
    case unableToParse(message: String)
}

extension FlickrImage {
    func getImageSize(completionHandler: @escaping (Result<ImageSize, ImageSizeError>) -> ()) {
        do {
            let doc: Document = try SwiftSoup.parse(self.description)
            guard let imageSrc = try doc.select("img[src]").first() else {
                completionHandler(.failure(.noImgSource))
                return
            }
            
        
            guard let width = try? imageSrc.attr("width") else {
                completionHandler(.failure(.noWidth))
                return
            }
            
            guard let height = try? imageSrc.attr("height") else {
                completionHandler(.failure(.noHeight))
                return
            }
            
            let size = ImageSize(width: width, height: height)
            completionHandler(.success(size))
        } catch Exception.Error(_, let message) {
            print(message)
            completionHandler(.failure(.unableToParse(message: "Unknown parse error")))
        } catch {
            print("error")
            completionHandler(.failure(.unableToParse(message: "Unknown parse error")))
        }
    }
}
