//
//  ANINewsBannerView.swift
//  Khul Ke
//
//  Created by Rajat Lakhina on 02/02/24.
//

import Foundation
import SwiftUI

struct ANINewsBannerView: SwiftUI.View {
    @State private var currentPage = 0
    @State private var timer: Timer?
    @State var bannerData: [TownHallPost]
    @EnvironmentObject var coordinator: TownhallHomeCoordinator

    var body: some SwiftUI.View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(bannerData.indices, id: \.self) { index in
                    CustomBannerView(bannerItem: bannerData[index])
                        .scaledToFill()
                        .frame(maxWidth: UIScreen.screenWidth, maxHeight: .infinity)
                        .clipped()
                        .tag(index)
                        .environmentObject(coordinator)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 200)
            .frame(maxWidth: UIScreen.screenWidth)
            .onAppear {
                startAutoScroll()
            }
            .onDisappear {
                stopAutoScroll()
            }
            
            PageControl(numberOfPages: bannerData.count, currentPage: $currentPage)
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < 0 && currentPage == bannerData.count - 1 {
                        currentPage = 0
                    } else if value.translation.width > 0 && currentPage == 0 {
                        currentPage = bannerData.count - 1
                    }
                }
        )
    }

    private func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            DispatchQueue.main.async {
                withAnimation {
                    let newPage = (self.currentPage + 1) % self.bannerData.count
                    self.currentPage = newPage
                }
            }
        }
    }

    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
}


struct AsyncImageView: SwiftUI.View {
    var imageUrl: URL
    var body: some SwiftUI.View {
        AsyncImage(url: imageUrl) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
            @unknown default:
                fatalError("Unhandled AsyncImage phase")
            }
        }
    }
}

struct CustomHeaderAsyncImage: SwiftUI.View {
    @ObservedObject private var imageViewModel: ImageViewModel

    init(urlString: String?) {
        imageViewModel = ImageViewModel(urlString: urlString)
    }
    
    var body: some SwiftUI.View {
        Group {
            if let imageData = imageViewModel.image {
                Image(uiImage: imageData).resizable().scaledToFill()
                
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
            }
        }
        .task {
            await imageViewModel.loadImage()
        }
    }
}

struct CustomBannerView: SwiftUI.View {
    var bannerItem: TownHallPost
    @EnvironmentObject var coordinator: TownhallHomeCoordinator

    var body: some SwiftUI.View {
        
        ZStack(alignment: .leading) {
            if let urls = bannerItem.urls,
               let other = urls.other,
               let firstElement = other.first  {
                LinkPreviewerImage(imageUrlString: firstElement.completeURL)
                    .frame(width: UIScreen.screenWidth, height: 200)
                    .onTapGesture {
                        coordinator.openLinkInBrowser(urlString: bannerItem.urls?.other?.first?.completeURL)
                    }
            } else {
                Color.clear
                    .frame(width: UIScreen.screenWidth, height: 200)
            }
            
            VStack(alignment: .leading, spacing: 7) {
                CustomEmptyBannerView()
                if let username = bannerItem.username {
                    HStack(content: {
                        CustomHeaderAsyncImage(urlString: "https://useronboarding.khulke.com/user/profile-photo/\(username)/medium/")
                            .frame(width: 30, height: 30)
                            .cornerRadius(15)
                        
                        Text(bannerItem.username ?? "")
                            .foregroundColor(.white)
                            //.font(.WorkSans(.regular, size: 12))
                            .truncationMode(.tail)
                            .lineLimit(1)
                    })
                    .onTapGesture {
                        coordinator.navigateToProfileVC(userName: bannerItem.username)
                    }
                } else {
                    Color.clear
                        .frame(height: 30)
                }
                
                if let descriptionText = bannerItem.text {
                    BannerViewDescription(text: descriptionText, numberOfLines: 2)
                        .onTapGesture {
                            coordinator.openDetails(id: bannerItem.postID)
                        }
                } else {
                    Color.clear
                        .frame(height: 30)
                }
            }
            .padding([.leading, .bottom], 16)
            .frame(width: UIScreen.screenWidth - 20)
            .frame(maxWidth: UIScreen.screenWidth - 20)
        }
    }
}

struct BannerViewDescription: SwiftUI.View {
    @ObservedObject var viewModel: TextHTMLViewModel
    private var numberOfLines: Int
    init(text: String, numberOfLines: Int = 2) {
        self.viewModel = TextHTMLViewModel(text: text)
        self.numberOfLines = numberOfLines
    }
    
    var body: some SwiftUI.View {
        Text(viewModel.title ?? "")
            .foregroundColor(.white)
            //.font(.WorkSans(.semiBold, size: 14))
            .lineLimit(numberOfLines)
            .truncationMode(.tail)
    }
}

struct LinkPreviewerImage: SwiftUI.View {
    
    @ObservedObject var viewmodel: LinkPreviewViewModel
    
    init(imageUrlString: String) {
        self.viewmodel = LinkPreviewViewModel(imageUrlString: imageUrlString)
    }
    
    var body: some SwiftUI.View {
        VStack {
            if let imageURL = viewmodel.imageURL {
                AsyncImageView(imageUrl: imageURL)
            } else {
                //Text("No preview image available.")
                Color.clear
            }
        }
    }
}

struct CustomEmptyBannerView: SwiftUI.View {
    var body: some SwiftUI.View {
        Text("")
        Text("")
        Text("")
        Text("")
        Text("")
    }
}

struct PageControl: SwiftUI.View {
    var numberOfPages: Int
    @Binding var currentPage: Int

    var body: some SwiftUI.View {
        HStack {
            ForEach(0..<numberOfPages) { page in
                Circle()
                    .fill(page == currentPage ? Color.white : Color.gray)
                    .frame(width: 6, height: 6)
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.trailing, 5)
                    .onTapGesture {
                        withAnimation {
                            currentPage = page
                        }
                    }
            }
        }
        .padding(.bottom, 10)
    }
}

//#Preview {
//    ANINewsBannerView()
//}
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
