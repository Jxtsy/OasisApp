//
//  VisitVC.swift
//  OasisApp
//
//  Created by Bianka Juarez on 17/06/24.
//

import UIKit

class VisitVC: UIViewController {
    @IBOutlet weak var btnVisit: UIButton!
    @IBOutlet weak var dpDateVisit: UIDatePicker!
    
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStyle()
    }
    
    @IBAction func btnAddVisit(_ sender: UIButton)
    {
        let params: [String: String] = [
            "user_id": String(GlobalVariable.userId),
            "property_id" : String(GlobalVariable.propertyId),
            "visit_date" : self.date!
        ]
        
        saveVisit(params) { sucess in
            DispatchQueue.main.async {
                if sucess {
                    print("Save successfull")
                    self.showAlert("Success", "Schedule Appointment")
                }
            }
        }
    }
    
    @IBAction func dateVisit(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = dateFormatter.string(from: sender.date)
                print("Selected Date: \(dateString)")
        self.date = dateString
    }
    
    private func saveVisit(_ params: [String: String], completion: @escaping (Bool) -> Void) {
        let parameterArray = params.map { key, value in
            return "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
        let body = parameterArray.joined(separator: "&")
        print(body)
        
        let endpoint = "/visit/save"
        let urlString = ApiConfig.baseURL + endpoint
        guard let url = URL(string: urlString) else {
            print("Algo salió mal")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = body.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error en la operación: \(error)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if !(200...299).contains(httpResponse.statusCode)
                {
                    print("Servidor responde:", httpResponse.statusCode)
                }
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print("Todo salio excelente: ")
                            completion(true)
                            return
                        }
                    } catch let parsingError {
                        print("Aquí ya no funcionó: \(parsingError)")
                        completion(false)
                        return
                    }
                }
            } else {
                print("Respuesta fallida o no HTTPURLResponse: \(response)")
                completion(false)
                return
            }
        }
        task.resume()
    }
    
    func loadStyle()
    {
        btnVisit.backgroundColor = UIColor.clear
        btnVisit.layer.borderColor = UIColor.white.cgColor
        btnVisit.layer.borderWidth = 2
        btnVisit.layer.cornerRadius = 2
    }
}
