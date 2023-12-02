//
//  APIResponse.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let results: [T]
}
