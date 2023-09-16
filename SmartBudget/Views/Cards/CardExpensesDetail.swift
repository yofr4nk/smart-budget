//
//  BudgetCardAnalytics.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/1/23.
//

import SwiftUI

struct CardExpensesDetail: View {
    var card: Card
    @State private var expenses: [Expense]?
    
    func getCardExpensesDetail() async {
        do {
            expenses = try await BudgetClient.shared.fetchCardExpenses(at: URL(string: "http://localhost:8080/card/\(card.id)/expenses")!)
        } catch {
            print("Error getting the card detail: ", error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            HStack{
                CardRow(card: card, cardIndex: 0, isExpanded: true)
            }
            .padding()
            
            HStack{
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
                .scrollContentBackground(.hidden)
                .background(.white)

            }
        }
        .task {
            await getCardExpensesDetail()
        }
    }
}

struct CardDetail_Previews: PreviewProvider {
    static var previews: some View {
        CardExpensesDetail(card: Card(id: 1, name: "Gold MasterCard", owner: "Mock Name", type: "Gold"))
    }
}
