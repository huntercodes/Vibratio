//
//  SearchResult.swift
//  Vibratio
//
//  Created by hunter downey on 6/25/22.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
