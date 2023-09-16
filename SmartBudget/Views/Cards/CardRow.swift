//
//  CardRow.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/4/23.
//

import SwiftUI

struct CardRow: View {
    var card: Card
    var cardIndex: Int
    var isExpanded: Bool
    
    var body: some View {
        GeometryReader{proxy in
            let rect = proxy.frame(in: .named("CARDS"))
            let offset = CGFloat(cardIndex * (isExpanded ? 10 : 120))
            
            ZStack(alignment: .bottomLeading){
                Image(card.type)
                    .resizable()
                    .frame(height: 220)
                
                VStack(alignment: .leading, spacing: 130){
                    Text(card.name)
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    Text(card.owner)
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
                .padding(.bottom, 10)
            }
            .offset(y: isExpanded ? offset : -rect.minY + offset)
        }
        .frame(height: 200)
    }
}

struct CardRow_Previews: PreviewProvider {
    static var previews: some View {
        CardRow(
            card: Card(id: 1, name: "Mock Name", owner: "Mock Owner", type: "Gold"),
            cardIndex: 0,
            isExpanded: true
        )
    }
}
