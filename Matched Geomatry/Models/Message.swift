//
//  Message.swift
//  Matched Geomatry
//
//  Created by Ravi on 08/03/22.
//

import Foundation

struct Message: Codable, Hashable, Identifiable {
    var id: String
    var style: ChatBotMessage.Style
    var text: String
    
    init(style: ChatBotMessage.Style, text: String){
        self.id = UUID().uuidString
        self.style = style
        self.text = text
    }
    
    init(id: String, style: ChatBotMessage.Style, text: String){
        self.id = id
        self.style = style
        self.text = text
    }
    
    init(from dict: [String : Any]) {
        self.id = dict["id"] as? String ?? ""
        if let str = dict["style"] as? String {
            self.style = ChatBotMessage.Style.init(rawValue: str) ?? .Bot
        } else {
            self.style = .Bot
        }
        self.text = dict["text"] as? String ?? ""
    }
    
    func toDictionary() -> [String: Any]{
        return [
            "id": self.id,
            "style": self.style.rawValue,
            "text": self.text
        ]
    }
    
}
