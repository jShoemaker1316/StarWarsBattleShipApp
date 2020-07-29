//
//  Starship.swift
//  StarWarsAPIBattleships
//
//  Created by Jonathan Shoemaker on 7/29/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//

import Foundation
//18 Before fetching any starships, you first need a new data model to handle the starship data. Your next step is to create one. In the Networking group, add a new Swift file. Name it Starship.swift and add the following code. As with the other data models, you simply list all the response data you want to use, along with any relevant coding keys.
struct Starship: Decodable {
  var name: String
  var model: String
  var manufacturer: String
  var cost: String
  var length: String
  var maximumSpeed: String
  var crewTotal: String
  var passengerTotal: String
  var cargoCapacity: String
  var consumables: String
  var hyperdriveRating: String
  var starshipClass: String
  var films: [String]
  
  enum CodingKeys: String, CodingKey {
    case name
    case model
    case manufacturer
    case cost = "cost_in_credits"
    case length
    case maximumSpeed = "max_atmosphering_speed"
    case crewTotal = "crew"
    case passengerTotal = "passengers"
    case cargoCapacity = "cargo_capacity"
    case consumables
    case hyperdriveRating = "hyperdrive_rating"
    case starshipClass = "starship_class"
    case films
  }
}

//19 You also want to be able to display information about individual ships, so Starship must conform to Displayable. Add the following at the end of the file. Just like you did with Film before, this extension allows DetailViewController to get the correct labels and values from the model itself

extension Starship: Displayable {
  var titleLabelText: String {
    name
  }
  
  var subtitleLabelText: String {
    model
  }
  
  var item1: (label: String, value: String) {
    ("MANUFACTURER", manufacturer)
  }
  
  var item2: (label: String, value: String) {
    ("CLASS", starshipClass)
  }
  
  var item3: (label: String, value: String) {
    ("HYPERDRIVE RATING", hyperdriveRating)
  }
  
  var listTitle: String {
    "FILMS"
  }
  
  var listItems: [String] {
    films
  }
}
