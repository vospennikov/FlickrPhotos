//
//  NetworkService.swift
//  FlickrPhotos
//
//  Created by Mikhail Vospennikov on 30/05/2018.
//  Copyright © 2018 Mikhail Vospennikov. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

enum Result<T> {
    case success(T)
    case error(AppError)
}

enum HttpMethod<T> {
    case get
    case post(T)
    
    var method: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
    
    func map<U>(f: (T) throws -> U) rethrows -> HttpMethod<U> {
        switch self {
        case .get:
            return .get
        case .post(let data):
            return .post(try f(data))
        }
    }
}

struct Resource<T> {
    var url: URL
    var method: HttpMethod<Data>
    var parse: (Data) -> T?
}

extension Resource {
    init(url: URL, method: HttpMethod<Any> = .get, parce: @escaping (Data) -> T?) throws {
        self.url = url
        self.parse = parce
        self.method = try method.map { try JSONSerialization.data(withJSONObject: $0, options: []) }
    }
}

extension URLRequest {
    init<T>(resource: Resource<T>) {
        self.init(url: resource.url)
        httpMethod = resource.method.method
        if case let .post(data) = resource.method {
            httpBody = data
        }
    }
}

extension URL {
    func appendingQueryParameters(_ parameters: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        var items = urlComponents.queryItems ?? []
        items += parameters.map({ URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = items
        return urlComponents.url
    }
}

protocol NetworkService {
    func load<T>(_ resource: Resource<T>, completion: @escaping (T?) -> Void) -> URLSessionDataTask
}

extension NetworkService {
    func load<T>(_ resource: Resource<T>, completion: @escaping (T?) -> Void) -> URLSessionDataTask {
        let request = URLRequest(resource: resource)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async { completion(data.flatMap(resource.parse)) }
        }
        dataTask.resume()
        return dataTask
    }
}
