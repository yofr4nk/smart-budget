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
    @State private var showCharts: Bool = false
    
    func getCardExpensesDetail() async {
        do {
            expenses = try await BudgetClient.shared.fetchCardExpenses(cardId: card.id)
        } catch {
            print("Error getting the card detail: ", error.localizedDescription)
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    CardRow(card: card, cardIndex: 0, isExpanded: true)
                        .shadow(
                            color: Color.primary.opacity(0.4),
                            radius: 10, x: 0, y: 2)
                    
                    Image(systemName: "chart.xyaxis.line")
                        .resizable()
                        .colorInvert()
                        .frame(width: 40, height: 30)
                        .padding(.trailing, 20)
                        .rotation3DEffect(.degrees(-13), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .onTapGesture {
                            withAnimation(.interactiveSpring(
                                response: 0.8,
                                dampingFraction: 1,
                                blendDuration: 0.7)) {
                                showCharts.toggle()
                            }
                        }
                }.padding()
                
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
                }
                
            }
            
            ZStack {
                if showCharts {
                    ExpensesChart(
                        expenses: expenses,
                        cardBugetLimit: card.budgetLimit)
                }
            }
            .zIndex(2.0)
            .edgesIgnoringSafeArea(.all)
        }
        .edgesIgnoringSafeArea(.bottom)
        .task {
            await getCardExpensesDetail()
        }
    }
}

struct CardDetail_Previews: PreviewProvider {
    static var previews: some View {
        CardExpensesDetail(card: Card(id: 1, name: "Gold MasterCard", owner: "Mock Name", type: "Gold", budgetLimit: Float32(15000)))
    }
}
