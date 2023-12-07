//
//  DetailVC.swift
//  RelatorApp
//
//  Created by Murali Krishna Vadlamudi on 12/7/23.
//

import UIKit
import MapKit
import CoreLocation
class DetailVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titletxt: UILabel!
    @IBOutlet weak var locationtxt: UILabel!
    @IBOutlet weak var ratingtxt: UILabel!
    @IBOutlet weak var PRICEtxt: UILabel!
    @IBOutlet weak var hometypetxt: UILabel!
    
    
    
    @IBOutlet weak var mapview: MKMapView!
    
    
    public var titlevar: String = ""
    public var pricevar: String = ""
    public var locationvar: String = ""
    public var ratingvar: String = ""
    public var hometypevar: String = ""
   
    public var imgvar: String = ""
    
    public var northlat: Int = 0
    public var northlong: Int = 0
    public var southlat: Int = 0
    public var southlong: Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("title\(titlevar)")
        print("locationvar\(locationvar)")
        print("ratingvar\(ratingvar)")
        print("hometypevar\(hometypevar)")
        print("priceval\(pricevar)")
        print("imgvar\(imgvar)")
        print("northlat\(northlat)")
        print("northlong\(northlong)")
        print("southlat\(southlat)")
        print("southlong\(southlong)")
        
        
        titletxt.text = titlevar
        locationtxt.text = locationvar
        ratingtxt.text = ratingvar
        hometypetxt.text = hometypevar
        PRICEtxt.text = pricevar
        
        
        
         let imageUrlString = imgvar
    loadImageFromURL(imageUrlString, into: img)
        
        let centerCoordinate = CLLocationCoordinate2D(
            latitude: CLLocationDegrees((northlat + southlat) / 2),
            longitude: CLLocationDegrees((northlong + southlong) / 2)
                    )
        
        let span = MKCoordinateSpan(
            latitudeDelta: Double(abs(northlat - southlat)) * 1.5,
            longitudeDelta: Double(abs(northlong - southlong)) * 1.5
                    )

                    let region = MKCoordinateRegion(center: centerCoordinate, span: span)
                    mapview.setRegion(region, animated: true)

                    let annotation = MKPointAnnotation()
                    annotation.coordinate = centerCoordinate
                    mapview.addAnnotation(annotation)
                
            
    
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
    
    let defaults = UserDefaults.standard
    
    @IBAction func Addtofav(_ sender: Any)
    {
        
        let newItem = SearchStruct.searchdata(price: pricevar,
                                              publicAddress: locationvar ,
                                              city: "",
                                              title: titlevar ,
                                              avgRatingLocalized: ratingvar,
                                              roomType: hometypevar,
                                              spaceType : "",
                                              images: [],
                                              location: nil
                                          
        )
        
        // Convert the new item to a dictionary
            if let newItemDict = try? newItem.asDictionary() {
                var favoriteItems = UserDefaults.standard.array(forKey: "FavoriteItems") as? [[String: Any]] ?? []

                // Append the new item dictionary to the array
                favoriteItems.append(newItemDict)

                // Save the updated array back to UserDefaults
                UserDefaults.standard.set(favoriteItems, forKey: "FavoriteItems")
                print("FavoriteItems", favoriteItems)
                let alertController = UIAlertController(title: "Alert", message: "You added succesfully in wishlist", preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alertController.addAction(okAction)
                   present(alertController, animated: true, completion: nil)
            }
       
    }
  
    

}
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dictionary ?? [:]
    }
}
import UIKit
import MapKit
import CoreLocation
class DetailVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titletxt: UILabel!
    @IBOutlet weak var locationtxt: UILabel!
    @IBOutlet weak var ratingtxt: UILabel!
    @IBOutlet weak var PRICEtxt: UILabel!
    @IBOutlet weak var hometypetxt: UILabel!
    
    
    
    @IBOutlet weak var mapview: MKMapView!
    
    
    public var titlevar: String = ""
    public var pricevar: String = ""
    public var locationvar: String = ""
    public var ratingvar: String = ""
    public var hometypevar: String = ""
   
    public var imgvar: String = ""
    
    public var northlat: Int = 0
    public var northlong: Int = 0
    public var southlat: Int = 0
    public var southlong: Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("title\(titlevar)")
        print("locationvar\(locationvar)")
        print("ratingvar\(ratingvar)")
        print("hometypevar\(hometypevar)")
        print("priceval\(pricevar)")
        print("imgvar\(imgvar)")
        print("northlat\(northlat)")
        print("northlong\(northlong)")
        print("southlat\(southlat)")
        print("southlong\(southlong)")
        
        
        titletxt.text = titlevar
        locationtxt.text = locationvar
        ratingtxt.text = ratingvar
        hometypetxt.text = hometypevar
        PRICEtxt.text = pricevar
        
        
        
         let imageUrlString = imgvar
    loadImageFromURL(imageUrlString, into: img)
        
        let centerCoordinate = CLLocationCoordinate2D(
            latitude: CLLocationDegrees((northlat + southlat) / 2),
            longitude: CLLocationDegrees((northlong + southlong) / 2)
                    )
        
        let span = MKCoordinateSpan(
            latitudeDelta: Double(abs(northlat - southlat)) * 1.5,
            longitudeDelta: Double(abs(northlong - southlong)) * 1.5
                    )

                    let region = MKCoordinateRegion(center: centerCoordinate, span: span)
                    mapview.setRegion(region, animated: true)

                    let annotation = MKPointAnnotation()
                    annotation.coordinate = centerCoordinate
                    mapview.addAnnotation(annotation)
                
            
    
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
    
    let defaults = UserDefaults.standard
    
    @IBAction func Addtofav(_ sender: Any)
    {
        
        let newItem = SearchStruct.searchdata(price: pricevar,
                                              publicAddress: locationvar ,
                                              city: "",
                                              title: titlevar ,
                                              avgRatingLocalized: ratingvar,
                                              roomType: hometypevar,
                                              spaceType : "",
                                              images: [],
                                              location: nil
                                          
        )
        
        // Convert the new item to a dictionary
            if let newItemDict = try? newItem.asDictionary() {
                var favoriteItems = UserDefaults.standard.array(forKey: "FavoriteItems") as? [[String: Any]] ?? []

                // Append the new item dictionary to the array
                favoriteItems.append(newItemDict)

                // Save the updated array back to UserDefaults
                UserDefaults.standard.set(favoriteItems, forKey: "FavoriteItems")
                print("FavoriteItems", favoriteItems)
                let alertController = UIAlertController(title: "Alert", message: "You added succesfully in wishlist", preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alertController.addAction(okAction)
                   present(alertController, animated: true, completion: nil)
            }
       
    }
  
    

}
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dictionary ?? [:]
    }
}

