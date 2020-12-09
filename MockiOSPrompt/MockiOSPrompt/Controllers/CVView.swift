//
//  CVView.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/4/20.
//

import UIKit

class CVView: UIView {
    
    public lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundColor = .gray
        return sb
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 120, height: 120)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .systemTeal
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
        setupSBConstraints()
        setupCVConstraints()
    }
    
    private func setupSBConstraints() {
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }
    
    private func setupCVConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
}

protocol AnimateDelegate {
    func onLongPressedCell(index: Int, cell: CustomCell)
}

class CustomCell: UICollectionViewCell {
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo.fill")
        iv.isUserInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ivLongpressed(longPressRec:)))
        iv.addGestureRecognizer(longPress)
        return iv
    }()
    
    var animateDelegate: AnimateDelegate?
    var indexPath: IndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupIV()
        
    }
    
    private func setupIV() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    public func configCell(_ podcast: Podcast) {
        
        guard let imageURL = URL(string: podcast.artworkUrl100 ?? "") else {
            return
        }
        do {
            let data2 = try Data(contentsOf: imageURL)
            let image2 = UIImage(data: data2)
            imageView.image = image2
        } catch {
            print(error.localizedDescription)
        }
        
//        let image = UIImage(data: data)
//
//        imageView.image = image
    }
    
    @objc
    func ivLongpressed(longPressRec: UILongPressGestureRecognizer) {
        animateDelegate?.onLongPressedCell(index: indexPath?.row ?? 0, cell: self)
    }
}
