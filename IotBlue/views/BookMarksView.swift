//
//  BookMarksView.swift
//  IotBlue
//
//  Created by Sierra on 6/19/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit

class BookMarksView: UITableViewController, SwipeTableViewCellDelegate {
    
    var bookMarks = [Locations]()
    var bookMarksController: BookMarksController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookMarksController.FetchFromCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookMarksController = BookMarksController()
        bookMarksController.bookMarksView = self
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookMarks.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = bookMarks[indexPath.row].title
        return cell
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.bookMarksController.updateModel(at: indexPath)
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsView = storyboard.instantiateViewController(withIdentifier: "DetailsView") as? DetailsView else {return}
        detailsView.recievedObject = bookMarks[indexPath.row]
        self.navigationController?.pushViewController(detailsView, animated: true)
    }
}
