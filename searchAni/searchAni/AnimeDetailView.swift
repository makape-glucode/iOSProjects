
//import SwiftUI

//struct AnimeDetailView: View {
//    let anime: Datum
//
//    var body: some View {
//        VStack {
////            HStack() {
//////                Button {
//////
//////                }
////                Image(systemName: "xmark.circle.fill")
////                    .padding(.leading, 350)
////            }
//
//            Spacer()
//
//            Image("naruto")
//                .resizable()
//                .frame(height: 400)
//            Divider()
//
//
//
//
//            Text(anime.title ?? "Naruto")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding()
//            Divider()
//                .padding(.bottom)
//
//            Text("The Desription: Naruto is a Japanese manga series written and illustrated by Masashi Kishimoto. It tells the story of Naruto Uzumaki, a young ninja who seeks recognition from his peers and dreams of becoming the Hokage, the leader of his village.")
//                .font(.title3)
//                .padding()
////                Spacer()
//
//            Button("Watch Now") {
//                print("Button tapped!")
//            }
//            .padding(.top, 20)
//            .padding(.bottom,20)
//        }
//    }
//}

//struct AnimeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimeDetailView()
//    }
//}


import SwiftUI

struct AnimeDetailView: View {
    let anime: Datum
    let animeImage: ImageModel?
    
    var body: some View {
        VStack {
            Text(anime.title ?? "Unknown Title")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Display additional details of the selected anime here
            // For example: Images, synopsis, trailers, etc.
            
            // Display the anime image if available
            if let imageURL = animeImage?.imageURL, let url = URL(string: imageURL), let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .padding()
            }
            //            if let source = anime.source {
            //                Text("Source: \(source)")
            //            }
            
            ScrollView{
                if let synopsis = anime.synopsis {
                    Text("Synopsis: \(synopsis)")
                        .font(.headline)
                        .padding()
                }
            }
        }
        .padding()
    }
}
