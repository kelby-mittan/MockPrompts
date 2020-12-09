//
//  DIViewController.swift
//  MockiOSPrompt
//
//  Created by Kelby Mittan on 12/8/20.
//

import UIKit

class DIViewController: UIViewController {
    
    let podcast: Podcast

    @IBOutlet var titleLabel: UILabel!
    
    init?(coder: NSCoder, podcast: Podcast) {
        self.podcast = podcast
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = podcast.collectionName
    }
    


}
