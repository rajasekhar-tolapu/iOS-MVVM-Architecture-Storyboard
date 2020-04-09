//
//  BaseTabBarController.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 11/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation
import UIKit

class BaseTabBarController<VIEW_MODEL: BaseViewModel>: UITabBarController, OnBackResultDelegate {

    var viewModel: VIEW_MODEL = VIEW_MODEL.init(dataHelper: DataHelper.shared, scheduler: SchedulerProvider.shared)

    var arguments = DataBundle()
    internal var onBackResultDelegate: OnBackResultDelegate?

    static func instance() -> Self {
        let storyboard = UIStoryboard(name: String(describing: self)
                .replacingOccurrences(of: "ViewController", with: "Screen"), bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }

    func sendResult(resultId: Int, dataBundle: DataBundle) {
        executeAfter(milliseconds: 200) {
            self.onBackResultDelegate?.onPopResult(id: resultId, arguments: dataBundle)
        }
    }

    func onBack() {
        runOnUiThread {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func onPopResult(id: Int, arguments: DataBundle) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    deinit {
        viewModel.onCleared()
    }

    func finish() {
        runOnUiThread {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func bindView() {
        assert(false, "This method must be overriden")
    }

    func getScreenWidth() -> CGFloat {
        return view.frame.width
    }

    func getScreenHeight() -> CGFloat {
        return view.frame.height
    }

    func hideKeyboard() {
        view.endEditing(true)
    }

    func runOnUiThread(execute: @escaping () -> Void) {
        DispatchQueue.main.async(execute: execute)
    }

    func executeAfter(milliseconds: Int, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(milliseconds / 1000), execute: execute)
    }

    func push<T: BaseViewModel>(viewController: BaseViewController<T>, animated: Bool = true,
                                modalPresentationStyle: UIModalPresentationStyle = .automatic,
                                arguments: @escaping () -> DataBundle?) {
        viewController.arguments = arguments() ?? DataBundle()
        viewController.onBackResultDelegate = self
        viewController.modalPresentationStyle = modalPresentationStyle
        self.present(viewController, animated: true, completion: nil)
    }

    func push<T: BaseViewModel>(viewController: BaseTabBarController<T>, animated: Bool = true,
                                modalPresentationStyle: UIModalPresentationStyle = .automatic,
                                arguments: @escaping () -> DataBundle?) {
        viewController.arguments = arguments() ?? DataBundle()
        viewController.onBackResultDelegate = self
        viewController.modalPresentationStyle = modalPresentationStyle
        self.present(viewController, animated: true, completion: nil)
    }

    func pop(animated: Bool = true) {
        self.dismiss(animated: animated, completion: { () in
            self.onBackResultDelegate?.onPopResult(id: 0, arguments: DataBundle())
        })
    }
}
