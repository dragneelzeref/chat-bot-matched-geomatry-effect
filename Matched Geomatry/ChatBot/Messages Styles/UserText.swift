//
//  UserText.swift
//  Matched Geomatry
//
//  Created by Ravi on 07/03/22.
//

import SwiftUI

struct UserText: View {
    var message: String
    var body: some View {
        HStack(spacing: 12){
            Spacer()
            Text(message)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(
                            Color("MessengerBlue")
                        )
                )
                .frame(maxWidth: 280, alignment: .trailing)
        }
        .padding(.horizontal)
    }
}

struct UserText_Previews: PreviewProvider {
    static var previews: some View {
        UserText(message: "Hey Bot! 👊")
    }
}
