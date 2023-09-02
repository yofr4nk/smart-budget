//
//  Budget.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/1/23.
//

import Foundation

struct Budget: Decodable, Identifiable {
    let id: Int
    let item: String
}
