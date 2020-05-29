//
//  ForgetPasswordViewController.swift
//  Storyboard_MVVM
//
//  Created by Rajasekhar on 30/05/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ForgetPasswordViewController: BaseViewController<ForgetPasswordViewModel> {

    @IBOutlet weak var existingPasswordTF: UITextField!
    
    @IBOutlet weak var newPasswordTF: UITextField!
    
    @IBOutlet weak var changePasswordBtn: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func bindView() {
        
        changePasswordBtn.rx.tap.bind {
            self.pop()
        }.disposed(by: disposeBag)
            
    }
 
}
