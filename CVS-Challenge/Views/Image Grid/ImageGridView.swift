//
//  ImageGridView.swift
//  CVS-Challenge
//
//  Created by Jack Higgins on 3/1/22.
//

import SwiftUI
import Kingfisher

struct ImageGridView: View {
    @ObservedObject var viewModel: ImageGridViewModel = ImageGridViewModel()
    @State private var toDetailView = false
    @State private var selectedImage: FlickrImage?
    
    private var threeColumnGrid = [GridItem(), GridItem(), GridItem()]
    var body: some View {
        NavigationView {
            VStack {
                if let selectedImage = selectedImage {
                    NavigationLink(destination: ImageDetailView(flickrImage: selectedImage), isActive: $toDetailView) { EmptyView() }
                }
               
                TextField("Apples", text: $viewModel.searchText)
                    .padding()
                    .textFieldStyle(.roundedBorder)
             
                switch viewModel.screenState {
                case .home:
                    Text("Use the search bar above to find a 🖼️")
                        .foregroundColor(.gray)
                case .isLoading:
                    ProgressView()
                case .noResults:
                    Text("No results for \(viewModel.searchText)")
                case .displayContent:
                    gridView
                }
                Spacer()
            }
            .navigationTitle("Flickr Image Search")
        }
        .alert(viewModel.error?.errorDescription ?? "Something went wrong",
               isPresented: $viewModel.showAlert) {
        }
    }
    
    var gridView: some View {
        ScrollView {
            LazyVGrid(columns: threeColumnGrid) {
                ForEach(viewModel.images) { item in
                    KFImage(item.media)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            selectedImage = item
                            toDetailView = true
                        }
                }
            }
        }
    }
}
