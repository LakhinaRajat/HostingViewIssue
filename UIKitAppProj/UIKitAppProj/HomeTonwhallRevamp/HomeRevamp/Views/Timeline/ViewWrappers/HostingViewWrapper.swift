//
//  HostingViewWrapper.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 06/02/24.
//

import Foundation
import SwiftUI

struct HostingViewWrapper<Content: SwiftUI.View>: SwiftUI.View {
    let rootView: Content
    let coordinator: TownhallHomeCoordinator

    init(content: Content, coordinator: TownhallHomeCoordinator) {
        self.rootView = content
        self.coordinator = coordinator
    }

    var body: some SwiftUI.View {
        rootView
            .environmentObject(coordinator)

    }
}
