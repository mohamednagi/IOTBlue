//
//  BookMarksController.swift
//  IotBlue
//
//  Created by Sierra on 6/20/19.
//  Copyright © 2019 Nagiz. All rights reserved.
//

import UIKit
import CoreData

class BookMarksController: NSObject {

   var bookMarksView = BookMarksView()
    

    func FetchFromCoreData (){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        request.returnsObjectsAsFaults = false
        do{
            bookMarksView.bookMarks = try Context.fetch(request) as! [Locations]
        }catch{
            print("Error")
        }
        bookMarksView.tableView.reloadData()
    }
    
    func updateModel(at indexPath:IndexPath){
        Context.delete(bookMarksView.bookMarks[indexPath.row])
        bookMarksView.bookMarks.remove(at: indexPath.row)
        do{
            try Context.save()
        }catch{
            print("error deleting row \(error)")
        }
    }
}
