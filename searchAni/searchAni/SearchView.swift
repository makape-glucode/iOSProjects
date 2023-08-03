//
//  SearchView.swift
//  searchAni
//
//  Created by Makape Tema on 2023/08/01.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel = AnimeViewModel()
    @State private var searchText = ""
    @State private var isShowingSheet = false
    @State private var selectedTab: Tab = .search 
    @State private var selectedAnime: Datum? = nil
    @State private var selectedAnimeImage: ImageModel? = nil
    
    enum Tab {
        case home
        case search
        case favorites
    }
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                // Tab 1: Search Tab
                VStack {
                    // Search Bar
                    TextField("Search Anime by Category or Title", text: $viewModel.searchText, onCommit: {
                        viewModel.searchAnime()
                    })
                    .border(.black)
                    .cornerRadius(9)
                    .padding(.horizontal)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, -150)
                    .padding(.horizontal, 10)
                    
                    // Display the search results in a List
                    if let animeData = viewModel.animeData, let animeList = animeData.data {
                        List(animeList, id: \.malID) { anime in
                            Text(anime.title ?? "Unknown Title")
                                .onTapGesture {
                                    selectedAnime = anime // Store the selected anime
                                    selectedAnimeImage = anime.images?["jpg"] 
                                }
                        }
                        .popover(item: $selectedAnime) { anime in
                            AnimeDetailView(anime: anime, animeImage: selectedAnimeImage)
                        
//                        .popover(item: $selectedAnime) { anime in
//                            AnimeDetailView(anime: anime, animeImage: selectedAnimeImage) // Pass anime image to AnimeDetailView
                        }
                    } else {
                        Text("No results found")
                    }
                }
                .tabItem {
                    Image(systemName: "house") // Search icon
                    Text("Home")
                }
                .tag(Tab.search)
                
                // Tab 2: Favorites Tab
                VStack {
                    Text("Favorites Tab Content")
                }
                .tabItem {
                    Image(systemName: "magnifyingglass") // Star icon
                    Text("Search")
                }
                .tag(Tab.favorites)
                
                // Tab 3: Settings Tab
                VStack {
                    Text("Favorites showing here")
                }
                .tabItem {
                    Image(systemName: "star") // Gear icon
                    Text("Favorites")
                }
                .tag(Tab.home)
            }
        }
    }
}

// Mark: My structs
struct SearchResultsSheet: View {
    var animeList: [Datum]
    @Binding var isShowingSheet: Bool // Binding to control the visibility of the sheet
    
    var body: some View {
        NavigationView {
            List(animeList, id: \.malID) { anime in
                Text(anime.title ?? "Unknown Title")
            }
            .navigationTitle("Search Results")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isShowingSheet = true // Dismiss the sheet
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
