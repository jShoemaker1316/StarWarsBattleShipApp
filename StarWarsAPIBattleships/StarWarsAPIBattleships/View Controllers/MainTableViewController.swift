//
//  ViewController.swift
//  StarWarsAPIBattleships
//
//  Created by Jonathan Shoemaker on 7/25/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//

import UIKit
import Alamofire

class MainTableViewController: UITableViewController {
  @IBOutlet weak var searchBar: UISearchBar!
    
//10 add our var items
    var items: [Displayable] = []
//15 register the selected item. You’ll store the currently-selected film to this property
    var selectedItem: Displayable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    //3 add the extended func
    fetchFilms()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //13 To get the table view to show the content, you must make some further changes. Replace the code in tableView(_:numberOfRowsInSection:) with:
    //return 0
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
//14 Next, in tableView(_:cellForRowAt:) right below the declaration of cell, add the following lines after this let cell
    let item = items[indexPath.row]
    cell.textLabel?.text = item.titleLabelText
    cell.detailTextLabel?.text = item.subtitleLabelText
    return cell
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//16 Now, replace the code in tableView(_:willSelectRowAt:) Here, you’re taking the film from the selected row and saving it to selectedItem.
    //return indexPath
    selectedItem = items[indexPath.row]
    return indexPath
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationVC = segue.destination as? DetailViewController else {
      return
    }
//17 Now, in prepare(for:sender:), replace the nil statement. This sets the user’s selection as the data to display.
    //destinationVC.data = nil
    destinationVC.data = selectedItem
  }
}

// MARK: - UISearchBarDelegate
extension MainTableViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
  }
}

extension MainTableViewController {
    func fetchFilms() {
//9 Alamofire uses method chaining, which works by connecting the response of one method as the input of another. This not only keeps the code compact, but it also makes your code clearer. Give it a try now by replacing all of the code. This single line not only does exactly what took multiple lines to do before, but you also added validation. From top to bottom, you request the endpoint, validate the response by ensuring the response returned an HTTP status code in the range 200–299 and decode the response into your data model. Nice! :]
        
        AF.request("https://swapi.dev/api/films")
        .validate()
        .responseDecodable(of: Films.self) { (response) in
          guard let films = response.value else { return }
//11 replace print with self items and reload data. This assigns all retrieved films to items and reloads the table view.
          //print(films.all[0].title)
            self.items = films.all
            self.tableView.reloadData()
        }
        
        //1 Alamofire uses namespacing, so you need to prefix all calls that you use with AF. request(_:method:parameters:encoding:headers:interceptor:) accepts the endpoint for your data. It can accept more parameters, but for now, you’ll just send the URL as a string and use the default parameter values.
        //let request = AF.request("https://swapi.dev/api/films")
        //2 Take the response given from the request as JSON. For now, you simply print the JSON data for debugging purposes.
        //request.responseJSON { (data) in
            //print(data)
        
//8 Now, rather than converting the response into JSON, you’ll convert it into your internal data model, Films. For debugging purposes, you print the title of the first film retrieved. Build and run. In the Xcode console, you’ll see the name of the first film in the array. Your next task is to display the full list of movies.
        //request.responseDecodable(of: Films.self) { (response) in
            //guard let films = response.value else { return }
            //print(films.all[0].title)
        //}
    }
}

