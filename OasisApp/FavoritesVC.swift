//
//  FavoritesVC.swift
//  OasisApp
//
//  Created by Pedro de Jesús Razo Flores on 02/06/24.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var btnDos: UIButton!
    @IBOutlet weak var btnUno: UIButton!
    @IBOutlet weak var btnViewFavorite: UIButton!
    
    override func viewDidLoad() {
        loadPage()
        super.viewDidLoad()
    }
    
    func loadPage()
    {
        btnViewFavorite.backgroundColor = UIColor.clear
        btnViewFavorite.layer.borderColor = UIColor.white.cgColor
        btnViewFavorite.layer.borderWidth = 2
        btnViewFavorite.layer.cornerRadius = 2
        btnUno.backgroundColor = UIColor.clear
        btnUno.layer.borderColor = UIColor.white.cgColor
        btnUno.layer.borderWidth = 2
        btnUno.layer.cornerRadius = 2
        btnDos.backgroundColor = UIColor.clear
        btnDos.layer.borderColor = UIColor.white.cgColor
        btnDos.layer.borderWidth = 2
        btnDos.layer.cornerRadius = 2
    }
}
