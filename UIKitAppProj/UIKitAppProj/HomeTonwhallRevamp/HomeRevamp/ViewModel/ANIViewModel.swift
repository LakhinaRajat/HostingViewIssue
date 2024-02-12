//
//  ANIViewModel.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 05/02/24.
//

import Foundation
import Combine

final class ANIViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let aniServiceManager: ANIServiceProtocol
    
    var aniNewsData: TownHallData?
    @Published private (set) var aniBannerData: [TownHallPost] = []
    @Published var aniListData: [TownHallPost] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String = ""
    @Published var loadMore: Bool = false
    
    init(aniService: ANIServiceProtocol) {
        self.aniServiceManager = aniService
    }
    
    @MainActor
    func fetchAniData() async {
        var skip = 0
        var prePageId = ""
        
        if let newsDataModel = aniNewsData, let newData = newsDataModel.data?.oldPost {
            skip = newData.count
            prePageId = newData.first?.postID ?? ""
        }
        
        aniServiceManager.fetchANIData(with: skip, prePageId: prePageId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break // API request completed successfully
                    case .failure(let error):
                        self.isLoading = false
                        self.loadMore = false
                        self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                    self.handleResponse(response: response, skip: skip)
                    self.isLoading = false
                    self.loadMore = false
            }).store(in: &cancellables)
    }
    
    func handleResponse(response: TownHallData, skip: Int) {
        switch response.code {
            case 200 :
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if skip == 0 {
                        self.aniNewsData = response
                        self.aniBannerData = response.data?.oldPost?.prefix(10).map { $0 } ?? []
                        self.aniListData = response.data?.oldPost?.dropFirst(10).map { $0 } ?? []
                    } else {
                        if let existingOldPost = self.aniNewsData?.data?.oldPost, !existingOldPost.isEmpty {
                            if let responseOldData = response.data?.oldPost, !responseOldData.isEmpty {
                                if !responseOldData.allSatisfy({ existingOldPost.contains($0) }) {
                                    self.aniNewsData?.data?.oldPost?.append(contentsOf: ( responseOldData))
                                    self.aniListData.append(contentsOf: (response.data?.oldPost ?? []))
                                }
                            }
                        }
                    }
                }
            case 503 :
                errorMessage = "AlertMesage.NoInterNetMsg"
            case 404 :
                
                return
            case -1001 :
                errorMessage = "AppString.timeOutString"
                
                return
            default:
                errorMessage = "AppString.pleaseTryAgain"
        }
    }
    
    @MainActor
    func performLikeDislikeAction(with post: TownHallPost) async {
        
        guard let id = post.postID else { return }
        let action: String = post.likeSelf == 1 ? ActionsType.dislike.rawValue : ActionsType.like.rawValue
        
        aniServiceManager.likeDislikePost(action: action, postId: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        break // API request completed successfully
                    case .failure(let error):
                        AppLog.viewCycleErrorLog(error)
                        break
                }
            }, receiveValue: { [weak self] response in
                guard let self else { return }
                
                var updatedPost = post
                
                updatedPost.likeSelf = response.data.selfLikes
                updatedPost.like = response.data.likes
                updatedPost.dislike = response.data.dislikes
                updatedPost.dislikeSelf = response.data.selfDislikes
                if let index = self.aniNewsData?.data?.oldPost?.firstIndex(where: { $0.postID == id }) {
                    self.aniNewsData?.data?.oldPost?[index] = updatedPost
                }
                
                if let index = self.aniListData.firstIndex(where: { $0.postID == id }) {
                    self.aniListData[index].likeSelf = response.data.selfLikes
                    self.aniListData[index].like = response.data.likes
                    self.aniListData[index].dislike = response.data.dislikes
                    self.aniListData[index].dislikeSelf = response.data.selfDislikes
                }
            }).store(in: &cancellables)
    }
    
    @MainActor
    func loadMoreData() async {
        guard !self.loadMore else { return }
        self.loadMore = true
        Task {
            await self.fetchAniData()
        }
    }
    
    func reset() {
        self.errorMessage = ""
        self.isLoading = true
        self.aniBannerData = []
        self.aniListData = []
        self.aniNewsData = nil
    }
    
    @MainActor
    func refreshData() async {
        reset()
        Task {
            await self.fetchAniData()
        }
    }
}
