//
//  CharacterListVIewModel.swift
//  Disneypedia
//
//  Created by Jibryll Brinkley on 10/16/24.
//

import Foundation


@MainActor
final class CharacterListViewModel: ObservableObject {
    
    @Published var characters: CharacterListData?
    @Published var errorMessage: String?
    @Published var name: String?
    @Published var imageURL: String?
    
    func getCharacters() async {
        do {
            let characters = try await WebServices.getCharacterData()
            self.characters = characters
            self.name = characters.data?[0].name
            self.imageURL = characters.data?[0].imageURL
            
        } catch(let error) {
            self.errorMessage = error.localizedDescription
        }
    }
}
