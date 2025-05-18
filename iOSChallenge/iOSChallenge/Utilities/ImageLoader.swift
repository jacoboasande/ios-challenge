//
//  ImageLoader.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import UIKit

final class ImageLoader {
    static let shared = ImageLoader()

    private let cache = NSCache<NSURL, UIImage>()
    private var runningRequests = [UIImageView: URLSessionDataTask]()

    private init() {}

    func load(from url: URL, into imageView: UIImageView, placeholder: UIImage? = nil) {
        cancel(for: imageView)

        if let cached = cache.object(forKey: url as NSURL) {
            imageView.image = cached
            return
        }

        imageView.image = placeholder

        let task = URLSession.shared.dataTask(with: url) { [weak self, weak imageView] data, _, error in
            guard
                let self = self,
                let data = data,
                let image = UIImage(data: data),
                error == nil
            else { return }

            self.cache.setObject(image, forKey: url as NSURL)

            DispatchQueue.main.async {
                if let imageView = imageView {
                    imageView.image = image
                }
            }
        }

        runningRequests[imageView] = task
        task.resume()
    }

    func cancel(for imageView: UIImageView) {
        runningRequests[imageView]?.cancel()
        runningRequests.removeValue(forKey: imageView)
    }
}
