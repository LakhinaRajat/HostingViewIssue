//
//  ImageViewModel.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 05/02/24.
//

import UIKit

enum ImageLoadingError: Error {
    case invalidImageData
}

final class ImageViewModel: ObservableObject {
    @Published var image: UIImage?
    var urlString: String?

    private var imageCache: NSCache<NSString, UIImage>?

    init(urlString: String?) {
        self.urlString = urlString
    }

    func loadImage() async {
        guard let urlString = urlString,
                let url = URL(string: urlString) else { return }
        
        if let imageFromCache = getImageFromCache(from: urlString) {
            DispatchQueue.main.async { [weak self] in
                self?.image = imageFromCache
            }
            return
        }
        
        
        do {
            _ = try await loadImageFromURL(urlString: urlString)
            // Do something with the loadedImage
        } catch {
            // Handle the error
        }
    }

    private func loadImageFromURL(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InRqcHFmN2o4eDlwbWIyNCIsIl9pZCI6IjY1YzFlMWUxMmViY2I5NjkyMzQwYTVmNiJ9.KP9rwUvzEHTzBloyK0NYlyTRr_nF7JOjE4jSXf6aODs"]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let loadedImage = UIImage(data: data) else {
                throw ImageLoadingError.invalidImageData
            }

            DispatchQueue.main.async {
                self.image = loadedImage
                self.setImageCache(image: loadedImage, key: urlString)
            }

            return loadedImage
        } catch {
            //print("Error loading image: \(error)")
            DispatchQueue.main.async {
                self.image = UIImage(systemName: "person.fill")
            }
            return UIImage(systemName: "person.fill")!
            //throw error
        }
    }

    private func setImageCache(image: UIImage, key: String) {
        imageCache?.setObject(image, forKey: key as NSString)
    }

    private func getImageFromCache(from key: String) -> UIImage? {
        return imageCache?.object(forKey: key as NSString) as? UIImage
    }
}
