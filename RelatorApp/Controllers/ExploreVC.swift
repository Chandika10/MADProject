//
//  ExploreVC.swift
//  RelatorApp
//
//  Created by Chandika Karanam on 11/2/23.
//

import UIKit

class ExploreVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var Numguests: UITextField!
    @IBOutlet weak var datefield: UITextField!
    @IBOutlet weak var Propertysearchbar: UISearchBar!
   
    
    @IBOutlet weak var ExploreCollectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
// add delegate
        
        Numguests.delegate = self
        Numguests.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Numguests.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! ExploreCell
        return cell1
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
