//
// Created by Dipendra on 09/04/20.
// Copyright (c) 2020 Techlabroid. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    private let loading = BehaviorRelay<Bool>(value: false)
    internal let compositeDisposable: CompositeDisposable = CompositeDisposable()
    let disposeBag = DisposeBag()
    internal var dataHelper: DataHelper!
    internal var scheduler: SchedulerProvider!

    required init(dataHelper: DataHelper!, scheduler: SchedulerProvider!) {
        self.dataHelper = dataHelper
        self.scheduler = scheduler
    }

    func loadingEmitter() -> Observable<Bool> {
        return loading.asObservable()
    }

    func showLoading() {
        loading.accept(true)
    }

    func hideLoading() {
        loading.accept(false)
    }

    func isLoading() -> Bool {
        return loading.value
    }

    func onCleared() {
        compositeDisposable.dispose()
    }
}
