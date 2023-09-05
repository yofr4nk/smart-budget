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
            cards = try await BudgetClient.shared.fetchEntityCards(at: URL(string: "http://localhost:8080/cards")!)
        } catch {
            print("Error getting cards: ", error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack{
            Text("Cards")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 25){
                    ForEach(cards) { card in
                        CardRow(card: card)
                    }
                }
            }
        }
        .padding([.horizontal, .top])
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
