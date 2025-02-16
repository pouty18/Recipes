//
//  String+Ext.swift
//  FetchRecipes
//
//  Created by Richard Poutier on 2/15/25.
//

import Foundation

// source -> playing youtube video's on iOS without 3rd party framework
// https://stackoverflow.com/questions/44499332/to-play-youtube-video-in-ios-app

extension String {
  var youtubeID: String? {
    let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/)|(?<=shorts/))([\\w-]++)"
    
    let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    let range = NSRange(location: 0, length: count)
    
    guard let result = regex?.firstMatch(in: self, range: range) else {
      return nil
    }
    
    return (self as NSString).substring(with: result.range)
  }
}
