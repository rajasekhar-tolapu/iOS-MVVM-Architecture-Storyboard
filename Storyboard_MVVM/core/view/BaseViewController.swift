//
// Created by Dipendra on 09/04/20.
// Copyright (c) 2020 Techlabroid. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController<VIEW_MODEL: BaseViewModel>: UIViewController, OnBackResultDelegate {

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
        bindActivityIndicator()
        bindView()
    }

    func bindActivityIndicator() {
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        loadingView.center = view.center
        loadingView.backgroundColor = AppColors.label
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        loader.color = UIColor.systemBackground
        loader.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        loader.center = CGPoint(x: loadingView.bounds.width / 2, y: loadingView.bounds.height / 2)
        loadingView.addSubview(loader)
        viewModel.loadingEmitter().subscribe { (event) in
            if (event.element ?? false) {
                self.view.isUserInteractionEnabled = false
                loader.startAnimating()
                self.view.addSubview(loadingView)
            } else {
                self.view.isUserInteractionEnabled = true
                loader.stopAnimating()
                loadingView.removeFromSuperview()
            }
        }.disposed(by: viewModel.disposeBag)
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

    func showActivityIndicator(uiView: UIView) {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor.white
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        loadingView.center = uiView.center
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }
}

// Delegate to Send Data Back to ViewController
protocol OnBackResultDelegate {
    func onPopResult(id: Int, arguments: DataBundle)
}
