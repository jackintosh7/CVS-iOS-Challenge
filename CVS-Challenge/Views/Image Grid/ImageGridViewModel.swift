//
//  ImageGridViewModel.swift
//  CVS-Challenge
//
//  Created by Jack Higgins on 3/1/22.
//

import Foundation

class ImageGridViewModel: ObservableObject {
    
    @Published private(set) var images: [FlickrImage] = []
    @Published public var error: NetworkError?
    @Published public var showAlert = false
    @Published public var screenState: GridViewState = .home
    @Published public var searchText: String = "" {
        didSet {
            removeImages()
            if searchText.isEmpty {
                screenState = .home
            } else {
                searchImages(searchText: searchText)
            }
        }
    }
    
    private func removeImages() {
        DispatchQueue.main.async { [self] in
            images.removeAll()
        }
    }
    
    private func searchImages(searchText: String) {
        screenState = .isLoading
        APIService.shared.search(searchText: searchText) { [self] result in
            switch result {
            case .success(let flickrResponse):
                DispatchQueue.main.async {
                    images = flickrResponse.items ?? []
                    if !images.isEmpty {
                        screenState = .displayContent
                    } else {
                        screenState = .noResults
                    }
                }
            case .failure(let errorResult):
                DispatchQueue.main.async {
                    error = errorResult
                    showAlert = true 
                }
            }
        }
    }
}

// Enum that houses the various states of ImageGridView
public enum GridViewState {
    case home
    case noResults
    case isLoading
    case displayContent
}
