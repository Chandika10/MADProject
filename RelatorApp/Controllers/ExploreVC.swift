//
//  ExploreVC.swift
//  RelatorApp
//
//  Created by Pavan Pullugundla on 11/2/23.
//

import UIKit
import Alamofire
import MBProgressHUD
class ExploreVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate , SecondViewControllerDelegate{
    
   
    private var Rent_data : [SearchStruct.searchdata]?
    private var locationdata : [SearchStruct.searchdata.Location]?
   
    
    
    @IBAction func openSecondPageButtonTapped(_ sender: UIButton) {
            let secondVC = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
            secondVC.delegate = self
            present(secondVC, animated: true, completion: nil)
        }

    
    var filteredData: [String] = ["2", "2", "1", "1", "2023-11-0", "2023-11-06", "150", "1000", "1", "2", "1", "Hotel","ChIJ7cv00DwsDogRAMDACa2m4K8"]
  
    func didSaveData(data: [String]) {
            filteredData = data
        print("filteredData after: \(filteredData)")
            SearchAPI()
       }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Rent_data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! ExploreCell
        if let imageUrlString = self.Rent_data?[indexPath.row].images?[0] {
            loadImageFromURL(imageUrlString, into: cell1.hotelimage)
            cell1.hotelimage.contentMode = .scaleAspectFill
            cell1.hotelimage.clipsToBounds = true
            cell1.hotelimage.layer.cornerRadius = 10
                cell1.hotelimage.layer.masksToBounds = true
        }
        cell1.hotelprice.text = self.Rent_data?[indexPath.row].price!
        cell1.hoteltitle.text = self.Rent_data?[indexPath.row].title!
        cell1.hotelrating.text = self.Rent_data?[indexPath.row].avgRatingLocalized ?? "4.0"
        cell1.hoteladdress.text = self.Rent_data?[indexPath.row].publicAddress!
        cell1.hoteltype.text = self.Rent_data?[indexPath.row].roomType!
      

        return cell1
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DetailedController = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        DetailedController.titlevar = (self.Rent_data?[indexPath.row].title)!
        DetailedController.pricevar = (self.Rent_data?[indexPath.row].price)!
        DetailedController.ratingvar = (self.Rent_data?[indexPath.row].avgRatingLocalized)!
        DetailedController.locationvar = (self.Rent_data?[indexPath.row].publicAddress)!
        DetailedController.hometypevar = (self.Rent_data?[indexPath.row].roomType)!
        DetailedController.imgvar = (self.Rent_data?[indexPath.row].images?[0])!
        
        
        DetailedController.northlat = Int((self.Rent_data?[indexPath.row].location?.mapBoundsHint?.northeast?.latitude)!)
        DetailedController.northlong = Int((self.Rent_data?[indexPath.row].location?.mapBoundsHint?.northeast?.longitude)!)
        DetailedController.southlat = Int((self.Rent_data?[indexPath.row].location?.mapBoundsHint?.southwest?.latitude)!)
        DetailedController.southlong = Int((self.Rent_data?[indexPath.row].location?.mapBoundsHint?.southwest?.longitude)!)
        
        
        
        
        self.navigationController?.pushViewController(DetailedController, animated: false)
    }
  

        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // Adjust the width and height as needed
            let width: CGFloat = 450.0
            let height: CGFloat = 280.0
            return CGSize(width: width, height: height)
        }
    
    
    func loadImageFromURL(_ urlString: String, into imageView: UIImageView) {
           // Check if the URL string is valid
           guard let url = URL(string: urlString) else {
               print("Invalid URL: \(urlString)")
               return
           }

           // Create a URLSession data task to download the image
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error {
                   print("Error downloading image: \(error.localizedDescription)")
                   return
               }

               // Check if data is not nil and can be converted to a UIImage
               if let data = data, let image = UIImage(data: data) {
                   // Update the UI on the main thread
                   DispatchQueue.main.async {
                       imageView.image = image
                   }
               } else {
                   print("Invalid data or unable to convert to UIImage")
               }
           }.resume()
       }
    
    
    
    @IBOutlet weak var ExploreCollectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("filteredData before: \(filteredData)")
        SearchAPI()
    }
    
   
    
    
    private func SearchAPI()
    {
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = "Loading..."
        
        let headers: HTTPHeaders = [
            "X-RapidAPI-Key": "d9d575e88dmshe9b62abdb3a8e48p1c40edjsnd4cd18808268",
            "X-RapidAPI-Host": "airbnb19.p.rapidapi.com"
        ]
        print("0",filteredData[0])
        print("1",filteredData[1])
        print("2",filteredData[2])
        print("3",filteredData[3])
        print("4",filteredData[4])
        print("5",filteredData[5])
        print("6",filteredData[6])
        print("7",filteredData[7])
        print("8",filteredData[8])
        print("9",filteredData[9])
        print("10",filteredData[10])
        print("11",filteredData[11])
        print("12",filteredData[12])
        let api = "https://airbnb19.p.rapidapi.com/api/v1/searchPropertyByPlace"
        let parameters: [String: Any] = ["id": filteredData[12] ,"totalRecords": "20", "adults": filteredData[0] , "children": filteredData[1], "infants": filteredData[2] ,"pets" :filteredData[3],"checkin": filteredData[4] , "checkout":filteredData[5] , "priceMin": filteredData[6],"priceMax": filteredData[7], "minBedrooms":filteredData[8], "minBeds":filteredData[9], "minBathrooms":filteredData[10],"property_type": filteredData[11]]
        
        Alamofire.request(api, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                // Handle success response
                if let jsonArray = value as? [String: Any] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: jsonArray)
                        let objects = try JSONDecoder().decode(SearchStruct.self, from: jsonData)
                        print("Objects: \(objects)")
                        
                        self.Rent_data = objects.data
                        
                        
                        print("Rent_data",self.Rent_data!)
                        self.ExploreCollectionview.reloadData()
                        progressHUD.hide(animated: true)
                        
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }

            case .failure(let error):
                // Handle error response
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
    
    


}
