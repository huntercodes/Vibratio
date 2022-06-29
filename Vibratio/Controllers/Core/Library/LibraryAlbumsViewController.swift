//
//  LibraryAlbumsViewController.swift
//  Vibratio
//
//  Created by hunter downey on 6/27/22.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {

    var albums = [Album]()
    
    private let noAlbumView = ActionLabelView()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        tableView.backgroundColor = UIColor(named: "otherColor")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setUpNoAlbum()
        fetchAlbumData()
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noAlbumView.frame = CGRect(
            x: (view.width - 150) / 2,
            y: (view.height - 150) / 2,
            width: 150,
            height: 150
        )
        
        tableView.frame = view.bounds
    }
    
    private func updateUI() {
        if albums.isEmpty {
            // Show label
            noAlbumView.isHidden = false
            tableView.isHidden = true
        } else {
            // Show table
            noAlbumView.isHidden = true
            tableView.reloadData()
            tableView.isHidden = false
        }
    }
    
    private func setUpNoAlbum() {
        view.addSubview(noAlbumView)
        noAlbumView.delegate = self
        noAlbumView.configure(with: ActionLabelViewModel(text: "You don't have any albums saved.", actionTitle: "Home"))
    }
    
    private func fetchAlbumData() {
        APICaller.shared.getCurrentUserAlbums { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let albums):
                        self?.albums = albums
                        self?.updateUI()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
}

extension LibraryAlbumsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
}

extension LibraryAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultSubtitleTableViewCell.identifier,
            for: indexPath
        ) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        
        let album = albums[indexPath.row]
        
        cell.configure(with: SearchResultSubtitleTableViewModel(
            title: album.name,
            subtitle: album.artists.first?.name ?? "",
            imageURL: URL(string: album.images.first?.url ?? ""))
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let album = albums[indexPath.row]
        
        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
}
