//
//  InsightTile.swift
//  Matched Geomatry
//
//  Created by Ravi on 08/03/22.
//

import SwiftUI


struct InsightTile: View {
    
    var title: String
    var emoji: String
    var color: Color = .yellow
    var textColor: Color = .black
    let size:CGFloat = 120
    
    var body: some View {
        ZStack(alignment: .topLeading){
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Text(emoji)
                        .font(.title)
                }
                Spacer()
                Text(title)
                    .font(.caption)
            }
            .foregroundColor(textColor)
            .padding()
            .frame(width: size, height: size)
            .background(color)
            .cornerRadius(24)
        }
    }
}

struct InsightTile_Previews: PreviewProvider {
    static var previews: some View {
        InsightTile(title: "Boost Productivity", emoji: "🧠")
    }
}
