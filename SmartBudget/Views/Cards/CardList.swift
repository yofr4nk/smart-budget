//
//  CardList.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/1/23.
//

import SwiftUI

struct CardList: View {
    @State private var cards: [Card] = []
    @State var isExpanded: Bool = false
    
    func getCards() async {
        do {
            cards = try await BudgetClient.shared.fetchEntityCards(at: URL(string: "http://localhost:8080/cards")!)
        } catch {
            print("Error getting cards: ", error.localizedDescription)
        }
    }
    
    func getCardIndex(card: Card) -> Int {
        return cards.firstIndex { ccard in
            return ccard.id == card.id
        } ?? 0
    }
    
    var body: some View {
        VStack(spacing: 0){
            Text("SmartBudget")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: isExpanded ? .leading : .center)
                .overlay(alignment: .trailing) {
                    Button {
                        withAnimation(
                            .interactiveSpring(
                                response: 0.8,
                                dampingFraction: 0.7,
                                blendDuration: 0.7)) {
                                    isExpanded = false
                                }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.blue, in: Circle())
                    }
                    .rotationEffect(.init(degrees: isExpanded ? 45 : 0))
                    .offset(x: isExpanded ? 0 : 10)
                    .opacity(isExpanded ? 1 : 0)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 20){
                    ForEach(cards) { card in
                        CardRow(card: card,
                                cardIndex: getCardIndex(card: card),
                                isExpanded: isExpanded)
                    }
                }.overlay{
                    Rectangle()
                        .fill(.black.opacity(isExpanded ? 0 : 0.01))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                isExpanded = true
                            }
                        }
                    
                }
                .padding(.top, isExpanded ? 10 : 0)
            }
            .coordinateSpace(name: "CARDS")
            .offset(y: 30)
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
