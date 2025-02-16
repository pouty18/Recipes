//
//  CacheAsyncImage.swift
//
//  Created by Costantino Pistagna on 08/02/23.
//

// modified approach after studying approach from S.O. article here https://stackoverflow.com/questions/69214543/how-can-i-add-caching-to-asyncimage

import SwiftUI

struct CustomAsyncImage<Content: View, Placeholder: View>: View {
  enum LoadingState {
    case notStarted
    case success(Image)
    case loading
    case failure(Error)
  }
  
  @State private var loadingState: LoadingState = .notStarted
  @State private var image: Image? = nil
  let url: URL
  private let content: (Image) -> Content
  private let placeholder: () -> Placeholder
  
  init(url: URL, @ViewBuilder content: @escaping (Image) -> Content, @ViewBuilder placeholder: @escaping () -> Placeholder) {
    self.url = url
    self.content = content
    self.placeholder = placeholder
  }
  
  var body: some View {
    ZStack {
      if let image {
        content(image)
      } else {
        switch loadingState {
          case .notStarted, .success, .loading:
            placeholder()
          case .failure:
            placeholder()
              .overlay {
                Button {
                  Task {
                    await self.downloadImage()
                  }
                } label: {
                  Image(systemName: "arrow.clockwise")
                }.buttonStyle(.borderedProminent)
              }
        }
      }
    }.task {
      loadingState = .loading
      await downloadImage()
    }
  }
  
  func downloadImage() async {
    do {
      loadingState = .loading
      let downloadedImage = try await ImageCache.shared.download(url: url)
      self.image = downloadedImage
    } catch let error as ImageCacheError {
      loadingState = .failure(error)
    } catch {
      loadingState = .failure(error)
    }
  }
}

#Preview {
  CustomAsyncImage(url: URL(string: "https://picsum.photos/400")!) { image in
    image
      .resizable()
      .frame(width: 150, height: 150)
      .clipShape(RoundedRectangle(cornerRadius: 8))
  } placeholder: {
    RoundedRectangle(cornerRadius: 8)
      .frame(width: 150, height: 150)
  }
}
