//
//  DotView.swift
//  Matched Geomatry
//
//  Created by Ravi on 08/03/22.
//

import SwiftUI


struct DotView: View {
    @State var delay: Double = 0 // 1.
    @State var scale: CGFloat = 0.5
    var body: some View {
        Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(
                Color.gray
            )
            .scaleEffect(scale)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.6).repeatForever().delay(delay)) {
                    self.scale = 1
                }
            }
    }
}

struct DotView_Previews: PreviewProvider {
    static var previews: some View {
        DotView()
    }
}
