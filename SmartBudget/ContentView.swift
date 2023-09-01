//
//  ContentView.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 8/30/23.
//

import SwiftUI

struct ContentView: View {
    @State private var cards: [Card] = []
    
    func getCards() async {
        do {
            cards = try await BudgetClient.shared.fetchEntityCards(at: URL(string: "https://jsonplaceholder.typicode.com/users")!)
        } catch {
            print("Error getting cards: ", error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(cards) { card in
                    Text(card.name)
                }
            }
        }
        .task {
            await getCards()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
