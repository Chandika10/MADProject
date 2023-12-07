//
//  FilterVC.swift
//  RelatorApp
//
//  Created by Pavan Pullugundla on 12/7/23.
//

import UIKit
import FSCalendar
import Alamofire
import MBProgressHUD

protocol SecondViewControllerDelegate: AnyObject {
    func didSaveData(data: [String])
}


class FilterVC: UIViewController, UITextFieldDelegate, FSCalendarDataSource, FSCalendarDelegate {
    
    weak var delegate: SecondViewControllerDelegate?
    
    var text13 = ""
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Assuming you want to pass a string, modify as needed
        print("Save button tapped")
        
        let text1 = Numadults.text ?? ""
        let text2 = Numchild.text ?? ""
        let text3 = Numinfants.text ?? ""
        let text4 = Numpets.text ?? ""
        let text5 = checkindate.text ?? ""
        let text6 = checkoutdate.text ?? ""
        let text7 = pricemin.text ?? ""
        let text8 = pricemax.text ?? ""
        let text9 = minbeds.text ?? ""
        let text10 = minbedrooms.text ?? ""
        let text11 = minvathroom.text ?? ""
        let text12 = propertytype
        
        GetplaceId {

                    print("text13 in saveButtonTapped: \(self.text13)")
            print("text13value",self.text13)
           
           
            let dataToPass = [text1,text2,text3,text4,text5,text6,text7,text8,text9,text10,text11, text12, self.text13]
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
            {
                self.delegate?.didSaveData(data: dataToPass)
            }
           
                }
       
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var Numadults: UITextField!
    @IBOutlet weak var Numchild: UITextField!
    @IBOutlet weak var Numinfants: UITextField!
    @IBOutlet weak var Numpets: UITextField!
    @IBOutlet weak var checkindate: UITextField!
    @IBOutlet weak var checkoutdate: UITextField!
    @IBOutlet weak var pricemin: UITextField!
    @IBOutlet weak var pricemax: UITextField!
    @IBOutlet weak var minbeds: UITextField!
    @IBOutlet weak var minbedrooms: UITextField!
    @IBOutlet weak var minvathroom: UITextField!
    
    var isViewHidden = true
    var departure : Date = Date()
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func showmincalender(_ sender: Any) {
        
        datePicker.isHidden = false
        datePicker.tag = 1
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        let currentDate = Date()
        datePicker.minimumDate = currentDate
        datePicker.addTarget(self, action: #selector(datechanged), for: .valueChanged)
        
    }
    @IBAction func showmaxcalender(_ sender: Any) {
        
        datePicker.isHidden = false
        datePicker.tag = 2
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        let currentDate = departure
        datePicker.minimumDate = currentDate
        datePicker.addTarget(self, action: #selector(datechanged), for: .valueChanged)
        
        
    }
    
    @objc func datechanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        if sender.tag == 1 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            let date = dateFormatter.string(from: datePicker.date)
            departure = datePicker.date
            checkindate.text = date
            
        } else if sender.tag == 2 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            let date = dateFormatter.string(from: datePicker.date)
            checkoutdate.text = date
            
        }
        
        datePicker.isHidden = true
    }
    
    
    
    
    var propertytype : String = ""
    @IBAction func flat(_ sender: Any) {
        propertytype = "Flat"
    }
    @IBAction func house(_ sender: Any) {
        propertytype = "Hotel"
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.isHidden = true
        
        
        Numadults.delegate = self
        Numadults.becomeFirstResponder()
        
        Numpets.delegate = self
        Numpets.becomeFirstResponder()
        
        Numchild.delegate = self
        Numchild.becomeFirstResponder()
        
        Numinfants.delegate = self
        Numinfants.becomeFirstResponder()
        
        checkindate.delegate = self
        checkindate.becomeFirstResponder()
        
        checkoutdate.delegate = self
        checkoutdate.becomeFirstResponder()
        
        pricemax.delegate = self
        pricemax.becomeFirstResponder()
        
        pricemin.delegate = self
        pricemin.becomeFirstResponder()
        
        
        minbeds.delegate = self
        minbeds.becomeFirstResponder()
        
        minbedrooms.delegate = self
        minbedrooms.becomeFirstResponder()
        
        minbedrooms.delegate = self
        minbedrooms.becomeFirstResponder()
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Numadults.resignFirstResponder()
        Numpets.resignFirstResponder()
        Numchild.resignFirstResponder()
        Numinfants.resignFirstResponder()
        checkindate.resignFirstResponder()
        checkoutdate.resignFirstResponder()
        pricemax.resignFirstResponder()
        pricemin.resignFirstResponder()
        minbeds.resignFirstResponder()
        minbedrooms.resignFirstResponder()
        minbedrooms.resignFirstResponder()
        
    }
    private var Places_data : [PlaceStruct.Placedata]?
    private func GetplaceId(completion: @escaping () -> Void) {
           let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
           progressHUD.label.text = "Loading..."
           
           let headers: HTTPHeaders = [
               "X-RapidAPI-Key": "d9d575e88dmshe9b62abdb3a8e48p1c40edjsnd4cd18808268",
               "X-RapidAPI-Host": "airbnb19.p.rapidapi.com"
           ]
           
           let api = "https://airbnb19.p.rapidapi.com/api/v1/searchDestination"
           let parameters: [String: Any] = ["query": destination.text!]
           
           Alamofire.request(api, method: .get, parameters: parameters, headers: headers).responseJSON { [self] response in
               switch response.result {
               case .success(let value):
                   if let jsonArray = value as? [String: Any] {
                       do {
                           let jsonData = try JSONSerialization.data(withJSONObject: jsonArray)
                           let objects = try JSONDecoder().decode(PlaceStruct.self, from: jsonData)
                           self.Places_data = objects.data
                           print("Places_data : \(Places_data!)")

                           // Assign text13 value and call the completion handler
                           if let firstPlace = Places_data?.first {
                               text13 = firstPlace.id ?? ""
                               print("text13 : \(text13)")
                               progressHUD.hide(animated: true)

                               // Call the completion handler
                               completion()
                           }
                       } catch {
                           print("Error decoding JSON: \(error)")
                       }
                   }
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
       
    
    
}
