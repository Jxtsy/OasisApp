import UIKit

class CatalogVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableProperty: UITableView!
    var properties: [Property] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableProperty.dataSource = self
        tableProperty.delegate = self
        
        tableProperty.register(CardCell.self, forCellReuseIdentifier: "CustomCell")
                
        loadProperties()
        tableProperty.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return properties.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableProperty.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardCell
        cell.configure(properties[indexPath.row])
        cell.styleElement()
        return cell
    }
    
    private func loadProperties() {
        let endpoint = "/property/getProperties"
        let urlString = ApiConfig.baseURL + endpoint
        
        guard let url = URL(string: urlString) else {
            print("Algo salió mal")            
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error en la operación: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        if let model = try? JSONDecoder().decode([Property].self, from: data) {
                            
                            DispatchQueue.main.async {
                                self.properties += model
                                self.tableProperty.reloadData()
                            }
                            return
                        }
                    }
                }
            } else {
                print("Respuesta fallida o no HTTPURLResponse: \(response)")
                return
            }
        }
        task.resume()
    }
    
}
