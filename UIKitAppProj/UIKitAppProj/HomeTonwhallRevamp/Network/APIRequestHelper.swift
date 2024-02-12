//
//  APIRequest.swift
//  FoodOrderingDemoApp
//
//  Created by Rajat Lakhina on 16/12/23.
//

import Foundation

protocol NetworkProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethods { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case invalidData
}

extension NetworkProtocol {
    var baseURL: URL {
        return URL(string: "https://node.khulke.com/")!
    }
}

