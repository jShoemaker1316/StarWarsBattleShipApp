//
//  DetailViewController.swift
//  StarWarsAPIBattleships
//
//  Created by Jonathan Shoemaker on 7/26/20.
//  Copyright © 2020 JonathanShoemaker. All rights reserved.
//

import Foundation
import UIKit
//20 To fetch the starship data, you’ll need a new networking call. Open DetailViewController.swift and add the following import statement to the top:
import Alamofire

class DetailViewController: UIViewController {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var item1TitleLabel: UILabel!
  @IBOutlet weak var item1Label: UILabel!
  @IBOutlet weak var item2TitleLabel: UILabel!
  @IBOutlet weak var item2Label: UILabel!
  @IBOutlet weak var item3TitleLabel: UILabel!
  @IBOutlet weak var item3Label: UILabel!
  @IBOutlet weak var listTitleLabel: UILabel!
  @IBOutlet weak var listTableView: UITableView!
  
  var data: Displayable?
  var listData: [Displayable] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    commonInit()
    
    listTableView.dataSource = self
//24 Finally, add the fetchList() at the end of viewDidLoad()
    fetchList()
  }
  
  private func commonInit() {
    guard let data = data else { return }
    
    titleLabel.text = data.titleLabelText
    subtitleLabel.text = data.subtitleLabelText
    
    item1TitleLabel.text = data.item1.label
    item1Label.text = data.item1.value
    
    item2TitleLabel.text = data.item2.label
    item2Label.text = data.item2.value
    
    item3TitleLabel.text = data.item3.label
    item3Label.text = data.item3.value
    
    listTitleLabel.text = data.listTitle
  }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
//23 In tableView(_:cellForRowAt:), add the following before return cell. This code sets the cell’s textLabel with the appropriate title from your list data.
    cell.textLabel?.text = listData[indexPath.row].titleLabelText
    return cell
  }
}
//21 Then at the bottom of the file, add this extension.1-6 are the notes associated with this large step.

extension DetailViewController {
  // 1You may have noticed that Starship contains a list of films, which you’ll want to display. Since both Film and Starship are Displayable, you can write a generic helper to perform the network request. It needs only to know the type of item its fetching so it can properly decode the result.
  private func fetch<T: Decodable & Displayable>(_ list: [String], of: T.Type) {
    var items: [T] = []
    // 2You need to make multiple calls, one per list item, and these calls will be asynchronous and may return out of order. To handle them, you use a dispatch group so you’re notified when all the calls have completed.
    let fetchGroup = DispatchGroup()
    
    // 3Loop through each item in the list.
    list.forEach { (url) in
      // 4inform the dispatch group that you are entering.
      fetchGroup.enter()
      // 5make an Alamofire request to the starship endpoint, validate the response, and decode the response into an item of the appropriate type.
      AF.request(url).validate().responseDecodable(of: T.self) { (response) in
        if let value = response.value {
          items.append(value)
        }
        // 6in the request’s completion handler, inform the dispatch group that you’re leaving.
        fetchGroup.leave()
      }
    }
        // 7once the dispatch group has received a leave() for each enter(), you ensure you’re running on the main queue, save the list to listData and reload the list table view.
    fetchGroup.notify(queue: .main) {
      self.listData = items
      self.listTableView.reloadData()
    }
  }
//22 Now that you have your helper built, you need to actually fetch the list of starships from a film. Add the following inside your extension:
    func fetchList() {
      // 1Since data is optional, ensure it’s not nil before doing anything else.
      guard let data = data else { return }
      
      // 2Use the type of data to decide how to invoke your helper method.
      switch data {
      // 3If the data is a Film, the associated list is of starships.
      case is Film:
        fetch(data.listItems, of: Starship.self)
//31 Open DetailViewController.swift and find fetchList(). Right now, it only knows how to fetch the list associated with a film. You need to fetch the list for a starship. Add the following just before the default: label in the switch statement. This tells your generic helper to fetch a list of films for a given starship.
        case is Starship:
        fetch(data.listItems, of: Film.self)
      default:
        print("Unknown type: ", String(describing: type(of: data)))
      }
    }
    
    
}
