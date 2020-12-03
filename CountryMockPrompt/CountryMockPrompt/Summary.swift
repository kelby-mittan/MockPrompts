//
//  Summary.swift
//  CountryMockPrompt
//
//  Created by Kelby Mittan on 12/3/20.
//

import Foundation

/*
         "Country": "Afghanistan",
         "CountryCode": "AF",
         "Slug": "afghanistan",
         "NewConfirmed": 263,
         "TotalConfirmed": 46980,
         "NewDeaths": 25,
         "TotalDeaths": 1822,
         "NewRecovered": 119,
         "TotalRecovered": 37026,
         "Date": "2020-12-03T11:01:39Z",
 */

struct Summary: Decodable {
    let country: String
    let newConfirmed: Int
    let totalRecovered: Int
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case newConfirmed = "NewConfirmed"
        case totalRecovered = "TotalRecovered"
    }
}

struct SummaryWrapper: Decodable {
    let countries: [Summary]
    
    enum CodingKeys: String, CodingKey {
        case countries = "Countries"
    }
}
