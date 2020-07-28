//
//  Film.swift
//  StarWarsAPIBattleships
//
//  Created by Jonathan Shoemaker on 7/27/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//
//https://swapi.dev/api/films/
//

import Foundation
//4 With this code, you’ve created the data properties and coding keys you need to pull data from the API’s film endpoint. Note how the struct is Decodable, which makes it possible to turn JSON into the data model.
struct Film: Decodable {
    let id: Int
    let title: String
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let starships: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case starships
    }
}

//5 The project defines a protocol — Displayable — to simplify showing detailed information later in the tutorial. You must make Film conform to it. This extension allows the detailed information display’s view controller to get the correct labels and values for a film from the model itself
extension Film: Displayable {
    var titleLabelText: String {
        title
    }
    var subtitleLabelText: String {
        "Episode \(String(id))"
    }
    var item1: (label: String, value: String) {
        ("DIRECTOR", director)
    }
    var item2: (label: String, value: String) {
        ("PRODUCER", producer)
    }
    var item3: (label: String, value: String) {
        ("RELEASE DATE", releaseDate)
    }
    var listTitle: String {
        "STARSHIPS"
    }
    var listItems: [String] {
        starships
    }
}
