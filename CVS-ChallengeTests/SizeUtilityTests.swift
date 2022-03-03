//
//  FlickrImage+SizeUtilityTests.swift
//  CVS-ChallengeTests
//
//  Created by Jack Higgins on 3/3/22.
//

import XCTest
@testable import CVS_Challenge

class FlickrImage_SizeUtilityTests: XCTestCase {

    func testValidHeightWidth() {
        FlickrImage.getImageSize(desc: MockDescriptions.valid) { result in
            XCTAssertEqual(result, .success(ImageSize(width: "240", height: "192")))
        }
    }
    
    func testBadHeight() {
        FlickrImage.getImageSize(desc: MockDescriptions.badHeight) { result in
            XCTAssertEqual(result, .failure(.noHeight))
        }
    }
    
    func testBadWidth() {
        FlickrImage.getImageSize(desc: MockDescriptions.badWidth) { result in
            XCTAssertEqual(result, .failure(.noWidth))
        }
    }
    
    func testNoSourceImg() {
        FlickrImage.getImageSize(desc: MockDescriptions.noSourceImg) { result in
            XCTAssertEqual(result, .failure(.noImgSource))
        }
    }
}
