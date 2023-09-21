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
            Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                HStack {
                    Text("Total Expenses: ")
                        .font(.title3)
                        .padding(.top, 20)
                    Text("\(expenses?.reduce(0, { $0 + $1.amount}) ?? 0)")
                        .font(.callout)
                        .padding(.top, 20)
                }
                
                Chart(expenses ?? []) {
                    SectorMark(
                        angle: .value("Value", $0.amount),
                        innerRadius: .ratio(0.618),
                        outerRadius: .inset(10),
                        angularInset: 1
                    )
                    .cornerRadius(4)
                    .foregroundStyle(by: .value("Category", $0.category))
                }
                .padding(.bottom, 20)
                
            }
            .padding(.horizontal)
        }
        .frame(height: UIScreen.main.bounds.height * 0.58)
        .transition(.move(edge: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding()
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
