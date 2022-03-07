//
//  OptionText.swift
//  Matched Geomatry
//
//  Created by Ravi on 08/03/22.
//

import SwiftUI

struct OptionText: View {
    
    var option: ChatBotOption
    var action: () -> Void = {}
    @State var isClicked: Bool = false
    
    var body: some View {
        Button {
            if !isClicked{
                isClicked = true
                action()
                isClicked = false
            }
        } label: {
            Text(option.text)
                .font(.system(size: 18))
                .foregroundColor(.black)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(
                            Color(.white)
                        )
                        .shadow(color:Color.black.opacity(0.2), radius: 5, x: 2, y: 2)
                )
        }
    }
}

struct OptionText_Previews: PreviewProvider {
    static var previews: some View {
        OptionText(option: ChatBotOption(text: "Hey"))
    }
}
