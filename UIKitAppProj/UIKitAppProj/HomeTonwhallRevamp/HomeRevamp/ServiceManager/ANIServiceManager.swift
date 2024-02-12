//
//  ANIServiceManager.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 05/02/24.
//

import Foundation
import Combine

protocol ANIServiceProtocol {
    func fetchANIData(with skipPosts: Int, prePageId: String) -> AnyPublisher<TownHallData, Error>
    func likeDislikePost(action: String, postId: String) -> AnyPublisher<PostLikeDislikeModel, Error>
}

class ANIServiceManager: ANIServiceProtocol {
    
    let apiClient = URLSessionAPIClient<ANIServiceEndPoint>()
    
    func fetchANIData(with skipPosts: Int, prePageId: String) -> AnyPublisher<TownHallData, Error> {
        apiClient.request(.newsFeed(skip: skipPosts, prePageId: prePageId))
    }
    
    func likeDislikePost(action: String, postId: String) -> AnyPublisher<PostLikeDislikeModel, Error> {
        apiClient.request(.likeDislike(action: action, postId: postId))
    }
}
