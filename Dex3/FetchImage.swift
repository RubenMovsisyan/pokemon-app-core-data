//
//  FetchImage.swift
//  Dex3
//
//  Created by Ruben Movsisyan on 3/31/24.
//

import SwiftUI

struct FetchedImage: View {
    let url: URL?
    
    var body: some View {
        if let url, let imgData = try? Data(contentsOf: url), let uiImage = UIImage(data: imgData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 6)
        } else {
            Image("bulbasaur")
        }
    }
}

#Preview {
    FetchedImage(url: SamplePokemon.samplePokemon.sprite)
}

