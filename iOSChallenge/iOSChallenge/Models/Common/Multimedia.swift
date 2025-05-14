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
    let tag: String
    let localizedName: String?
    let multimediaId: Int?
}
