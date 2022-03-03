//
//  ImageDetailViewModel.swift
//  CVS-Challenge
//
//  Created by Jack Higgins on 3/1/22.
//

import SwiftUI


class ImageDetailViewModel: ObservableObject {
    @Published public var flickrImage: FlickrImage
    @Published public var imageSize: String = ""
    
    init(flickrImage: FlickrImage) {
        self.flickrImage = flickrImage
        getImageSize()
    }
    
    func getImageSize() {
        FlickrImage.getImageSize(desc: flickrImage.description) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imgSize):
                    imageSize = "\(imgSize.width) x \(imgSize.height)"
                case .failure(let errorResult):
                    print(errorResult)
                    imageSize = "0 x 0"
                }
            }
        }
    }
}
