//
//  ContentView.swift
//  Matched Geomatry
//
//  Created by Ravi on 07/03/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var botStore = ChatBotViewModel()
    @Namespace var animation
    var body: some View {
        VStack{
            InsightsView(botStore: botStore, animation: animation)
            ChatBot(botStore: botStore, animation: animation)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
