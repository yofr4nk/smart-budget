//
//  BudgetCardAnalytics.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/1/23.
//

import SwiftUI

struct CardExpensesDetail: View {
    var cardId: Int
    var cardName: String
    @State private var expenses: [Expense]?
    
    func getCardExpensesDetail() async {
        do {
            expenses = try await BudgetClient.shared.fetchCardExpenses(at: URL(string: "http://localhost:8080/card/\(cardId)/expenses")!)
        } catch {
            print("Error getting the card detail: ", error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(expenses ?? []) { expense in
                    HStack{
                        Text(expense.description)
                        Spacer()
                        Text(String(expense.amount))
                            .font(.callout)
                            .foregroundColor(.blue)
                    }
                }
            }
            .task {
                await getCardExpensesDetail()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Text(cardName)
                    .font(.title3)
            }
        }
    }
}

struct CardDetail_Previews: PreviewProvider {
    static var previews: some View {
        CardExpensesDetail(cardId: 1, cardName: "Gold MasterCard")
    }
}
