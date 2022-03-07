//
//  ChatBotMessage.swift
//  Matched Geomatry
//
//  Created by Ravi on 08/03/22.
//

import Foundation


struct ChatBotMessage: Codable{
    var id: String = ""
    var style: ChatBotMessage.Style = .Bot
    var text: String = ""
    var action: ChatBotMessage.Action = .None
    var nextMessageId: String = ""
    var delay: Double = 0
    var options: [ChatBotOption] = []
    
    enum Style: String, Codable{
        case Bot = "Bot"
        case User = "User"
        case InsightTile = "InsightTile"
        case None = "None"
    }
    
    enum Action: String, Codable{
        case None = "None"
        case Name = "Name"
        case InsightGeomatry = "InsightGeomatry"
    }
    
}
