//
//  FeaturedPlaylistsResponse.swift
//  SpotifyUIKit
//
//  Created by hunter downey on 5/25/22.
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

// Sorry future Hunter, you were too lazy to make a CategoryResponse so you copied PlaylistResponse, sue yourself for being a bad developer.
struct CategoryPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}

// User for the Playlist Owner
struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
