//
//  Product.swift
//  ShoppingApp
//
//  Created by Furkan Kızmaz on 12.08.2023.
//

import Foundation

struct MandalorianCharacters: Codable {
    let characters: [MandalorianCharacter]
}

struct MandalorianCharacter: Codable {
    let name: String
    let type: String
    let description: String
    let imageUrl: URL?
    let quote: String
}
