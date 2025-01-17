//
//  AsyncImageWithCache.swift
//  UserSphere

import SwiftUI

struct AsyncImageWithCache: View {
    
    let url: URL
    @State private var image: UIImage? = nil
    @State private var isLoading: Bool = false
    private let cache: ImageCache
    
    // Inject the cache as a dependency
    init(url: URL, cache: ImageCache = ImageCache()) {
        self.url = url
        self.cache = cache
    }
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .onAppear {
                        loadImage()
                    }
            }
        }
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 10)
    }
    
    private func loadImage() {
        // Check if the image is in the cache
        if let cachedImage = cache.getImage(forKey: url.absoluteString) {
            Task { @MainActor in
                self.image = cachedImage
            }
        } else {
            isLoading = true
            downloadImage()
        }
    }
    
    private func downloadImage() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                // Handle error
                Task { @MainActor in
                    self.image = nil
                    self.isLoading = false
                }
                return
            }
            
            if let downloadedImage = UIImage(data: data) {
                // Save to cache
                self.cache.saveImage(downloadedImage, forKey: url.absoluteString)
                
                // Update the image on the main thread
                Task { @MainActor in
                    self.image = downloadedImage
                    self.isLoading = false
                }
            }
        }
        .resume()
    }
    
}

