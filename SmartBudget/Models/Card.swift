//
//  Card.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/1/23.
//

import Foundation

struct Card: Decodable, Identifiable {
    let id: Int
    let name: String
    let owner: String
    let type: String
}

