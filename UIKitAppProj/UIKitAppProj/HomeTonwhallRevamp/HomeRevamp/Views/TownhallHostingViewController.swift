//
//  HostingViewController.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 30/01/24.
//

import Foundation
import SwiftUI
import UIKit

class TownhallHostingViewController<Content: SwiftUI.View>: MasterVC {
    private var hostingController: UIHostingController<AnyView>?

    init(@ViewBuilder rootView: @escaping () -> Content) {
        super.init(nibName: nil, bundle: nil)

        let coordinator = TownhallHomeCoordinator(hostingViewController: self)
        
        // Use rootView directly, it's already a SwiftUI View
        let swiftUIView = HostingViewWrapper(content: rootView(), coordinator: coordinator)
        
        hostingController = UIHostingController(rootView: SwiftUI.AnyView(swiftUIView))

        if let hostingController = hostingController {
            addChild(hostingController)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hostingController.view)
            
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            view.bringSubviewToFront(hostingController.view)
            hostingController.didMove(toParent: self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.setupCustomNavigationBar()
        self.navigationController?.navigationBar.isHidden = false
    }
}

