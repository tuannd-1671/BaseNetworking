//
//  Service.swift
//  RequestURL
//
//  Created by ngo.doan.tuan on 4/18/19.
//  Copyright © 2019 ethos. All rights reserved.
//

import Foundation

typealias RequestCallback = (Data?, URLResponse?, Error?) -> Void

public class NotiService {
    static func getNoti(completion: @escaping  RequestCallback) {
        let urlRequestBuilder:URLRequestBuilder = URLRequestBuilder.init(with: URL(string:"https://api.myjson.com/")!, path: "bins/ki5o0")
        urlRequestBuilder.set(method: .get)
        //urlRequestBuilder.set(headers: ["header1": "aaaa", "header2": "bbbb"])
        //urlRequestBuilder.set(parameters: RequestParams.body(["username": "Banh Thi Linh", "isRegistered": true]))
        let urlRequest = try! urlRequestBuilder.build()

        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            completion(data, response, error)
        })
        task.resume()
    }
}
