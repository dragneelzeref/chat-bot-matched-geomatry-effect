//
//  ChatBotViewModel.swift
//  Matched Geomatry
//
//  Created by Ravi on 08/03/22.
//

import Foundation

class ChatBotViewModel: ObservableObject{
    
    // Keeping track of messages and save it on firebase
    @Published var conversation: [Message] = []
    
    // Chatbot
    @Published var currentPayload: ChatBotPayload = ChatBotPayload()
    @Published var currentMessage: ChatBotMessage = ChatBotMessage()
    
    @Published var showOptions:Bool = false
    @Published var showTypingIndicator: Bool = false
    @Published var isConvesationOver: Bool = false
    
    var pause: Bool = false
    
    var didOptionClick: Bool = false

    let insightID = "FullWeekStatsID"
    @Published var insightGeomatry: Bool = false
    var insightGeoTemp: Bool = false
    
    let botFile = "bot.json"
    init(){
        loadJson(botFile)
    }

    func loadJson(_ file: String){
        reset()
        do {
            try currentPayload = load(file)
            if let firstMessage = currentPayload.messages.first{
                currentMessage = firstMessage
            }
            loadChatBotMessage()
        } catch {
            debugPrint("Error -> loadInsightJson: \(error)")
        }
    }
    
    func reset(){
        conversation = []
        showOptions = false
        showTypingIndicator = true
        isConvesationOver = false
        pause = false
        insightGeomatry = false
        insightGeoTemp = false
    }
    
    
    func loadChatBotMessage(){

        if showTypingIndicator == false{
            showTypingIndicator = true
        }
        
        if insightGeoTemp{
            insightGeoTemp = false
        }
        
        var replacedTextMessage = currentMessage.text

        switch(currentMessage.action){
        case .Name:
            replacedTextMessage = replacedTextMessage.replacingOccurrences(of: "${}", with: "Mr. X")
            break
        case .InsightGeomatry:
            insightGeoTemp = true
            break
        default:
            break
        }
        
        let delay = currentMessage.delay
        let msg = Message(id: currentMessage.id, style: currentMessage.style, text: replacedTextMessage)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.appendMessageAndContinue(msg)
        }


    }
    
    func appendMessageAndContinue(_ message: Message){
        if insightGeoTemp{
            insightGeomatry = true
        }
        if !conversation.contains(message){
            conversation.append(message)
            if pause{
                showTypingIndicator = false
            }
        }
        // If there's no options go to next message
        if currentMessage.options.isEmpty{
            
            // Go to nextMessageId if available
            if currentMessage.nextMessageId != "" || currentMessage.nextMessageId != "nil",
               let nextMessage = currentPayload.messages.first(where: { $0.id == currentMessage.nextMessageId }){
                self.currentMessage = nextMessage
            }
            // Go to next message is nextMessageId not available
            else if let currentMessageIndex = currentPayload.messages.firstIndex(where: { $0.id == currentMessage.id }),
                    currentMessageIndex + 1 < currentPayload.messages.count{
                self.currentMessage = currentPayload.messages[currentMessageIndex + 1]
            }
            // End of conversation
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.currentMessage = ChatBotMessage()
                    self.endOfConvesation()
                }
                return
            }
            // Load next message if not pause
            guard !pause else { return }
            loadChatBotMessage()
        }
        // Show Options
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.showOptions = true
                self.showTypingIndicator = false
            }
        }
        
    }
    
    func onClickChatBotOption(option: ChatBotOption){
        guard !didOptionClick else { return }
        
        didOptionClick = true
        let opt = Message(style: .User, text: option.text)
        
        showOptions = false
        conversation.append(opt)
  
        
        switch(option.action){
            
        case .ReplaceBlankWithOption:
            let count = conversation.count
            let lastMessage = conversation[count - 1]
            let replacedTextMessage = lastMessage.text.replacingOccurrences(of: "___", with: option.text)
            conversation[count - 1].text = replacedTextMessage
            break
            
        default:
            break
        }
        didOptionClick = false
        
        if option.nextMessageId != "" || option.nextMessageId != "nil",
        let nextMessage = currentPayload.messages.first(where: { $0.id == option.nextMessageId }){
            currentMessage = nextMessage
            guard !pause else { return }
            loadChatBotMessage()
        }
        // End of conversation
        else{
            showTypingIndicator = false
            showOptions = false
            currentMessage = ChatBotMessage()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.endOfConvesation()
            }
        }
    }
    
    func resume(){
        pause = false
        loadChatBotMessage()
    }

    
    func endOfConvesation(){
        debugPrint("End")
    }
    
}

