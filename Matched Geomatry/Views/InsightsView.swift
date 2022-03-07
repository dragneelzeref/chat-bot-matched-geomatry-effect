//
//  InsightsView.swift
//  Matched Geomatry
//
//  Created by Ravi on 08/03/22.
//

import SwiftUI

struct InsightsView: View {
    @StateObject var botStore: ChatBotViewModel
    var animation: Namespace.ID
    var body: some View {
        VStack{
            HStack{
                Text("Insight")
                    .font(.title)
            }
            HStack{
                if botStore.insightGeomatry{
                    InsightTile(title: "Boost Productivity", emoji: "🧠")
                        .matchedGeometryEffect(id: botStore.insightID, in: animation)
                }
                else{
                    InsightTile(title: "Boost Productivity", emoji: "🧠")
                        .opacity(0)
                }
                Spacer()
            }
            .animation(.linear(duration: 1), value: botStore.insightGeomatry)
        }
        .padding()
        .background(Color.yellow.opacity(0.2))
    }
}

struct InsightsView_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        InsightsView(botStore: ChatBotViewModel(), animation: animation)
    }
}
