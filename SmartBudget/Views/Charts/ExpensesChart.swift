//
//  ExpensesChart.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/16/23.
//

import SwiftUI
import Charts

struct ExpensesChart: View {
    var expenses: [Expense]?
    var cardBugetLimit: Float32
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                HStack {
                    Text("Total Expenses: ")
                        .font(.title3)
                    Text("\(expenses?.reduce(0, { $0 + $1.amount}) ?? 0)")
                        .font(.callout)
                }
                
                Chart(expenses ?? []) {
                    BarMark(
                        x: .value("Category", $0.category),
                        y: .value("Amount", $0.amount)
                    )
                    
                    RuleMark(y: .value("Card budget limit", cardBugetLimit))
                        .foregroundStyle(.orange)
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                        .annotation(alignment: .topTrailing) {
                            Text("Budget")
                                .font(.footnote)
                                .foregroundColor(.orange)
                        }
                }
                .frame(height: 220)
                .chartPlotStyle { plotContent in
                    plotContent
                        .background(.blue.gradient.opacity(0.3))
                        .border(.blue.gradient.opacity(0.5), width: 1)
                    
                }
            }
            .padding(.horizontal)
        }
        .frame(height: UIScreen.main.bounds.height * 0.6)
        .transition(.move(edge: .bottom))
        .cornerRadius(CGFloat(30))
    }
}

struct ExpensesChart_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesChart(expenses: [
            Expense(id: 1, description: "Grocery Shopping", amount: Float32(11438), date: "20-08-23", category: "Groceries", cardID: 1),
            Expense(id: 2, description: "Electronics Purchase", amount: Float32(799.99), date: "20-08-24", category: "Electronics", cardID: 1)
        ], cardBugetLimit: Float32(10000))
    }
}
