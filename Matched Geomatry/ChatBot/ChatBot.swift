//
//  ChatBot.swift
//  Matched Geomatry
//
//  Created by Ravi on 07/03/22.
//

import SwiftUI

struct ChatBot: View {
    @StateObject var botStore: ChatBotViewModel
    var animation: Namespace.ID
    
    let bottomID = "BottomID"
    var body: some View {
        VStack {
            chatScrollVertical
                .edgesIgnoringSafeArea(.top)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ChatBot_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        ChatBot(botStore: ChatBotViewModel(), animation: animation)
    }
}

extension ChatBot{
    var chatScrollVertical: some View{
        GeometryReader{ geo in
            ScrollViewReader{ reader in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        // For animaition Solution that is cused with GeoMatry Reader
                        Spacer()
                        UserText(message: "")
                            .opacity(0)
                        messages
                        typing
                        options
                        last
                    }
                    .frame(minHeight: geo.size.height)
                    .onChange(of: botStore.showTypingIndicator, perform: { _ in
                        scrollToBottom(reader)
                    })
                    .onChange(of: botStore.conversation) { _ in
                        scrollToBottom(reader)
                    }
                    .onChange(of: botStore.showOptions) { _ in
                        scrollToBottom(reader)
                    }
                    .onAppear {
                        scrollToBottom(reader)
                    }
                }
                .padding(.top, 1)
            }
        }
    }
    
    func scrollToBottom(_ reader: ScrollViewProxy){
        withAnimation {
            reader.scrollTo(bottomID, anchor: .bottom)
        }
    }
}


extension ChatBot{
    var messages: some View {
        ForEach(botStore.conversation, id: \.id){ message in
    
            VStack{
                if message.style == ChatBotMessage.Style.Bot{
                    BotText(message: message.text)
                }
                else if message.style == ChatBotMessage.Style.User{
                    UserText(message: message.text)
                }
                else if message.style == ChatBotMessage.Style.InsightTile{
                    HStack{
                        Spacer()
                        if !botStore.insightGeomatry{
                            InsightTile(title: "Boost Productivity", emoji: "🧠")
                                .matchedGeometryEffect(id: botStore.insightID, in: animation)
                        }
                    }
                    .animation(.linear(duration: 1), value: botStore.insightGeomatry)
                    .padding(.trailing)
                }
                else {
                    VStack{}
                    .frame(height: 1)
                }
            }
            .animation(.easeIn, value: botStore.conversation)
        }
    }
}

extension ChatBot{
    var typing: some View{
        VStack{
            if botStore.showTypingIndicator{
                TypingIndicator()
            }
        }
        .transition(.move(edge: .bottom))
        .animation(.easeIn, value: botStore.showTypingIndicator)
    }
}


extension ChatBot{
    var options: some View{
        VStack{
            if botStore.showOptions{
                HStack{
                    Spacer()
                    VStack(alignment: .trailing, spacing: 10) {
                        ForEach(botStore.currentMessage.options, id: \.id){ option in
                            OptionText(option: option) {
                                botStore.onClickChatBotOption(option: option)
                            }
                        }
                    }
                    .padding(.top)
                    .padding(.trailing)
                }
                .opacity(botStore.showOptions ? 1 : 0)
            }
        }
        .transition(.move(edge: .bottom))
        .animation(.easeIn, value: botStore.showOptions)
    }
}

extension ChatBot{
    var last: some View{
        VStack{
        }
        .frame(maxWidth: .infinity)
        .id(bottomID)
        .padding(.vertical)
    }
}
