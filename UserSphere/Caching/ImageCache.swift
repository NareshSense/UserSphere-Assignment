//
//  ImageCache.swift
//  UserSphere

import UIKit

final class ImageCache {
    // Cache to store images in memory
    private let cache = NSCache<NSString, UIImage>()
    // Limit on the number of images
    private let maxCacheCount = 100
    // Limit on the total cost of cached images (80 MB)
    private let maxCacheCost = 80 * 1024 * 1024
    
    // Tracking the current size of the cache manually
    private var currentCacheSize: Int = 0
    
    init() {
        // Set memory limits for NSCache
        cache.countLimit = maxCacheCount
        cache.totalCostLimit = maxCacheCost
    }
    
    // MARK: - Cache Operations
    // Get image
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    // Save image
    func saveImage(_ image: UIImage, forKey key: String) {
        // Calculate the cost of the image (its memory size in bytes)
        let cost = Int(image.size.width * image.size.height * image.scale)
        
        // Add the cost to the current cache size
        currentCacheSize += cost
        
        // Save the image to the cache
        cache.setObject(image, forKey: key as NSString, cost: cost)
        
        // Check if the current cache size exceeds the proactive limit (80 MB)
        checkCacheSizeAndClearIfNeeded()
    }
    
    // MARK: - Cache Cleanup
    // Check if the current cache size exceeds the threshold and clear if necessary
    private func checkCacheSizeAndClearIfNeeded() {
        if currentCacheSize > maxCacheCost {
            clearCache()
        }
    }
    
    // Clear the cache
    private func clearCache() {
        cache.removeAllObjects()
        currentCacheSize = 0 // Reset the size tracker
    }
}
