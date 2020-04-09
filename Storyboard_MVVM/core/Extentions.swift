//
//  Extentions.swift
//  Storyboard_MVVM
//
//  Created by Dipendra on 29/04/20.
//  Copyright © 2020 Techlabroid. All rights reserved.
//

import RxSwift
import RxCocoa

// Birectional binding Operator
infix operator <-->
// OneDirectional binding Operator
infix operator -->

// Updating Property & Variable
func <--><T: Comparable>(property: ControlProperty<T>, variable: BehaviorRelay<T>) -> Disposable {
    let variableToProperty = variable.asObservable()
            .distinctUntilChanged()
            .bind(to: property)
    let propertyToVariable = property
            .distinctUntilChanged()
            .bind(to: variable)
    return Disposables.create(variableToProperty, propertyToVariable)
}

// Updating Variable & Variable
func <--><T: Equatable>(left: BehaviorRelay<T>, right: BehaviorRelay<T>) -> Disposable {
    let leftToRight = left.asObservable()
            .distinctUntilChanged()
            .bind(to: right)
    let rightToLeft = right.asObservable()
            .distinctUntilChanged()
            .bind(to: left)
    return Disposables.create(leftToRight, rightToLeft)
}

// Updating Property & Property
func <--><T: Equatable>(left: ControlProperty<T>, right: ControlProperty<T>) -> Disposable {
    let variableToProperty = right.asObservable()
            .distinctUntilChanged()
            .bind(to: left)
    let propertyToVariable = left
            .distinctUntilChanged()
            .bind(to: right)
    return Disposables.create(variableToProperty, propertyToVariable)
}

// Updating Variable & Variable
func <--><T: Equatable>(variable: BehaviorRelay<T>, property: ControlProperty<T>) -> Disposable {
    let leftToRight = variable.asObservable()
            .distinctUntilChanged()
            .bind(to: property)
    let rightToLeft = property.asObservable()
            .distinctUntilChanged()
            .bind(to: variable)
    return Disposables.create(leftToRight, rightToLeft)
}

// Updating Property to variable
func --><T: Equatable>(property: ControlProperty<T>, variable: BehaviorRelay<T>) -> Disposable {
    return property
            .distinctUntilChanged()
            .bind(to: variable)
}

// Updating variable to variable
func --><T: Equatable>(left: BehaviorRelay<T>, right: BehaviorRelay<T>) -> Disposable {
    return left.asObservable()
            .distinctUntilChanged()
            .bind(to: right)
}

// Updating variable to property
func --><T: Equatable>(variable: BehaviorRelay<T>, property: ControlProperty<T>) -> Disposable {
    return variable
            .distinctUntilChanged()
            .bind(to: property)
}

// Updating Property to property
func --><T: Equatable>(left: ControlProperty<T>, right: ControlProperty<T>) -> Disposable {
    return left.asObservable()
            .distinctUntilChanged()
            .bind(to: right)
}

// Updating Property to property
func --><T: Equatable>(left: ControlProperty<T>, right: Binder<T>) -> Disposable {
    return left.asObservable()
            .distinctUntilChanged()
            .bind(to: right)
}

// Updating Property to property
func --><T: Equatable>(left: BehaviorRelay<T>, right: Binder<T>) -> Disposable {
    return left.asObservable()
            .distinctUntilChanged()
            .bind(to: right)
}

// Updating Property to property
func --><T: Equatable>(left: Observable<T>, right: Binder<T>) -> Disposable {
    return left
            .distinctUntilChanged()
            .bind(to: right)
}
