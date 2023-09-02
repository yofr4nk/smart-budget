//
//  CardList.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/1/23.
//

import SwiftUI

struct CardList: View {
    @State private var cards: [Card] = []
    
    func getCards() async {
        do {
            cards = try await BudgetClient.shared.fetchEntityCards(at: URL(string: "https://jsonplaceholder.typicode.com/users")!)
        } catch {
            print("Error getting cards: ", error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cards) { card in
                    NavigationLink(
                        destination: CardDetail(cardId: String(card.id))) {
                            Text(card.name)
                        }
                }
            }.navigationTitle("Card List")
        }
        .task {
            await getCards()
        }
    }
}

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        CardList()
    }
}
