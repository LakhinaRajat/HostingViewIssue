//
//  LinkPreviewViewModel.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 06/02/24.
//

import Foundation
import SwiftSoup

final class LinkPreviewViewModel: ObservableObject {
    @Published var imageURL: URL?
    
    init(imageUrlString: String) {
        loadImageData(string: imageUrlString)
    }
    
    func loadImageData(string: String) {
        guard let url = URL(string: string) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.5414.117 Mobile Safari/537.36", forHTTPHeaderField: "User-Agent")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                    case 200:
                        if let data = data, let html = String(data: data, encoding: .utf8) {
                            do {
                                let doc = try SwiftSoup.parse(html)
                                if let metaTag = try doc.select("meta[property=og:image]").first() {
                                    let imageUrl = try metaTag.attr("content")
                                    if let imageURL = URL(string: imageUrl) {
                                        DispatchQueue.main.async {
                                            self.imageURL = imageURL
                                        }
                                    }
                                }
                            } catch {
                                AppLog.apiFaultLog("Error parsing HTML: \(error)")
                            }
                        }
                    case 403:
                        AppLog.apiFaultLog("Forbidden: Access Denied")
                        
                    default:
                        AppLog.apiFaultLog("Unhandled HTTP status code: \(httpResponse.statusCode)")
                }
            } else if let error = error {
                AppLog.apiFaultLog("Error loading HTML: \(error)")
            }
        }
        
        task.resume()
    }

}
