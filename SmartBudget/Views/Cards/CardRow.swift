//
//  CardRow.swift
//  SmartBudget
//
//  Created by yofrank sanchez on 9/4/23.
//

import SwiftUI

struct CardRow: View {
    var card: Card
    
    var body: some View {
        GeometryReader{proxy in
            ZStack(alignment: .bottomLeading){
                Image(card.type)
                    .resizable()
                    .frame(height: 220)
                
                VStack(alignment: .leading, spacing: 130){
                    Text(card.name)
                        .fontWeight(.bold)
                        .font(.title3)
                    
                    Text(card.owner)
                        .font(.callout)
                        .fontWeight(.bold)
                }
                .padding()
                .padding(.bottom, 10)
                .colorInvert()
            }
        }
        .frame(height: 200)
    }
}

struct CardRow_Previews: PreviewProvider {
    static var previews: some View {
        CardRow(card: Card(id: 1, name: "Mock Name", owner: "Mock Owner", type: "Gold"))
    }
}
