//
//  AppHttpClient.swift
//  Clean MVVM Architecture
//
//  Created by Dipendra on 09/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class AppHttpClient {
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler

    init(_ endPoint: String, _ scheduler: ConcurrentDispatchQueueScheduler) {
        self.endPoint = endPoint
        self.scheduler = scheduler
    }

    // GET Request with Simple Url
    func get<RESPONSE: Codable>(_ path: String, _ headers: HTTPHeaders? = nil) -> Observable<RESPONSE> {
        return RxAlamofire.request(.get, "\(endPoint)/\(path)", headers: headers).responseOrError()
    }

    // GET Request with quary parameters
    func get<RESPONSE: Codable>(_ path: String, _ headers: HTTPHeaders? = nil,
                                _ parameters: [String: Any]) -> Observable<RESPONSE> {
        return RxAlamofire.request(.get, "\(endPoint)/\(path)", parameters: parameters, headers: headers)
                .responseOrError()
    }

    // POST request with Json Request
    func post<REQUEST: Codable, RESPONSE: Codable>(_ path: String, _ headers: HTTPHeaders? = nil,
                                                   _ parameters: REQUEST) -> Observable<RESPONSE> {
        let parameters1 = try! JSONEncoder().encode(parameters)
        return RxAlamofire.request(.post, "\(endPoint)/\(path)", parameters: try? (
                JSONSerialization.jsonObject(with: parameters1, options: .allowFragments) as! [String: Any]),
                encoding: JSONEncoding.default, headers: headers).responseOrError()
    }

    // PUT request with Json Request
    func put<REQUEST: Codable, RESPONSE: Codable>(_ path: String, _ headers: HTTPHeaders? = nil,
                                                  _ parameters: REQUEST) -> Observable<RESPONSE> {
        let parameters1 = try! JSONEncoder().encode(parameters)
        return RxAlamofire.request(.put, "\(endPoint)/\(path)", parameters: try? (
                JSONSerialization.jsonObject(with: parameters1, options: .allowFragments) as! [String: Any]),
                encoding: JSONEncoding.default, headers: headers).responseOrError()
    }
}

extension Observable where Element == DataRequest {
    func responseOrError<RESPONSE: Codable>() -> Observable<RESPONSE> {
        return self.responseData().map { it -> RESPONSE in
            if (200...300 ~= it.0.statusCode) {
                return try JSONDecoder().decode(RESPONSE.self, from: it.1)
            } else {
                throw try JSONDecoder().decode(ApiError.self, from: it.1)
            }
        }.catchError { error in
            return Observable<RESPONSE>.error(error)
        }
    }
}

struct ApiError: Codable, Error {
    let statusCode, message: String

    private enum CodingKeys: String, CodingKey {
        case statusCode, message
    }
}
