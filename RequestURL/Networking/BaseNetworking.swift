//
//  BaseNetworking.swift
//  RequestURL
//
//  Created by ngo.doan.tuan on 4/18/19.
//  Copyright © 2019 ethos. All rights reserved.
//
import Foundation

//This defines the type of HTTP method used to perform the request
public enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

//This defines the parameters to pass along with the request
public enum RequestParams {
    case body(_: [String: Any]?)
    case url(_: [String: Any]?)
}

//This is the `APIRequest` protocol you may implement other classes can conform
public protocol APIRequest {
    associatedtype Resource: Decodable
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var headers: [String: Any]? { get }
}

public struct APIError {
   static var parameterEncoderFailed: Error {
        get {
            return NSError(domain: "Paramer Encoder Failed", code: 10001, userInfo: nil)
        }
    }
   static var requestBuilderFailed: Error? {
        get {
            return NSError(domain: "Request Builder Failed", code: 10002, userInfo: nil)
        }
    }
}

typealias Parameters = [String: Any]
protocol RequestParameterEncoder {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest
}
extension RequestParams {
    var encoder: RequestParameterEncoder {
        switch self {
        case .body(_):
            return JSONParameterEncoder()
        case .url(_):
            return URLParameterEncoder()
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .body(let params), .url(let params):
            return params
        }
    }
}


struct JSONParameterEncoder: RequestParameterEncoder {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        do {
            guard let params = parameters else { return urlRequest }
            var urlRequest = urlRequest
            let jsonAsData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            return urlRequest
        } catch {
            throw APIError.parameterEncoderFailed
        }
    }
}

struct URLParameterEncoder: RequestParameterEncoder {
    func encode(_ urlRequest: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        do {
            guard let params = parameters else { return urlRequest }
            var urlRequest = urlRequest
            let jsonAsData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            return urlRequest
        } catch {
            throw APIError.parameterEncoderFailed
        }
    }
}

