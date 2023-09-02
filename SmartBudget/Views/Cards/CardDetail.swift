//
//  BudgetCardAnalytics.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/1/23.
//

import SwiftUI

struct CardDetail: View {
    var cardId: String
    @State private var card: Card?
    
    func getCardDetail() async {
        do {
            card = try await BudgetClient.shared.fetchCardDetail(at: URL(string: "https://jsonplaceholder.typicode.com/users/" + cardId)!)
        } catch {
            print("Error getting the card detail: ", error.localizedDescription)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack{
                    Text(card?.name ?? "")
                        .font(.title)
                        .foregroundColor(.primary)
                }
            }
        }.task {
            await getCardDetail()
        }
    }
}

struct CardDetail_Previews: PreviewProvider {
    static var previews: some View {
        CardDetail(cardId: "1")
    }
}
