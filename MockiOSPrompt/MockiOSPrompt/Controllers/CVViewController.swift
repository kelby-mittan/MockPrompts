//
//  CVViewController.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/4/20.
//

import UIKit
import Combine

class CVViewController: UIViewController {
    
    let cvVC = CVView()
    
    @Published private var searchText = ""
    
    private var subscriptions: Set<AnyCancellable> = []
    
    var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.cvVC.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = cvVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvVC.collectionView.dataSource = self
        cvVC.collectionView.delegate = self
        cvVC.backgroundColor = .systemBackground
        cvVC.searchBar.delegate = self
        $searchText
            .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] (text) in
                self?.searchForPodcasts(for: text)
            }
            .store(in: &subscriptions)
    }
    
    private func searchForPodcasts(for query: String) {
        
        APIClient().searchForPodcasts(for: query)
            .sink(receiveCompletion: { (completion) in
                print(completion)
            }) { [weak self] (podcasts) in
                self?.podcasts = podcasts
            }
            .store(in: &subscriptions)
    }
    
}


extension CVViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/1.25, height: collectionView.frame.width/2.25)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = .green
        let podcast = podcasts[indexPath.row]
        cell.configCell(podcast)
        return cell
    }
}

extension CVViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}
