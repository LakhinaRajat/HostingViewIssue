//
//  ANINews.swift
//  Khul Ke
//
//  Created by Rajat Lakhina on 02/02/24.
//

import Foundation
import SwiftUI

struct ANINewsView: SwiftUI.View {
    @EnvironmentObject var coordinator: TownhallHomeCoordinator
    @StateObject var viewModel: ANIViewModel = ANIViewModel(aniService: ANIServiceManager())
    
    var body: some SwiftUI.View {
        ScrollView(.vertical, showsIndicators: false) {
            if viewModel.isLoading {
                EmptyView()
            } else {
                if viewModel.errorMessage.isEmpty {
                    VStack {
                        if !viewModel.aniBannerData.isEmpty {
                            CustomSectionHeader(title: "breaking news")
                            ANINewsBannerView(bannerData: viewModel.aniBannerData)
                                .frame(height: 220)
                                .environmentObject(coordinator)
                        } else {
                            Color.clear
                                .frame(height: 220)
                        }
                        
                        if !viewModel.aniListData.isEmpty {
                            CustomSectionHeader(title: "for You")
                            ANINewsListView(viewModel: viewModel)
                                .padding(.horizontal, 7)
                                .environmentObject(coordinator)
                        } else {
                            Color.clear
                        }
                    }
                } else {
                    EmptyView()
                }
            }
            
            if viewModel.loadMore {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 10)
            }
        }
        .refreshable {
            await viewModel.refreshData()
        }
        .task {
            coordinator.showNavigationBar()
            if !coordinator.refreshNewTab {
                await viewModel.fetchAniData()
            }
        }
        .task(id: coordinator.refreshNewTab, {
            if coordinator.refreshNewTab {
                await viewModel.refreshData()
            }
        })
        .task(id: viewModel.isLoading, {
            if !viewModel.isLoading {
                self.coordinator.hideLoader()
                self.coordinator.refreshNewTab = viewModel.isLoading
            } else {
                self.coordinator.showLoader()
            }
        })
        .task(id: viewModel.errorMessage, {
            if !viewModel.errorMessage.isEmpty {
                coordinator.showToast(message: viewModel.errorMessage)
            }
        })
    }
}

struct CustomSectionHeader: SwiftUI.View {
    let title: String

    var body: some SwiftUI.View {
        HStack {
            Text(title)
                //.font(.WorkSans(.regular, size: 16))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .padding(.leading, 15)
        }
    }
}

//#Preview {
//    ANINewsView()
//}
