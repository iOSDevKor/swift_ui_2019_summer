//
//  Model.swift
//  DrawLotsSample
//
//  Copyright © 2019 keyWindow. All rights reserved.
//

import Foundation
import Combine

class Model : ObservableObject {
    @Published var numbers: [Int] = []
    
    func pick() {
        let range = 1...150
        var random: Int = Int.random(in: range)
        while numbers.contains(random) {
            random = Int.random(in: range)
        }
        numbers.insert(random, at: 0)
    }
    
    func reset() {
        numbers.removeAll()
    }
}
