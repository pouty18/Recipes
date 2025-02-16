//
//  ImageFileManager.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/19/25.
//

import Foundation
import SwiftUI

actor ImageFileManager {
  private let folderName = "recipe_images"
  
  // probably don't want to make this a singleton, running out of time
  public static let shared = ImageFileManager()
  
  var cacheFolderPath: URL? {
    FileManager.default
      .urls(for: .cachesDirectory, in: .userDomainMask)
      .first?
      .appendingPathComponent(folderName, conformingTo: .applicationBundle)
  }
  
  private func getImagePath(url: URL) -> URL? {
    guard let folder = cacheFolderPath else { return nil }
    return folder.appendingPathComponent("\(url.hashValue)" + ".png")
  }
  
  public func writeToDisk(imageUrl: URL, uiImage: UIImage) throws {
    guard let data = uiImage.pngData() else { return }
    guard let url = getImagePath(url: imageUrl) else { return }
    try data.write(to: url)
  }
  
  public func getImageFrom(url: URL) async -> UIImage? {
    guard let url = getImagePath(url: url) else { return nil }
    if FileManager.default.fileExists(atPath: url.path()) {
      return UIImage(contentsOfFile: url.path())
    }
    return nil
  }
  
  private func createFolderIfNeeded() {
    guard let url = cacheFolderPath else { return }
    
    if !FileManager.default.fileExists(atPath: url.path()) {
      try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
    }
  }
}

enum ImageFileManagerError: Error {
  case unableToFindImagePath
}
