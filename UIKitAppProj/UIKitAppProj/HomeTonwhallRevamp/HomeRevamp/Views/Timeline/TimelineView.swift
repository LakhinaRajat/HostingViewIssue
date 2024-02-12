//
//  TimelineView.swift
//  Khul Ke
//
//  Created by Rajat Lakhina on 02/02/24.
//

import Foundation
import SwiftUI

struct TimelineView: SwiftUI.View {
    @EnvironmentObject var coordinator: TownhallHomeCoordinator
    
    var body: some SwiftUI.View {
        // Your timeline view content goes here
        TimelineUIKitWrapper(coordinator: coordinator)
        .ignoresSafeArea()
        .onAppear(perform: {
            coordinator.showNavigationBar()
        })
    }
}
