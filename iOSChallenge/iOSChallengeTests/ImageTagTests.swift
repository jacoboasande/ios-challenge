//
//  ImageTagTests.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 17/5/25.
//

import XCTest
@testable import iOSChallenge

class ImageTagTests: XCTestCase {
    func testLocalizedReturnsCorrectKey() {
        let tag = ImageTag.livingRoom
        // Localizable.strings contains "imagetag.livingRoom" = "Some Value";
        XCTAssertEqual(tag.localized, NSLocalizedString("imagetag.livingRoom", comment: ""))
    }
}
