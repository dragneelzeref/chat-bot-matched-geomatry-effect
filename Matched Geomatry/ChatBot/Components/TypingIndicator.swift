//
//  TypingIndicator.swift
//  Matched Geomatry
//
//  Created by Ravi on 07/03/22.
//

import SwiftUI


struct TypingIndicator: View {
    var body: some View{
        HStack(spacing: 12){
            HStack {
                DotView() // 1.
                DotView(delay: 0.2) // 2.
                DotView(delay: 0.4) // 3.
            }
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .frame(height: 36)
                        .foregroundColor(
                            Color(.systemGray6)
                        )
                )
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct TypingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        TypingIndicator()
    }
}
