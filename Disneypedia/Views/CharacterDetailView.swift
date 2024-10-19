//
//  CharacterDetailVIew.swift
//  Disneypedia
//
//  Created by Jibryll Brinkley on 10/17/24.

//I want this view to show:
//1) Async Image of character (imageURL)
//2) films, tvShows, videoGames, parkAttractions

import SwiftUI

struct CharacterDetailView: View {

@ObservedObject var characterListViewModel = CharacterListViewModel()
let character: CharacterData

var body: some View {
    ZStack {
        Color(red: 116/255, green: 107/255, blue: 171/255)
            .ignoresSafeArea(.all)
        VStack {
            
            Text(character.name ?? "broken ;(")
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color(red: 26/255, green: 178/255, blue: 138/255))
            
            AsyncImage(url: URL(string: character.imageURL ?? "123")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
                    .frame(height: 350)
                    .frame(maxWidth: .infinity)
            } placeholder: {
                Image("walt-disney-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
                    .frame(height: 400)
                    .frame(maxWidth: .infinity)
            }
            
                ScrollView {
                    VStack(alignment: .leading) {
                    Text("Films:")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    ForEach(character.films, id: \.self) { film in
                        Text(" • \(film)")
                    }
                    
                    
                    Text("TV Shows:")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.top, 25)
                    
                    ForEach(character.tvShows, id: \.self) { show in
                        Text(" • \(show)")
                    }
                    
                    Text("Video Games:")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.top, 25)
                    
                    ForEach(character.videoGames, id: \.self) { game in
                        Text(" • \(game)")
                    }
                    
                    Text("Park Attractions:")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.top, 25)
                    
                    
                    ForEach(character.parkAttractions, id: \.self) { parkAttraction in
                        Text(" • \(parkAttraction)")
                    }
                }
            }
            .padding(.all, 20)
            .font(.custom("MouseMemoirs-Regular", size: 28))
            .foregroundColor(Color(red: 26/255, green: 178/255, blue: 138/255))
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
