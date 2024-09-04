import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
    }
    
    func showAlert(_ title: String,_ message: String, completionHandler: @escaping () -> Void = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle:.alert)
        alertController.addAction(UIAlertAction(title: "OK", style:.default) { _ in
            completionHandler()
        })
        
        var currentViewController = self
        while let presentedViewController = currentViewController.presentedViewController {
            currentViewController = presentedViewController
        }
        
        currentViewController.present(alertController, animated: true, completion: nil)
    }
}
