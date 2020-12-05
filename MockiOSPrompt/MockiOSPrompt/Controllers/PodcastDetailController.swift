//
//  PodcastDetailController.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/4/20.
//

import UIKit

class PodcastDetailController: UIViewController {
    
    @IBOutlet var podcastImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    public var podcast: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    private func updateUI() {
        guard let imageURL = URL(string: podcast?.artworkUrl600 ?? ""), let data = try? Data(contentsOf: imageURL) else {
            return
        }
        
        let image = UIImage(data: data)
                
        podcastImageView.image = image
        titleLabel.text = podcast?.collectionName
    }
    
    @IBAction func goToCVVC(_ sender: UIButton) {
        
        let cvVC = CVViewController()
        navigationController?.pushViewController(cvVC, animated: true)
    }
    
}
