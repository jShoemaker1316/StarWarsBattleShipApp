//
//  ViewController.swift
//  StarWarsAPIBattleships
//
//  Created by Jonathan Shoemaker on 7/25/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return indexPath
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationVC = segue.destination as? DetailViewController else {
      return
    }
    destinationVC.data = nil
  }
}

// MARK: - UISearchBarDelegate
extension MainTableViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
  }
}

