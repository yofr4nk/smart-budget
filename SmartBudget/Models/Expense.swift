//
//  Expense.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/1/23.
//

import Foundation

struct Expense: Decodable, Identifiable {
    let id: Int
    let description: String
    let amount: Float32
    let date: String
    let category: String
    let cardID: Int
}
