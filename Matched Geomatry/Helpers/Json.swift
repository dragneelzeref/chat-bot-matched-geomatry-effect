//
//  Json.swift
//  Matched Geomatry
//
//  Created by Ravi on 07/03/22.
//

import Foundation


func load<T: Decodable>(_ filename: String) throws -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            throw "Couldn't find \(filename) in main bundle."
        }

    do {
        data = try Data(contentsOf: file)
    } catch {
        throw "Couldn't load \(filename) from main bundle:\n\(error)"
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        throw "Couldn't parse \(filename) as \(T.self):\n\(error)"
    }
}
