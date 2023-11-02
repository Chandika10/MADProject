//
//  MapViewController.swift
//  RelatorApp
//
//  Created by Chandika Karanam on 11/2/23.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

   
    @IBOutlet weak var mapview: MKMapView!
    
    
    var city : String? = "Delhi"
    var annotation : MKPointAnnotation!
    
    func annotation(coordinate : CLLocationCoordinate2D, title: String!, subtitle : String!)
    {
        annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Initialize a geocoder
               let geocoder = CLGeocoder()

               // Geocode the city name to get its coordinates
               geocoder.geocodeAddressString(city ?? "") { (placemarks, error) in
                   if let error = error {
                       print("Geocoding error: \(error.localizedDescription)")
                   } else if let placemark = placemarks?.first {
                 
                       let coordinate = placemark.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                       let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                       self.mapview.setRegion(region, animated: true)

                       let annotation = MKPointAnnotation()
                       annotation.coordinate = coordinate
                       annotation.title = self.city
                       self.mapview.addAnnotation(annotation)
                   }
               }
           }

}
