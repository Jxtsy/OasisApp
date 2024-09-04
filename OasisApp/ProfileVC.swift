import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtUsername: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UILabel!
    @IBOutlet weak var txtAddress: UITextView!
    
    var modelProfile: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLoad()
        hideKeyboardWhenTappedAround()
        loadData()
    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "Login") as? ViewController {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func btnLoad() {
        btnEditProfile.backgroundColor = UIColor.clear
        btnEditProfile.layer.borderColor = UIColor.white.cgColor
        btnEditProfile.layer.borderWidth = 2
        btnEditProfile.layer.cornerRadius = 2
        btnLogout.backgroundColor = UIColor.clear
        btnLogout.layer.borderColor = UIColor.white.cgColor
        btnLogout.layer.borderWidth = 2
        btnLogout.layer.cornerRadius = 2
    }
    
    private func loadData() {
        let endpoint = "/profile/getUserDetails?userId=\(GlobalVariable.userId)"
        let urlString = ApiConfig.baseURL + endpoint
        guard let url = URL(string: urlString) else {
            print("Algo salió mal")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {
            data,
            response,
            error in
            if let error = error {
                print("Error en la operación: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                if !(200...299).contains(httpResponse.statusCode)
                {
                    print("Servidor responde:", httpResponse.statusCode)
                }
                if let data = data {
                    do {
                        if let model = try? JSONDecoder().decode(User.self, from: data) {
                            
                            print(model)
                            
                            DispatchQueue.main.async {
                                self.txtName.text = model.name
                                self.txtUsername.text = "@"+model.username
                                self.txtEmail.text = model.email
                                self.txtPassword.text = model.password
                                self.txtPhone.text = model.phone
                                self.txtAddress.text = model.address
                            }
                            
                            self.modelProfile = model
                            
                            return
                        }
                    }
                }
            } else {
                print("Respuesta fallida o no HTTPURLResponse: \(String(describing: response))")
                return
            }
    }
        task.resume()
    }
    
    @IBAction func viewPass(_ sender: UIButton) {
        if txtPassword.isSecureTextEntry {
            txtPassword.isSecureTextEntry = false
        } else {
            txtPassword.isSecureTextEntry = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editProfile" {
            (segue.destination as! EditProfileVC).user = modelProfile
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
}
