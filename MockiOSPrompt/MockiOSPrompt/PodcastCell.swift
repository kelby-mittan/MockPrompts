//
//  PodcastCell.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/4/20.
//

import UIKit

class PodcastCell: UITableViewCell {

    @IBOutlet var podcastImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    public func configCell(_ podcast: Podcast) {

        guard let imageURL = URL(string: podcast.artworkUrl100 ?? ""), let data = try? Data(contentsOf: imageURL) else {
            return
        }
        
        let image = UIImage(data: data)
        
        podcastImageView.image = image
        titleLabel.text = podcast.collectionName
        descriptionLabel.text = podcast.artistName
    }
}
