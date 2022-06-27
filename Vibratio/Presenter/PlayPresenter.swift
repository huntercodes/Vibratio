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
        } else if !tracks.isEmpty {
            return tracks.first
        }
        
        return nil
    }
    
    var player: AVPlayer?
    
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
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
}

extension PlayPresenter: PlayerViewControllerDelegate {
    func didTapForward() {
        if tracks.isEmpty {
            player?.pause()
        } else {
            
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            player?.pause()
            player?.play()
        } else {
            
        }
    }
    
    func didTapPlayPause() {
        if let player = player {
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
