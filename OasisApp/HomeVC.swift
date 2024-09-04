import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var btnContact: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func btnLoad() {
        btnContact.backgroundColor = UIColor.clear
        btnContact.layer.borderColor = UIColor.white.cgColor
        btnContact.layer.borderWidth = 2
        btnContact.layer.cornerRadius = 2
    }

}
