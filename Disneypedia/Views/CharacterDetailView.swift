//
//  CharacterDetailVIew.swift
//  Disneypedia
//
//  Created by Jibryll Brinkley on 10/17/24.
//

import SwiftUI

//I want this view to show:
//1) Async Image of character (imageURL)
//2) films, tvShows, videoGames, parkAttractions

struct CharacterDetailView: View {

@ObservedObject var characterListViewModel = CharacterListViewModel()
let character: CharacterData

var body: some View {
    ZStack {
        Color(red: 118/255, green: 208/255, blue: 192/255)
            .ignoresSafeArea(.all)
        VStack {
                AsyncImage(url: URL(string: character.imageURL ?? "123")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Rectangle())
                        .frame(height: 400)
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    Image("walt-disney-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Rectangle())
                        .frame(height: 400)
                        .frame(maxWidth: .infinity)
                }
            Spacer()
            
            ScrollView {

                Text("Films: ")
                    .font(.title2)
                    .fontWeight(.heavy)
                ForEach(character.films, id: \.self) { film in
                    Text(" -\(film)")
                }
                
                Text("TV Shows: ")
                    .font(.title2)
                    .fontWeight(.heavy)
                ForEach(character.tvShows, id: \.self) { show in
                    Text(" -\(show)")
                }
                
                Text("Video Games: ")
                    .font(.title2)
                    .fontWeight(.heavy)
                ForEach(character.videoGames, id: \.self) { game in
                    Text(" -\(game)")
                        .font(.subheadline)
                }
                
                Text("Park Attractions: ")
                    .font(.title2)
                    .fontWeight(.heavy)
                ForEach(character.parkAttractions, id: \.self) { parkAttraction in
                    Text(" -\(parkAttraction)")
                        .font(.subheadline)
                }
            }
            
            Spacer()
        }
    }
    .task {
        await characterListViewModel.getCharacterDetails(characterID: String(character.id ?? 308))
    }
}
}

//#Preview {
//    CharacterDetailView()
//}
