import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblBed: UILabel!
    @IBOutlet weak var lblBath: UILabel!
    @IBOutlet weak var lblStyle: UILabel!
    @IBOutlet weak var lblSpecial: UILabel!
    @IBOutlet weak var btnVisit: UIButton!
    
    var detail: PropertyDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStyle()
        print("Property: ",GlobalVariable.propertyId)
        hideKeyboardWhenTappedAround()
        loadData(GlobalVariable.propertyId) { sucess in
            DispatchQueue.main.asyncAndWait {
                print("Detail: ",self.detail)
                self.lblDes.text = self.detail!.descripcion
            }
        }
    }
    
    private func loadData(_ propertyId: Int, completion: @escaping (Bool) -> Void) {
        let endpoint = "/property/getDetailPropertie?propertyId=\(propertyId)"
        let urlString = ApiConfig.baseURL + endpoint
        guard let url = URL(string: urlString) else {
            print("Algo salió mal")
            completion(false)
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
                completion(false)
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
                        if let model = try? JSONDecoder().decode(PropertyDetail.self, from: data) {
                            self.detail = model
                            completion(true)
                            return
                        }
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
