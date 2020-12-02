//
//  AbstractViewModel.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 18.11.2020.
//

import Foundation

protocol AbstractViewModel {
    associatedtype Input
    associatedtype Output
    
    func bind(_ input: Input) -> Output
}
