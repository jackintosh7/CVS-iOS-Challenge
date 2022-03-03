//
//  FlickrImage+SizeUtility.swift
//  CVS-Challenge
//
//  Created by Jack Higgins on 3/2/22.
//

import Foundation
import SwiftSoup

struct ImageSize: Equatable {
    let width: String
    let height: String
}

enum ImageSizeError: Error, Equatable {
    case noWidth
    case noHeight
    case noImgSource
    case unableToParse
}

extension FlickrImage {
    static func getImageSize(desc: String, completionHandler: @escaping (Result<ImageSize, ImageSizeError>) -> ()) {
        do {
            let doc: Document = try SwiftSoup.parse(desc)
            guard let imageSrc = try? doc.select("img[src]").first() else {
                completionHandler(.failure(.noImgSource))
                return
            }
            
            guard let width = try? imageSrc.attr("width"), !width.isEmpty else {
                completionHandler(.failure(.noWidth))
                return
            }
            
            guard let height = try? imageSrc.attr("height"), !height.isEmpty else {
                completionHandler(.failure(.noHeight))
                return
            }
            
            let size = ImageSize(width: width, height: height)
            completionHandler(.success(size))
        } catch {
            print("error")
            completionHandler(.failure(.unableToParse))
        }
    }
}
