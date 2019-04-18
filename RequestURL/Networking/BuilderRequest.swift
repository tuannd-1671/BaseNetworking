//
//  BuilderRequest.swift
//  RequestURL
//
//  Created by ngo.doan.tuan on 4/18/19.
//  Copyright © 2019 ethos. All rights reserved.
//

import Foundation

public class URLRequestBuilder {
    
    var baseURL: URL
    var path: String
    var method: HTTPMethod = .get
    var headers: [String: Any]?
    var parameters: RequestParams?
    
    init(with baseURL: URL, path: String) {
        self.baseURL = baseURL
        self.path = path
    }
    
    @discardableResult
    func set(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult
    func set(path: String) -> Self {
        self.path = path
        return self
    }
    
    @discardableResult
    func set(headers: [String: Any]?) -> Self {
        self.headers = headers
        return self
    }
    
    @discardableResult
    func set(parameters: RequestParams?) -> Self {
        self.parameters = parameters
        return self
    }
    
    func build() throws -> URLRequest {
        do {
            var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path),
                                        cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                        timeoutInterval: 100)
            urlRequest.httpMethod = method.rawValue
            
            headers?.forEach {
                urlRequest.addValue($0.value as! String, forHTTPHeaderField: $0.key)
            }
            
            if let params = parameters {
                urlRequest = try buildRequestParams(urlRequest, params: params)
            }
            
            return urlRequest
        } catch {
            throw APIError.requestBuilderFailed!
        }
    }
    
    fileprivate func buildRequestParams(_ urlRequest: URLRequest, params: RequestParams) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest = try params.encoder.encode(urlRequest,
                                               with: params.parameters)
        return urlRequest
    }
}
