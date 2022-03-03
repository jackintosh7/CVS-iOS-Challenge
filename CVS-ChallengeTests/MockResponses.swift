//
//  MockResponses.swift
//  CVS-ChallengeTests
//
//  Created by Jack Higgins on 3/3/22.
//

import Foundation


// Descriptions returned by the Flickr API contain the height and width of images.
struct MockDescriptions {
    static let valid = " <p><a href='https://www.flickr.com/people/39885565@N02/'>J Telljohann</a> posted a photo:</p> <p><a href='https://www.flickr.com/photos/39885565@N02/51914908191/' title='DSC_4637 e5 10x8'><img src='https://live.staticflickr.com/65535/51914908191_e2784240b7_m.jpg' width='240' height='192' alt='DSC_4637 e5 10x8' /></a></p> "
    
    static let badHeight = " <p><a href='https://www.flickr.com/people/39885565@N02/'>J Telljohann</a> posted a photo:</p> <p><a href='https://www.flickr.com/photos/39885565@N02/51914908191/' title='DSC_4637 e5 10x8'><img src='https://live.staticflickr.com/65535/51914908191_e2784240b7_m.jpg' width='240' height='' alt='DSC_4637 e5 10x8' /></a></p> "
    
    static let badWidth = " <p><a href='https://www.flickr.com/people/39885565@N02/'>J Telljohann</a> posted a photo:</p> <p><a href='https://www.flickr.com/photos/39885565@N02/51914908191/' title='DSC_4637 e5 10x8'><img src='https://live.staticflickr.com/65535/51914908191_e2784240b7_m.jpg' width='' height='192' alt='DSC_4637 e5 10x8' /></a></p> "
    
    static let noSourceImg = " <p><a href='https://www.flickr.com/people/39885565@N02/'>J Telljohann</a> posted a photo:</p> <p><a href='https://www.flickr.com/photos/39885565@N02/51914908191/' title='DSC_4637 e5 10x8'>< width='240' height='192' alt='DSC_4637 e5 10x8' /></a></p> "
}
