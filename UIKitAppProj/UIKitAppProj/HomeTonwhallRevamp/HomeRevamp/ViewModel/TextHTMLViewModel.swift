//
//  TextHTMLViewModel.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 06/02/24.
//

import Foundation

@MainActor
class TextHTMLViewModel: ObservableObject {
    @Published var title: String?
    
    init(text: String) {
        self.htmlToString(text: text)
    }
    
    @MainActor
    func htmlToString(text: String) {
        //await MainActor.run(body: { [weak self] in
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            do {
                if let strippedString = try text.strippingHTML() {
                    self.title = strippedString
                }
                
            } catch {
                self.title = ""
                print("Error converting HTML to string: \(error)")
                // Handle the error appropriately, e.g., show an alert or log it.
            }
        }
            
        //})
    }
}
