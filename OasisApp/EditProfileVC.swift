//
//  EditProfileVC.swift
//  OasisApp
//
//  Created by Pedro de Jesús Razo Flores on 02/06/24.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var btnSaveData: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        loadCard()
        
        DispatchQueue.main.async {
            self.lblName.text = self.user?.name
            self.lblUsername.text = self.user?.username
            self.txtName.text = self.user?.name
            self.txtUser.text = self.user?.username
            self.txtEmail.text = self.user?.email
            self.txtPass.text = self.user?.password
            self.txtAddress.text = self.user?.address
            self.txtPhone.text = self.user?.phone
        }
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        guard let username = txtUser.text,!username.isEmpty else {
            showAlert("Warning", "User input required")
            return
        }
        
        guard let name = txtName.text,!name.isEmpty else {
            showAlert("Warning", "Name input required")
            return
        }
        
        guard let email = txtEmail.text,!email.isEmpty else {
            showAlert("Warning", "Email input required")
            return
        }
        
        guard let password = txtPass.text,!password.isEmpty else {
            showAlert("Warning", "Password input required")
            return
        }
        
        guard let address = txtAddress.text, !address.isEmpty else { return showAlert("Warning", "Address input required") }
        
        guard let phone = txtPhone.text,!phone.isEmpty else {
            showAlert("Warning", "Contact phone number required")
            return
        }
        
        let params: [String: String] = [
            "userId": String(GlobalVariable.userId),
            "name" : name,
            "username": username,
            "email": email,
            "password": password,
            "address": address,
            "phone": phone
        ]
        
        validateUpdate(params) { success in
            DispatchQueue.main.asyncAndWait {
                if success {
                    print("Update: ", success)
                    self.navigationController?.popToRootViewController(animated: true)
                } else {
                    self.showAlert("Warning", "Try again later")
                }
            }
        }
    }
    
    private func validateUpdate(_ params: [String: String], completion: @escaping (Bool) -> Void) {
        let parameterArray = params.map { key, value in
            return "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
        let body = parameterArray.joined(separator: "&")
        print(body)
        
        let endpoint = "/profile/updateUser"
        let urlString = ApiConfig.baseURL + endpoint
        guard let url = URL(string: urlString) else {
            print("Algo salió mal")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
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
                            print("Todo salio excelente: ",jsonResponse)
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
    
    func loadCard()
    {
        btnSaveData.backgroundColor = UIColor.clear
        btnSaveData.layer.borderColor = UIColor.white.cgColor
        btnSaveData.layer.borderWidth = 2
        btnSaveData.layer.cornerRadius = 2
    }
}
