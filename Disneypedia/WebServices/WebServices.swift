//
//  WebServices.swift
//  Disneypedia
//
//  Created by Jibryll Brinkley on 10/16/24.
//


import Foundation


final class WebServices {
    
    static func getCharacterData() async throws -> CharacterListData {
        
        let urlString = "https://api.disneyapi.dev/character"
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(CharacterListData.self, from: data)
        } catch {
            throw ErrorCases.invalidData
        }
    }   
}
