//
//  ImagesView.swift
//  searchAni
//
//  Created by Makape Tema on 2023/08/03.
//

import SwiftUI

struct ImagesView: View {
    @StateObject var viewModel = AnimeViewModel()
    
    var body: some View {
     
        TabView {
            VStack {
                ForEach(viewModel.animeData?.data ?? []) { data in
                    ForEach(data.images ?? [] ) { images in
                        AsyncImage(url: images.imageURL) { image in
                            image.resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }

                    }
                }
            }
        }
        .tabViewStyle(.page)
    }
}

struct ImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesView()
    }
}
