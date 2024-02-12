//
//  TownhallHome.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 30/01/24.
//

import SwiftUI

struct TownhallHome: SwiftUI.View {
    @EnvironmentObject var coordinator: TownhallHomeCoordinator
    
    var body: some SwiftUI.View {
        //NavigationView {
        VStack(alignment: .leading) {
            TownhallTabSelectionViewContainer(selectedTab: $coordinator.selectedTab, action: refreshTabs)
                .padding(.top, 10)
            
            switch coordinator.selectedTab {
                case .timeline:
                    TimelineView()
                        .environmentObject(coordinator)
                case .aniNews:
                    ANINewsView()
                        .environmentObject(coordinator)
            }
        }
        .onAppear(perform: {
            //coordinator.selectedTab = !GlobalVariables.sharedManager.isRegisteredUser ? .aniNews : .timeline
            coordinator.showNavigationBar()
        })
        .onChange(of: coordinator.selectedTab) { newTab in
            refreshTabs()
        }
        
    }
    
    func refreshTabs() {
        switch coordinator.selectedTab {
            case .aniNews:
                coordinator.refreshNewTab = true
            case .timeline:
                coordinator.refreshTimeLineData()
        }
    }
}

struct TownhallTabSelectionViewContainer: SwiftUI.View {
    @Binding var selectedTab: TownhallTab
    var action: () -> Void
    var body: some SwiftUI.View {
        ScrollView(.horizontal, showsIndicators: false) {
            TownhallTabSelectionView(tabs: TownhallTab.allCases, selectedTab: $selectedTab, action: action)
        }
        .padding([.leading, .trailing])
    }
}

struct TownhallTabSelectionView: SwiftUI.View {
    let tabs: [TownhallTab]
    @Binding var selectedTab: TownhallTab
    let action: () -> Void

    var body: some SwiftUI.View {
        HStack(spacing: 20) {
            ForEach(tabs, id: \.self) { tab in
                TabButton(title: tab.title, isSelected: selectedTab == tab) {
                    selectedTab = tab
                    action()
                }
            }
        }
    }
}

struct TabButton: SwiftUI.View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some SwiftUI.View {
        Button(action: action) {
            Text(title)
                //.font(.WorkSans(.regular, size: 12))
                .foregroundColor(isSelected ? .black : .white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
        }
        .background(isSelected ? Color.white : Color.clear)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.white, lineWidth: 1)
        )
    }
}


//#Preview {
//    TownhallHome()
//}
