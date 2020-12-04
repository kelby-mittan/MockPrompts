//
//  Podcast.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/3/20.
//

import Foundation

struct Podcast: Decodable {
    let collectionName: String?
    let artistName: String?
    let artworkUrl100: String?
    let artworkUrl600: String?
}

struct SearchResults: Decodable {
    let results: [Podcast]
}
