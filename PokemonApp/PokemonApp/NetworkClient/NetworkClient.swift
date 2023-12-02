//
//  NetworkClient.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

protocol NetworkClient {
    func call<T: Decodable>(urlRequest: URLRequest) async throws -> T
    func getCall<T: Decodable>(url: String, queryParams: [String : String]?) async throws -> T
    func postCall<T: Decodable>(url: String, body: Encodable?) async throws -> T
}
