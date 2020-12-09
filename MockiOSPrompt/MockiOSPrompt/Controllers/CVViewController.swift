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
        cvVC.collectionView.isPagingEnabled = true
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
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: cvVC.collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = .green
        let podcast = podcasts[indexPath.row]
        cell.configCell(podcast)
        cell.animateDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcast = podcasts[indexPath.row]
        let detVC = DetViewController(podcast: podcast)
        navigationController?.pushViewController(detVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let verticalSpace = view.frame.height / 5
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension CVViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}

extension CVViewController: AnimateDelegate {
   
    func onLongPressedCell(index: Int, cell: CustomCell) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseIn,.repeat,.autoreverse], animations: {
            cell.imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            cell.imageView.transform = CGAffineTransform(translationX: 30, y: 0)
            cell.layoutSubviews()
        } , completion: { _ in
//            let pCast = self.podcasts[index]
//            let detVC = DetViewController(podcast: pCast)
//            self.navigationController?.pushViewController(detVC, animated: true)
        })

    }
    
    
}
