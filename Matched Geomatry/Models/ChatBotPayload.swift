//
//  ChatBotPayload.swift
//  Matched Geomatry
//
//  Created by Ravi on 08/03/22.
//

import Foundation


struct ChatBotPayload: Codable, Identifiable{
    var id: String = UUID().uuidString
    var messages: [ChatBotMessage] = []
}
