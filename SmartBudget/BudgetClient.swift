//
//  BudgetClient.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 8/30/23.
//

import Foundation

struct Budget: Decodable, Identifiable {
    let id: Int
    let item: String
}

struct BudgetClient {
    
    static let shared = BudgetClient()
    
    private init() { }
    
    private enum BudgetClientError: Error {
        case invalidResponse
        case decodingError(Error)
    }
    
    func fetchBudget(at url: URL) async throws -> [Budget] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw BudgetClientError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode([Budget].self, from: data)
        } catch {
            throw BudgetClientError.decodingError(error)
        }
    }
}
