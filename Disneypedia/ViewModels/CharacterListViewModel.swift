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
    @Published var CharacterDetails: CharacterData?
    @Published var errorMessage: String?
    
    func getCharacters() async {
        do {
            let characters = try await WebServices.getCharacterData()
            self.characters = characters
        } catch(let error) {
            self.errorMessage = error.localizedDescription
        }
    }
    
    
    func getCharacterDetails(characterID: String?) async {
        do {
            let characterDetails = try await WebServices.getCharacterDetails(characterID: characterID ?? "308")
            self.CharacterDetails = characterDetails
 
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
