//
//  ImageDetailView.swift
//  CVS-Challenge
//
//  Created by Jack Higgins on 3/1/22.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject private var viewModel: ImageDetailViewModel
    
    init(flickrImage: FlickrImage) {
        _viewModel = ObservedObject(wrappedValue: ImageDetailViewModel(flickrImage: flickrImage))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // Since we already downloaded the image,
            // we really shouldn't do it again..
            ScrollView {
                KFImage(viewModel.flickrImage.media)
                    .resizable()
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.flickrImage.title)
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .padding(.bottom)
                        ImageDetail(property: "Tags:", text: viewModel.flickrImage.tags)
                            .padding(.bottom)
                        ImageDetail(property: "Width & Heightze:", text: viewModel.imageSize)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .navigationTitle("Image Details")
    }
}

struct ImageDetail: View {
    
    var property: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(property)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(text)
                .padding(.bottom, 5)
        }
    }
}
