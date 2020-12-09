//
//  MockiOSPromptTests.swift
//  MockiOSPromptTests
//
//  Created by Kelby Mittan on 12/3/20.
//

import XCTest
@testable import MockiOSPrompt

class MockiOSPromptTests: XCTestCase {

    func testPodcasts() {
        
        let apiClient = APIClient()
        
        let expected = "Swift by Sundell"
        apiClient.fetchPodcasts(search: "Swift") { (result) in
            switch result {
            case .failure(let error):
                XCTFail("Failed Test \(error)")
            case .success(let podcasts):
                let swiftPodcastTitle = podcasts[4].collectionName
                XCTAssertEqual(expected, swiftPodcastTitle, "not equal \(swiftPodcastTitle ?? "N/A")")
            }
        }
    }

}
