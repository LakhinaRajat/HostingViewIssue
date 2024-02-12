//
//  ANINewsItems.swift
//  Khul Ke
//
//  Created by Rajat Lakhina on 02/02/24.
//

import SwiftUI

struct ANINewsListView: SwiftUI.View {
    @EnvironmentObject var coordinator: TownhallHomeCoordinator
    @ObservedObject var viewModel: ANIViewModel
    
    var body: some SwiftUI.View {
        LazyVStack(alignment: .leading, spacing: 16) {
            ForEach($viewModel.aniListData, id: \.id) { $post in
                HStack {
                    if let urls = post.urls,
                       let other = urls.other,
                       let firstElement = other.first {
                        LinkPreviewerImage(imageUrlString: firstElement.completeURL)
                            .frame(width: 120, height: 120)
                            .cornerRadius(10.0)
                            .onTapGesture {
                                coordinator.openLinkInBrowser(urlString: post.urls?.other?.first?.completeURL)
                            }
                    } else {
                        Color.clear
                            .frame(width: 120, height: 120)
                            .cornerRadius(10.0)
                    }
                    VStack(alignment: .leading, content: {
                        HStack(content: {
                            Group(content: {
                                CustomHeaderAsyncImage(urlString: "https://useronboarding.khulke.com/user/profile-photo/\(post.username ?? "")/medium/")
                                    .frame(width: 26, height: 26)
                                    .cornerRadius(13.0)
                                
                                Text("@\(post.username ?? "")")
                                    //.font(.WorkSans(.regular, size: 12))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            })
                            .onTapGesture {
                                coordinator.navigateToProfileVC(userName: post.username)
                            }
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 4, height: 4)
                    
                            Text(post.formattedPostCreatedAt ?? "")
                                //.font(.WorkSans(.regular, size: 10))
                                .foregroundColor(Color.gray)
                                .lineLimit(1)
                                .truncationMode(.tail)
                    
                            Spacer()
                            
                            Menu {
                                Button(action: {
                                    coordinator.shareAniPost(id: post.postID ?? "")
                                }, label: {
                                    HStack {
                                        Image(systemName: "square.and.arrow.up.fill")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(Color.white)
                                            .frame(width: 13, height: 13)
                                        Text("share")
                                            //.font(.WorkSans(.regular, size: 14))
                                    }
                                })
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: 30)
                        })
                        BannerViewDescription(text: (post.text ?? ""), numberOfLines: 3)
                            .onTapGesture {
                                coordinator.openDetails(id: post.postID)
                            }
                        
                        HStack(content: {
                            HStack(content: {
                                Button(action: {
                                    coordinator.openCommentView(post: post)
                                }, label: {
                                    Image(systemName: (post.commentSelf ?? 0 == 1) ? "message.fill" : "message")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                })
                                Text("\(post.comment ?? 0)")
                                    //.font(.WorkSans(.regular, size: 14))
                            })
                            .padding(.trailing, 20)
                            
                            HStack(content: {
                                Button(action: {
//                                    guard GlobalVariables.sharedManager.isRegisteredUser else {
//                                        coordinator.showLoginPop()
//                                        return
//                                    }
                                    Task {
                                        await viewModel.performLikeDislikeAction(with: post)
                                    }
                                }, label: {
                                    Image(systemName: (post.likeSelf ?? 0 == 1) ? "hand.thumbsup" :  "hand.thumbsup.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                })
                                Text("\(post.like ?? 0)")
                                    //.font(.WorkSans(.regular, size: 14))
                            })
                        })
                        
                    })
                }
                .padding(.vertical, 5)
                .frame(height: 130)
                .id(post.id)
                .accessibilityIdentifier("news_post_\(post.id)")
                .task {
                    if post.postID == viewModel.aniNewsData?.data?.oldPost?.last?.postID {
                        await viewModel.loadMoreData()
                    }
                }
            }
        }
    }
}
