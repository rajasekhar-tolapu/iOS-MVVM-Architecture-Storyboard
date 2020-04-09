//
//  RegistrationViewModel.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 11/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation
import RxCocoa

class RegistrationViewModel: BaseViewModel {
    let name = BehaviorRelay<String>(value: "Dipendra")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    let isRegistrationSuccessful = BehaviorRelay<Bool>(value: false)

    func doSignUp() {
        showLoading()
        dataHelper.apiHelper
                .doSignUp(signUpRequest: SignUpRequest(name: name.value, email: email.value, password: password.value,
                        profilePicUrl: "https://avatars0.githubusercontent.com/u/17643682?s=460&u=a678073f2835137a50c5c19ca0121d12a9143f5f&v=4"))
                .subscribeOn(scheduler.background())
                .observeOn(scheduler.main()).subscribe(onNext: { output in
                    self.hideLoading()
                    self.isRegistrationSuccessful.accept(true)
                }, onError: { error in
                    self.hideLoading()
                    self.isRegistrationSuccessful.accept(false)
                }).disposed(by: disposeBag)
    }
}
