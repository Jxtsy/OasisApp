import UIKit

class CardCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var txtLocation: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    
    var property: Property?
    
    
    func configure(_ property: Property)
    {
        txtName.text = property.name
        txtLocation.text = "Location: " + property.location
        txtPrice.text = "Price: " + String(property.price)
        imgBack.image = UIImage(named: "backgroundHome")
        
        self.property = property
    }
    
    func styleElement()
    {
        btnDetail.backgroundColor = UIColor.clear
        btnDetail.layer.borderColor = UIColor.white.cgColor
        btnDetail.layer.borderWidth = 2
        btnDetail.layer.cornerRadius = 2
    }
    
    @IBAction func btnRedirigir(_ sender: UIButton) {
        GlobalVariable.propertyId = property!.propertyId
    }
    
}
