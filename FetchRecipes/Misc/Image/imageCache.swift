//
//  imageCache.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/19/25.
//

import Foundation
import SwiftUI

actor ImageCache {
  static let shared = ImageCache()
  
  private var cache: [URL: Image] = [:]
  private var tasks: [URL: Task<Image, Error>] = [:]
  
  func download(url: URL) async throws -> Image {
    if let cachedImage = cache[url] {
      return cachedImage
    }
    
    // check on disk cache after first checking memory
    if let image = await ImageFileManager.shared.getImageFrom(url: url) {
      cache[url] = Image(uiImage: image)
      return Image(uiImage: image)
    }
    
    if let task = tasks[url] {
      return try await task.value
    }
    
    let downloadTask = Task {
      guard let data = try? await URLSession.shared.data(from: url).0 else {
        throw ImageCacheError.failedToGetData
      }
      guard let uiImage = UIImage(data: data) else { throw ImageCacheError.badData }

      let image = Image(uiImage: uiImage)
      cache[url] = image
      
      try? await ImageFileManager.shared.writeToDisk(imageUrl: url, uiImage: uiImage)
      
      return image
    }
    
    tasks[url] = downloadTask
    return try await downloadTask.value
  }
}

enum ImageCacheError: Error {
  case failedToGetData
  case badData
  
}
