//
//  NetworkError.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

enum NetworkError: Error {
    case nilResponse
    case badUrl
    case encoding
    case response(Int)
}
