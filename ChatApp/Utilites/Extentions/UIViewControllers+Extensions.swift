//
//  UIViewControllers+Extensions.swift
//  ChatApp
//
//  Created by Ahmed Abo Elsood on 13/02/2024.
//

import UIKit
import ProgressHUD

extension UIViewController{
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showError(message:String){
        ProgressHUD.showError(message)
    }
    
    func showSussess(message:String){
        ProgressHUD.showSuccess(message)
    }
}
