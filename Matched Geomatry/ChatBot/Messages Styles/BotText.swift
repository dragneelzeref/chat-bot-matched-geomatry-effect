//
//  BotText.swift
//  Matched Geomatry
//
//  Created by Ravi on 07/03/22.
//

import SwiftUI

struct BotText: View {
    var message: String
    var body: some View {
        HStack(alignment: .bottom, spacing: 12){
            Text(message)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(
                            Color(.systemGray6)
                        )
                )
                .frame(maxWidth: 280, alignment: .leading)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct BotText_Previews: PreviewProvider {
    static var previews: some View {
        BotText(message: "Tell me, what main motivation brings you here?")
    }
}
