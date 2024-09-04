import UIKit

class ListVisitVC: UIViewController {
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var cardVist: UIView!
    @IBOutlet weak var btnD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCard()
        
    }

    func loadCard()
    {
        btnDelete.backgroundColor = UIColor.clear
        btnDelete.layer.borderColor = UIColor.white.cgColor
        btnDelete.layer.borderWidth = 2
        btnDelete.layer.cornerRadius = 2
        cardVist.layer.cornerRadius = 13
        cardVist.layer.shadowColor = UIColor.black.cgColor
        cardVist.layer.shadowOpacity = 0.5
        cardVist.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardVist.layer.shadowRadius = 3
        btnD.backgroundColor = UIColor.clear
        btnD.layer.borderColor = UIColor.white.cgColor
        btnD.layer.borderWidth = 2
        btnD.layer.cornerRadius = 2
    }
}
