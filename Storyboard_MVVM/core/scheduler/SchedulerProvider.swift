//
//  SchedulerProvider.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 12/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import Foundation
import RxSwift

class SchedulerProvider {
    static var shared = SchedulerProvider()
    private var ui = MainScheduler.instance
    private var concurrent = ConcurrentDispatchQueueScheduler(
            qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))

    func main() -> MainScheduler {
        return ui
    }

    func background() -> ConcurrentDispatchQueueScheduler {
        return concurrent
    }
}
