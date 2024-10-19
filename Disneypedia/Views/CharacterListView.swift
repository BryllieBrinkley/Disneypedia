//  ContentView.swift
//  Disneypedia
//
//  Created by Jibryll Brinkley on 10/16/24.


import SwiftUI

struct CharacterListView: View {
    
    @ObservedObject var characterListViewModel = CharacterListViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color(red: 116/255, green: 107/255, blue: 171/255))]
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.0, green: 0.4, blue: 1.0), Color(red: 0.9, green: 0.9, blue: 1.0)]),
                               startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)
                
                if let charactersData = characterListViewModel.characters?.data {
                    
                    List(charactersData, id: \.id) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            HStack {
                                AsyncImage(url: URL(string: character.imageURL ?? "")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .shadow(radius: 5)
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 2)
                                        )
                                } placeholder: {
                                    Image("walt-disney-logo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                }
                                .frame(width: 90, height: 90)
                                .animation(.easeInOut(duration: 0.5))
                                
                                VStack(alignment: .leading) {
                                    Text(character.name ?? "N/A")
                                        .font(.custom("MouseMemoirs-Regular", size: 25))
                                        .tracking(1)
                                        .foregroundColor(Color(red: 251/255, green: 190/255, blue: 79/255))
                                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 1, y: 1)
                                        .padding(.leading, 20)
                                }
                            }
                        }
                        .listRowBackground(Color.white.opacity(0.7))
                        .cornerRadius(10)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .gridColumnAlignment(.leading)
                    .navigationTitle("Characters")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            
            .task {
                await characterListViewModel.getCharacters()
            }
        }
    }
}

#Preview {
    CharacterListView()
}

