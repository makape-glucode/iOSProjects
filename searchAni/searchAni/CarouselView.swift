//
//  CarouselView.swift
//  searchAni
//
//  Created by Makape Tema on 2023/08/03.
//

import SwiftUI

struct CarouselView: View {
    
    let imageUrls: [String]
    
    @State private var currentIndex = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<imageUrls.count, id: \.self) { index in
                RemoteImageView(imageUrl: imageUrls[index])
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onAppear(perform: startImageCarousel)
    }
    
    private func startImageCarousel() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
            withAnimation {
                currentIndex = (currentIndex + 1) % imageUrls.count
            }
        }
    }
}


//struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView()
//    }
//}
