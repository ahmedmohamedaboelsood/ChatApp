//
//  LoginAndRegisterVC.swift
//  ChatApp
//
//  Created by 2B on 11/02/2024.
//

import UIKit

class LoginAndRegisterVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var switchFormBtn: UIButton!
    @IBOutlet weak var RegisterStatusLbl: UILabel!
    @IBOutlet weak var RegisterBtn: UIButton!
    @IBOutlet weak var resendEmailBtn: UIButton!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    @IBOutlet weak var emailTitle: UILabel!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var confirmPasswordTitle: UILabel!
    @IBOutlet weak var passwordTxtFeild: UITextField!
    @IBOutlet weak var passwordTitle: UILabel!
    @IBOutlet weak var emailTxtFeild: UITextField!
    
    //MARK: - Variables
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Methods
    
    //MARK: - IBActions
    
    @IBAction func forgetPasswordBtn(_ sender: UIButton) {
        print("Forget pass")
    }
    
    @IBAction func resendEmailBtn(_ sender: UIButton) {
        print("resendEmailBtn")
    }
    
    @IBAction func RegisterBtn(_ sender: UIButton) {
        print("RegisterBtn")
    }
    
    @IBAction func switchFormBtn(_ sender: UIButton) {
        print("switchFormBtn")
    }
}
