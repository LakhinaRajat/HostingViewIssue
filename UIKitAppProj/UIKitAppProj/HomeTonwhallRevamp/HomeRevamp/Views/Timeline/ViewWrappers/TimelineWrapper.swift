//
//  TimelineWrapper.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 30/01/24.
//

import UIKit
import SwiftUI

struct TimelineUIKitWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    let coordinator: TownhallHomeCoordinator
    
    func makeUIViewController(context: Context) -> UIViewController {
        let uiKitViewController = UIViewController()
        coordinator.setTownHallParentViewController(uiKitViewController)
        return uiKitViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update the view controller if needed
    }
}

