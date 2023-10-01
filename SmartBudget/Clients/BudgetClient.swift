//
//  BudgetClient.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 8/30/23.
//

import Foundation

struct BudgetClient {
    
    static let shared = BudgetClient()
    private var baseUrl: String
    private var userId: String
    
    private init() {
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: "SMART_BUDGET_URL") as? String ?? ""
        let userId = Bundle.main.object(forInfoDictionaryKey: "USER_ID") as? String ?? ""
        
        self.baseUrl = baseUrl
        self.userId = userId
    }
    
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
    
    func buildCardExpensesURL(cardId: Int) -> URL {
        let expsRange = Bundle.main.object(forInfoDictionaryKey: "EXPENSES_RANGE") as? String ?? ""
        
        let expenses_url = URL(string: "\(self.baseUrl)/card/expenses?range=\(cardId)-\(expsRange)&account=\(self.userId)")!
        
        return expenses_url
    }
    
    func buildCardListURL() -> URL {
        let cardsRange = Bundle.main.object(forInfoDictionaryKey: "CARDS_RANGE") as? String ?? ""
        
        let cards_url = URL(string: "\(self.baseUrl)/cards?range=\(cardsRange)&account=\(self.userId)")!
        
        return cards_url
    }
    
    func fetchCardExpenses(cardId: Int) async throws -> [Expense] {
        
        let expenses_url = buildCardExpensesURL(cardId: cardId)
        
        let data = try await getResource(at: expenses_url)
        
        do {
            return try JSONDecoder().decode([Expense].self, from: data)
        } catch {
            print("Error getting the card expenses detail: ", error)
            throw BudgetClientError.decodingError(error)
        }
    }
    
    func fetchEntityCards() async throws -> [Card] {
        
        let data = try await getResource(at: buildCardListURL())
        
        do {
            return try JSONDecoder().decode([Card].self, from: data)
        } catch {
            print("fetchEntityCards error: ", error)
            throw BudgetClientError.decodingError(error)
        }
    }
}
