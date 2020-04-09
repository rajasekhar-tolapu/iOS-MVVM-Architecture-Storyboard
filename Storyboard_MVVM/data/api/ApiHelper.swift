//
//  ApiHelper.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 09/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation
import RxSwift

class ApiPath {
    static let signUpPath = "v1/signup/basic"
}

protocol ApiHelper {
    func doSignUp(signUpRequest: SignUpRequest) -> Observable<SignUpResponse>
}

class ApiHelperImpl: ApiHelper {

    let apiHeaders = ApiHeaders()
    let apiClient = AppHttpClient("https://api.techlabroid.com", ConcurrentDispatchQueueScheduler(
            qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1)))
    static var shared: ApiHelper = ApiHelperImpl()

    func doSignUp(signUpRequest: SignUpRequest) -> Observable<SignUpResponse> {
        return apiClient.post(ApiPath.signUpPath, apiHeaders.publicApiHeaders(), signUpRequest)
    }
}
