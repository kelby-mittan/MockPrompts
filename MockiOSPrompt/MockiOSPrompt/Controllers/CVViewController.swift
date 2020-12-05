//
//  CVViewController.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/4/20.
//

import UIKit

class CVViewController: UIViewController {

    let cvVC = CVView()
    
    override func loadView() {
        view = cvVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cvVC.collectionView.dataSource = self
        cvVC.collectionView.delegate = self
        cvVC.backgroundColor = .systemBackground
    }
    

}


extension CVViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        return cell
    }
}
