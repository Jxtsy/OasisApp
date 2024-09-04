import Foundation
import UIKit

class ElementCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageBack: UIImageView?
    @IBOutlet weak var actionButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with elemento: Property) {
        titleLabel.text = elemento.name ?? "a"
        descriptionLabel.text = elemento.location ?? "b"
        
        // Verificar si imageBack es nil antes de acceder a su propiedad image
        if let image = UIImage(named: "backgroundHome"), let imageBack = imageBack {
            imageBack.image = image
        } else {
            // Si imageBack es nil o la imagen no se carga correctamente,
            // establece una imagen predeterminada
            if let systemImage = UIImage(systemName: "location.fill"),
               let imageBack = imageBack {
                imageBack.image = systemImage
            }
        }
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for:.touchUpInside)
    }

    @objc private func actionButtonTapped() {
        // Implementa la acción del botón aquí
    }

}

