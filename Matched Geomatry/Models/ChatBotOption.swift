//
//  ChatBotOption.swift
//  Matched Geomatry
//
//  Created by Ravi on 08/03/22.
//

import Foundation


struct ChatBotOption: Codable, Identifiable{
    var id: String = ""
    var text: String = ""
    var action: ChatBotOption.Action = .None
    var nextMessageId: String = ""
    
    enum Action: String, Codable{
        case None = "None"
        case ReplaceBlankWithOption = "ReplaceBlankWithOption"
    }
}
