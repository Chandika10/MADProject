//
//  FavoriteVC.swift
//  RelatorApp
//
//  Created by Pavan Pullugundla on 11/2/23.
//

import UIKit
import Alamofire
import MBProgressHUD

class FavoriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var favtableview: UITableView!
    
    
    
    var favoriteItems: [SearchStruct.searchdata] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFavoriteItems()
        favtableview.reloadData()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchFavoriteItems()
        favtableview.reloadData()
    }
    override func viewDidDisappear(_ animated: Bool) {
        fetchFavoriteItems()
        favtableview.reloadData()
    }
    
    func fetchFavoriteItems() {
        if let storedItems = UserDefaults.standard.array(forKey: "FavoriteItems") as? [[String: Any]] {
            // Convert each dictionary back to SearchStruct.searchdata
            favoriteItems = storedItems.compactMap { dict in
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: dict)
                    let decodedItem = try JSONDecoder().decode(SearchStruct.searchdata.self, from: jsonData)
                    print("Decoded Item: \(decodedItem)")
                    return decodedItem
                } catch {
                    print("Error decoding JSON: \(error)")
                    return nil
                }
            }

            favtableview.reloadData()
            print("Fetched Favorite Items: \(favoriteItems)")
        }
    }
    
    
    
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "favcell", for: indexPath) as! favcell
        
        let item = favoriteItems[indexPath.item]
        cell1.favhoteltitles.text = item.title
        cell1.favhotelprice.text = item.price
        cell1.favhotelrating.text = item.avgRatingLocalized
        cell1.favhoteltype.text = item.roomType
        cell1.favhoteladdress.text = item.publicAddress
        
        return cell1
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//           // deleteItemAtIndexPath(indexPath)
//            if var storedItems = UserDefaults.standard.array(forKey: "FavoriteItems") as? [[String: Any]] {
//
//                storedItems.remove(at: indexPath.row)
//                UserDefaults.standard.set(favoriteItems, forKey: "FavoriteItems")
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//
//        }
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if var storedItems = UserDefaults.standard.array(forKey: "FavoriteItems") as? [[String: Any]] {
                storedItems.remove(at: indexPath.row)
                UserDefaults.standard.set(storedItems, forKey: "FavoriteItems")
                favoriteItems = storedItems.compactMap { dict in
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: dict)
                        let decodedItem = try JSONDecoder().decode(SearchStruct.searchdata.self, from: jsonData)
                        print("Decoded Item: \(decodedItem)")
                        return decodedItem
                    } catch {
                        print("Error decoding JSON: \(error)")
                        return nil
                    }
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    
    

    private func deleteItemAtIndexPath(_ indexPath: IndexPath) {
        // Retrieve the array of stored items from UserDefaults
        if var storedItems = UserDefaults.standard.array(forKey: "FavoriteItems") as? [[String: Any]] {
            
            // Remove the item at the selected indexPath
            storedItems.remove(at: indexPath.row)

            // Update UserDefaults with the modified array
            UserDefaults.standard.set(storedItems, forKey: "FavoriteItems")

            // Animate the row deletion
            favtableview.deleteRows(at: [indexPath], with: .automatic)
        }
    }


   
    
    
}

