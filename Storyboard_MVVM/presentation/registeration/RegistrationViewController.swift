//
//  RegistrationViewController.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 11/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class RegistrationViewController: BaseViewController<RegistrationViewModel> {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldRepeatPassword: UITextField!
    @IBOutlet weak var buttonRegister: UIButton!

    override func bindView() {
        // Binding UI Fields to ViewModel data (Two way data binding)
        (textFieldName.rx.text.orEmpty <--> viewModel.name).disposed(by: viewModel.disposeBag)
        (textFieldEmail.rx.text.orEmpty <--> viewModel.email).disposed(by: viewModel.disposeBag)
        (textFieldPassword.rx.text.orEmpty <--> viewModel.password).disposed(by: viewModel.disposeBag)
        // Creating Validation Observable
        let validationObservable = Observable.combineLatest(
                textFieldName.rx.text.orEmpty.asObservable(),
                textFieldEmail.rx.text.orEmpty.asObservable(),
                textFieldPassword.rx.text.orEmpty.asObservable(),
                textFieldRepeatPassword.rx.text.orEmpty.asObservable()) {
            return self.isFormValid(name: $0, email: $1, password: $2, repeatPassword: $3)
        }
        // Binding Button state with form validation
        (validationObservable --> buttonRegister.rx.isEnabled).disposed(by: viewModel.disposeBag)
        // Binding Button state with form validation
        (validationObservable.map {
            return $0 ? 1 : 0.5
        } --> buttonRegister.rx.alpha).disposed(by: viewModel.disposeBag)
        // Binding Button Tap Event
        buttonRegister.rx.tap.bind {
            self.viewModel.doSignUp()
        }.disposed(by: viewModel.disposeBag)
        // Bind Api Result if required by your business case
        viewModel.isRegistrationSuccessful.bind { value in
            if (value) {
                self.pop()
            }
        }.disposed(by: viewModel.disposeBag)
    }

    func isFormValid(name: String, email: String, password: String, repeatPassword: String) -> Bool {
        return (!name.isEmpty && !email.isEmpty && !password.isEmpty && password == repeatPassword)
    }
}
