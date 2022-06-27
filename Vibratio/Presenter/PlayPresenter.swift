//
//  PlayPresenter.swift
//  Vibratio
//
//  Created by hunter downey on 6/26/22.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var artistName: String? { get }
    var imageURL: URL? { get }
}

final class PlayPresenter {
    
    static let shared = PlayPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if let player = self.playerQueue,!tracks.isEmpty {
            let item = player.currentItem
            let items = player.items()
            guard let index = items.firstIndex(where: { $0 == item }) else {
                return nil
            }
            return tracks[index]
        }
        return nil
    }
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        guard let url = URL(string: track.uri ?? "spotify:track:20I6sIOMTCkB6w7ryavxtO") else {
            return
        }
        player = AVPlayer(url: url)
        player?.volume = 0.3
        
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
    }
    
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        self.tracks = tracks
        self.track = nil
        
        self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
            guard let url = URL(string: $0.uri ?? "spotify:track:20I6sIOMTCkB6w7ryavxtO") else {
                return nil
            }
            
            return AVPlayerItem(url: url)
        }))
        
        playerQueue?.volume = 0.3
        playerQueue?.play()
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
}

extension PlayPresenter: PlayerViewControllerDelegate {
    func didTapForward() {
        if tracks.isEmpty {
            player?.pause()
        } else if let firstItem = playerQueue?.items().first {
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            player?.pause()
            player?.play()
        } else if let player = playerQueue {
            
        }
    }
    
    func didTapPlayPause() {
        // Single song
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        // Song queue
        } else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}

extension PlayPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var artistName: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
}
