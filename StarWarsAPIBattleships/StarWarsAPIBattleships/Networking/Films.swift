//
//  Films.swift
//  StarWarsAPIBattleships
//
//  Created by Jonathan Shoemaker on 7/27/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//
//https://swapi.dev/api/films/

import Foundation
//6 This struct denotes a collection of films. As you previously saw in the console, the endpoint swapi.dev/api/films returns four main values: count, next, previous and results. For your app, you only need count and results, which is why your struct doesn’t have all properties.
struct Films: Decodable {
    let count: Int
    let all: [Film]
    
//7 The coding keys transform results from the server into all. This is because Films.results doesn’t read as nicely as Films.all. Again, by conforming the data model to Decodable, Alamofire will be able to convert the JSON data into your data model.
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}
