//
//  APIClient.swift
//  RequestURL
//
//  Created by ngo.doan.tuan on 4/18/19.
//  Copyright © 2019 ethos. All rights reserved.
//

import Foundation

public class APIClient {
    
   static func buildURLRequest<T: APIRequest>(for request: T) throws -> URLRequest {
        return try URLRequestBuilder(with: request.baseURL, path: request.path)
            .set(method: request.method)
            .set(headers: request.headers)
            .set(parameters: request.parameters)
            .build()
    }
}
