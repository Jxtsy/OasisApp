import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var cardCreateAccount: UIView!
    @IBOutlet weak var btnCreatAccount: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCard()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func btnCreate(_ sender: UIButton) {
        guard let username = txtUsername.text,!username.isEmpty else {
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

        guard let phone = txtPhone.text,!phone.isEmpty else {
            showAlert("Warning", "Contact phone number required")
            return
        }
        
        let params: [String: String] = [
            "name" : name,
            "username": username,
            "email": email,
            "password": password,
            "phone": phone
        ]
        
        validateCreate(params) { success in
            DispatchQueue.main.asyncAndWait {
                if success {
                    print("Insert: ", success)
                    self.performSegue(withIdentifier: "login", sender: nil)
                } else {
                    self.showAlert("Warning", "Try again later")
                }
            }
        }
    }
    
    private func validateCreate(_ params: [String: String], completion: @escaping (Bool) -> Void) {
        let parameterArray = params.map { key, value in
            return "\(key)=\(value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
        let body = parameterArray.joined(separator: "&")
        
        let endpoint = "/auth/save"
        let urlString = ApiConfig.baseURL + endpoint
        guard let url = URL(string: urlString) else {
            print("Algo salió mal")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
        cardCreateAccount.layer.cornerRadius = 13
        cardCreateAccount.layer.shadowColor = UIColor.black.cgColor
        cardCreateAccount.layer.shadowOpacity = 0.5
        cardCreateAccount.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardCreateAccount.layer.shadowRadius = 3
        
        btnCreatAccount.backgroundColor = UIColor.clear
        btnCreatAccount.layer.borderColor = UIColor.white.cgColor
        btnCreatAccount.layer.borderWidth = 2
        btnCreatAccount.layer.cornerRadius = 2
    }

}
