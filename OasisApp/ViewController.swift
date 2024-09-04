import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardLogin: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCard()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        guard let username = txtUsername.text,!username.isEmpty else {
            return showAlert("Warning", "User input required")
        }
        
        guard let password = txtPassword.text,!password.isEmpty else {
            return showAlert("Warning", "Password required")
        }
        
        validateLogin(username, password) { success in
            DispatchQueue.main.asyncAndWait {
                if success {
                    let tabBar = self.storyboard?.instantiateViewController(identifier: "TabBarApp") as? UITabBarController
                    self.present(tabBar!, animated: true, completion: nil)
                } else {
                    self.showAlert("Warning", "User not found")
                }
            }
        }
    }
    
    private func validateLogin(_ user: String, _ password: String, completion: @escaping (Bool) -> Void) {
        let loginEndpoint = "/auth/login?username=\(user)&password=\(password)"
        let urlString = ApiConfig.baseURL + loginEndpoint
        
        guard let url = URL(string: urlString) else {
            print("Algo salió mal")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error en la operación: \(error)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            
                            GlobalVariable.userId = Int(jsonResponse["userId"] as! String)!
                            print("User: ",GlobalVariable.userId)
                            print(jsonResponse)
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
    
    func loadCard() {
        cardLogin.layer.cornerRadius = 13
        cardLogin.layer.shadowColor = UIColor.black.cgColor
        cardLogin.layer.shadowOpacity = 0.5
        cardLogin.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardLogin.layer.shadowRadius = 3
        
        btnLogin.backgroundColor = UIColor.clear
        btnLogin.layer.borderColor = UIColor.white.cgColor
        btnLogin.layer.borderWidth = 2
        btnLogin.layer.cornerRadius = 2
    }
}

