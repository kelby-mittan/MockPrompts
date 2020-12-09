//
//  DetViewController.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/8/20.
//

import UIKit

class DetViewController: UIViewController {

    let detView = DetView()
    
    override func loadView() {
        view = detView
    }
    
    let podcast: Podcast
    
    init(podcast: Podcast) {
        self.podcast = podcast
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detView.backgroundColor = .systemBackground
        detView.titleLabel.text = podcast.artistName
    }
    
    

}

class DetView: UIView {
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    public lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "")
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupLabel()
    }
    
    private func setupLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
