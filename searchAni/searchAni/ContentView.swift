import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AnimeViewModel()
    @State private var searchText = ""
    @State private var isShowingSheet = false
    @State private var selectedTab: Tab = .home
    @State private var selectedAnime: Datum?
    
    enum Tab {
        case home
        case search
        case favorites
    }
  
    let theGenres = ["Horror", "Action", "Romance", "SciFi", "Genre", "Genre1"]
    // Images carousel
    let carouselImages = ["naruto", "bleach", "dms", "pokemon", "image1", "1piece", "dbz", "1punch"]
    
    var imageName = "naruto"

    @State private var currentIndex = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            // Tab1: Home Tab
            VStack {
                VStack {
                    
                    // Replace the existing Image("naruto") with CarouselView
                    CarouselView(imageUrls: carouselImages)
//                        .resizable()
//                        .frame(height: 415)
//                        .padding(.top, -400)
                    Image("naruto")
                        .resizable()
                        .frame(height: 415)
                        .padding(.top, -400)
//                    Divider()
                    Spacer()
//                    ScrollView(.vertical) {
                    VStack {
//                        VStack {
                    
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 10) {
                                    ForEach(theGenres, id: \.self) { genre in
                                        Text(genre)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 16)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(12)
                                    }
                                }
                                .padding(.horizontal, 0)
                                .padding(.leading)
                            }
                            .padding(.top, 1)
//                        }
//                        .padding()
                        
                        VStack(alignment: .leading) {
                            Text("You may also like!")
                                .padding(.leading)
                                .fontWeight(.bold)
                                .font(.title2)
                            
                            Divider()
                            ScrollView(.horizontal) {
                                VStack {
                                    CollectionView(imageUrls: carouselImages)
                                }
                                .padding(.leading, -10)
                                Divider()
                            }
                            ScrollView(.horizontal) {
                                CollectionView(imageUrls: carouselImages)
                            }
                            .padding(.leading, -10)
                            Divider()
                        }
                    }
                }
                .padding(.top, 330)
            }
            .tabItem {
                Image(systemName: "house") 
                Text("Home")
            }
            .tag(Tab.home)
            
            // Tab 2: Search Tab
            VStack {
                // Search Bar
                TextField("Search Anime by Category or Title", text: $searchText, onCommit: {
                    performSearch()
                })
                .border(.black)
                .cornerRadius(9)
                .padding(.horizontal)
                .textFieldStyle(.roundedBorder)
                .padding(.top, -150)
                .padding(.horizontal, 10)
                
                // Display search results
                if let animeData = viewModel.animeData, let animeList = animeData.data {
                    List(animeList, id: \.malID) { anime in
                        Text(anime.title ?? "Unknown Title")
                    }
                    .sheet(isPresented: $isShowingSheet, content: {
                        SearchResultsSheet(animeList: animeList, isShowingSheet: $isShowingSheet)
                    })
                } else {
                    Text("No results found")
                }
                
//                if let animeData = viewModel.animeData, let animeList = animeData.data {
//                    List(animeList, id: \.malID) { anime in
//                        Button(action: {
//                            selectedAnime = anime // Store the selected anime
//                        }) {
//                            Text(anime.title ?? "Unknown Title")
//                        }
//                    }
//                    .popover(item: $selectedAnime) { anime in
////                        AnimeDetailView(anime: anime) // Present the AnimeDetailView
//                    }
//                } else {
//                    Text("No results found")
//                }
               
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            .tag(Tab.search)
            
            // Tab 3: Favorites Tab
            VStack {
                Text("Favorites")
            }
            .tabItem {
                Image(systemName: "star") 
                Text("Favorites")
            }
            .tag(Tab.favorites)
        }
    }
    
    func doSearch() {
        viewModel.searchAnime()
    }
    
    // Image carousel
    private func startImageCarousel() {
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            withAnimation {
                currentIndex = (currentIndex + 1) % carouselImages.count
            }
        }
    }
    
    private func performSearch() {
        viewModel.searchAnime()
    }
}

// strct

//struct CollectionView: View {
//
//    var body: some View {
//        HStack {
//            RoundedRectangle(cornerRadius: 12)
//                .foregroundColor(.blue)
//                .background(.clear)
//                .frame(width: 150, height: 150)
//
//            RoundedRectangle(cornerRadius: 12)
//                .foregroundColor(.black)
//                .background(.clear)
//                .frame(width: 150, height: 150)
//
//            RoundedRectangle(cornerRadius: 12)
//                .foregroundColor(.red)
//                .background(.clear)
//                .frame(width: 150, height: 150)
//
//            RoundedRectangle(cornerRadius: 12)
//                .foregroundColor(.orange)
//                .background(.clear)
//                .frame(width: 150, height: 150)
//
//            RoundedRectangle(cornerRadius: 12)
//                .foregroundColor(.yellow)
//                .background(.clear)
//                .frame(width: 150, height: 150)
//
//            RoundedRectangle(cornerRadius: 12)
//                .foregroundColor(.gray)
//                .background(.clear)
//                .frame(width: 150, height: 150)
//        }
//        .padding(.leading, 20)
//        .padding(.trailing, 10)
//    }
//}

struct CollectionView: View {
    let imageUrls: [String]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(imageUrls, id: \.self) { imageUrl in
                    RemoteImageView(imageUrl: imageUrl)
                        .frame(width: 150, height: 150)
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct RemoteImageView: View {
    let imageUrl: String
    
    var body: some View {
        if let url = URL(string: imageUrl), let data = try? Data(contentsOf: url),
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Color.gray // Placeholder for failed image loading
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
