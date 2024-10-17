//
//  ContentView.swift
//  Disneypedia
//
//  Created by Jibryll Brinkley on 10/16/24.
//

import SwiftUI

struct CharacterListView: View {
    
    @ObservedObject var characterListViewModel = CharacterListViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(red: 74/255, green: 98/255, blue: 216/255)
                    .ignoresSafeArea(.all)
                
                if let charactersData = characterListViewModel.characters?.data {
                    
                    List(charactersData, id: \.id) { character in
                        
                        HStack {
                            AsyncImage(url: URL(string: character.imageURL ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(width: 90, height: 90)
                            } placeholder: {
                                Image("walt-disney-logo")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                            }
                            
                            Text(character.name ?? "N/A")
                                .font(.title3)
                                .fontWeight(.light)
                                .foregroundColor(Color.white)
                        }
                        
                        .listRowBackground(Color(red: 74/255, green: 98/255, blue: 216/255))
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .gridColumnAlignment(.leading)
                    .navigationTitle("Characters")
                }
            }
            
            .task {
                await characterListViewModel.getCharacters()
                
                //                characterListViewModel.printCharacterNames()
                
            }
        }
    }
}

#Preview {
    CharacterListView()
}
