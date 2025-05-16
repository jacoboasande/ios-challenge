//
//  Multimedia.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import Foundation

struct Multimedia: Codable {
    let images: [Image]
}

struct Image: Codable {
    let url: String
    let tag: ImageTag
    let localizedName: String?
    let multimediaId: Int?
}

enum ImageTag: String, Codable {
    case bathroom
    case bedroom
    case corridor
    case energyCertification
    case facade
    case hall
    case kitchen
    case livingRoom
    case unknown
    case views
    case communalareas

    var localized: String {
        NSLocalizedString(self != .unknown ? "imagetag.\(rawValue)" : "", comment: "")
    }
}

