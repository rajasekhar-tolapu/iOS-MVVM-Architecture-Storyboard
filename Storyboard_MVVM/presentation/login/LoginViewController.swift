//
//  ViewController.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 09/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController<LoginViewModel> {

    @IBAction func onRegisterClicked(_ sender: UIButton) {
        push(viewController: RegistrationViewController.instance().self,
                modalPresentationStyle: .automatic) { () -> DataBundle? in
            return DataBundle()
        }
    }

    @IBAction func onLogin(_ sender: UIButton) {
        push(viewController: DashboardViewController.instance().self,
                modalPresentationStyle: .fullScreen) { () -> DataBundle? in
            return DataBundle()
        }
    }

    @IBAction func onForgetPassworf(_ sender: UIButton) {
        push(viewController: ForgetPasswordViewController.instance().self, modalPresentationStyle: .automatic) { () -> DataBundle? in
            return DataBundle()
        }
    }
    
    override func bindView() {
        viewModel.showLoading()
        executeAfter(milliseconds: 2000) {
            self.viewModel.hideLoading()
        }
    }
}

