//
//  ViewController.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/3/20.
//

import UIKit

class PodcastsTVController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var apiClient = APIClient()
    
    var searchString = ""
    
    var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
    }

    private func getPodcasts(_ search: String) {
        apiClient.fetchPodcasts(search: search) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let podcasts):
                DispatchQueue.main.async {
                    self?.podcasts = podcasts
                }
            }
        }
    }

}

extension PodcastsTVController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
            fatalError("could not dequeue")
        }
        let podcast = podcasts[indexPath.row]
        cell.configCell(podcast)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

extension PodcastsTVController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        getPodcasts(searchString)
    }
}
