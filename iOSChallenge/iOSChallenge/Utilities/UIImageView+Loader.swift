//
//  UIImageView+Loader.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//


import UIKit

extension UIImageView {
    func setImage(from urlString: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: urlString) else { return }
        ImageLoader.shared.load(from: url, into: self, placeholder: placeholder)
    }

    func cancelImageLoad() {
        ImageLoader.shared.cancel(for: self)
    }
}
