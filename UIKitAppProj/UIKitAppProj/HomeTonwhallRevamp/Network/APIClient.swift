//
//  APIClient.swift
//  FoodOrderingDemoApp
//
//  Created by Rajat Lakhina on 16/12/23.
//

import Foundation
import Combine

protocol APIClient {
    associatedtype EndpointType: NetworkProtocol
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
    func multipartRequest<T: Decodable>(_ endpoint: EndpointType, data: Data, fileName: String, mimeType: String) -> AnyPublisher<T, Error>
}

class URLSessionAPIClient<EndpointType: NetworkProtocol>: APIClient {
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        AppLog.apiTraceLog("request url: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        AppLog.apiTraceLog("request parameters: \(endpoint.parameters ?? [:])")
        if let body = endpoint.parameters {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        // set up any other request parameters here
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard response is HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                /*
                if let jsonString = String(data: data, encoding: .utf8) {
                    AppLog.apiDebugLog("JSON Response for jsonString : \(jsonString)")
                    
                    let decoder = JSONDecoder()
                    do {
                        let townHallData = try decoder.decode(T.self, from: data)
                        AppLog.apiDebugLog("decoder response: \(townHallData)")
                    } catch let jsonError as NSError {
                        AppLog.apiErrorLog("\(jsonError)")
                        AppLog.apiErrorLog("JSON decode failed: \(jsonError.localizedDescription)")
                    } catch DecodingError.keyNotFound(let key, let context) {
                        AppLog.apiErrorLog("Could not find key '\(key.stringValue)' in JSON: \(context.debugDescription)")
                    } catch DecodingError.valueNotFound(let type, let context) {
                        AppLog.apiErrorLog("Could not find type \(type) in JSON: \(context.debugDescription)")
                    } catch DecodingError.typeMismatch(let type, let context) {
                        AppLog.apiErrorLog("Type mismatch for type \(type) in JSON: \(context.debugDescription)")
                    } catch DecodingError.dataCorrupted(let context) {
                        AppLog.apiErrorLog("Data found to be corrupted in JSON: \(context.debugDescription)")
                    } catch let error as NSError {
                            AppLog.apiErrorLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                    }
                }
                 */
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func multipartRequest<T: Decodable>(_ endpoint: EndpointType, data: Data, fileName: String, mimeType: String) -> AnyPublisher<T, Error> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        let contentType = "multipart/form-data; boundary=\(boundary)"
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard response is HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
