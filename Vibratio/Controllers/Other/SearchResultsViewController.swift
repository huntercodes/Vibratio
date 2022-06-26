//
//  SearchResultsViewController.swift
//  SpotifyUIKit
//
//  Created by hunter downey on 4/27/22.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private var sections: [SearchSection] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor(named: "otherColor")
        tableView.register(SearchResultDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultDefaultTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "otherColor")
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with results: [SearchResult]) {
        let artists = results.filter({
            switch $0 {
                case .artist: return true
                default: return false
            }
        })
        let albums = results.filter({
            switch $0 {
                case .album: return true
                default: return false
            }
        })
        let playlists = results.filter({
            switch $0 {
                case .playlist: return true
                default: return false
            }
        })
        let tracks = results.filter({
            switch $0 {
                case .track: return true
                default: return false
            }
        })
        
        self.sections = [
            SearchSection(title: "Songs", results: tracks),
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "Albums", results: albums),
            SearchSection(title: "Playlists", results: playlists)
        ]
        
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        
        switch result {
            case .artist(let artist):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultDefaultTableViewCell.identifier,
                    for: indexPath
                ) as? SearchResultDefaultTableViewCell else {
                    return UITableViewCell()
                }
            
                let vm = SearchResultDefaultTableViewModel(title: artist.name, imageURL: URL(string: artist.images?.first?.url ?? ""))
            
                cell.configure(with: vm)
                return cell
            case .album(let album):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultDefaultTableViewCell.identifier,
                    for: indexPath
                ) as? SearchResultDefaultTableViewCell else {
                    return UITableViewCell()
                }
            
                let vm = SearchResultDefaultTableViewModel(title: album.name, imageURL: URL(string: album.images.first?.url ?? ""))
            
                cell.configure(with: vm)
                return cell
            case .track(let track):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultDefaultTableViewCell.identifier,
                    for: indexPath
                ) as? SearchResultDefaultTableViewCell else {
                    return UITableViewCell()
                }
            
                let vm = SearchResultDefaultTableViewModel(title: track.name, imageURL: URL(string: track.album?.images.first?.url ?? ""))
            
                cell.configure(with: vm)
                return cell
            case .playlist(let playlist):
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultDefaultTableViewCell.identifier,
                    for: indexPath
                ) as? SearchResultDefaultTableViewCell else {
                    return UITableViewCell()
                }
            
                let vm = SearchResultDefaultTableViewModel(title: playlist.name, imageURL: URL(string: playlist.images.first?.url ?? ""))
            
                cell.configure(with: vm)
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = sections[indexPath.section].results[indexPath.row]
        
        delegate?.didTapResult(result)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: SearchResult)
}
