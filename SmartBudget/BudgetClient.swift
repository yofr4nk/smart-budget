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

struct Card: Decodable, Identifiable {
    let id: Int
    let name: String
}

struct BudgetClient {
    
    static let shared = BudgetClient()
    
    private init() { }
    
    private enum BudgetClientError: Error {
        case invalidResponse
        case decodingError(Error)
    }
    
    func getResource(at url: URL) async throws -> Data {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw BudgetClientError.invalidResponse
        }
        
        return data
    }
    
    func fetchBudget(at url: URL) async throws -> [Budget] {
        
        let data = try await getResource(at: url)
        
        do {
            return try JSONDecoder().decode([Budget].self, from: data)
        } catch {
            throw BudgetClientError.decodingError(error)
        }
    }
    
    func fetchEntityCards(at url: URL) async throws -> [Card] {
        
        let data = try await getResource(at: url)
        
        do {
            return try JSONDecoder().decode([Card].self, from: data)
        } catch {
            print("fetchEntityCards error: ", error)
            throw BudgetClientError.decodingError(error)
        }
    }
}
