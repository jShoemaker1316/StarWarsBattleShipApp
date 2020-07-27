//
//  Displayable.swift
//  StarWarsAPIBattleships
//
//  Created by Jonathan Shoemaker on 7/26/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//

import Foundation

protocol Displayable {
  var titleLabelText: String { get }
  var subtitleLabelText: String { get }
  var item1: (label: String, value: String) { get }
  var item2: (label: String, value: String) { get }
  var item3: (label: String, value: String) { get }
  var listTitle: String { get }
  var listItems: [String] { get }
}
