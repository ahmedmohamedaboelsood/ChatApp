//
//  LoginAndRegisterVC.swift
//  ChatApp
//
//  Created by Ahmed Abo Elsood on 11/02/2024.
//

import UIKit

class LoginAndRegisterVC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var screenTitle: UILabel!
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
    
    var isLogin = false
    var viewModel = AuthViewModel()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
        bindViewModelData()
    }
    
    //MARK: - Methods
    
    private func setupUI(){
        hideKeyboardWhenTappedAround()
        textFeildsSetup()
        setupFonts()
        setupColors()
        screenState()
    }
    
    private func textFeildsSetup(){
        emailTxtFeild.delegate = self
        passwordTxtFeild.delegate = self
        confirmPasswordTxtField.delegate = self
    }
    
    private func setupFonts(){
        emailTitle.font = AppFonts.almarai(fontStyle: .bold(size: 15)).font
        passwordTitle.font = AppFonts.almarai(fontStyle: .bold(size: 15)).font
        confirmPasswordTitle.font = AppFonts.almarai(fontStyle: .bold(size: 15)).font
        RegisterStatusLbl.font = AppFonts.almarai(fontStyle: .bold(size: 15)).font
        resendEmailBtn.titleLabel?.font = AppFonts.almarai(fontStyle: .bold(size: 15)).font
        forgetPasswordBtn.titleLabel?.font = AppFonts.almarai(fontStyle: .bold(size: 15)).font
        switchFormBtn.titleLabel?.font = AppFonts.almarai(fontStyle: .bold(size: 20)).font
        RegisterBtn.titleLabel?.font = AppFonts.almarai(fontStyle: .bold(size: 25)).font
        screenTitle.font = AppFonts.almarai(fontStyle: .bold(size: 30)).font
    }
    
    private func setupColors(){
        forgetPasswordBtn.tintColor = AppColors.lightNavyBlue.color
        resendEmailBtn.tintColor = AppColors.lightNavyBlue.color
        switchFormBtn.tintColor = AppColors.lightNavyBlue.color
        RegisterBtn.tintColor = .white
        RegisterBtn.backgroundColor = AppColors.lightNavyBlue.color
        emailTitle.textColor = AppColors.lightNavyBlue.color
        passwordTitle.textColor = AppColors.lightNavyBlue.color
        confirmPasswordTitle.textColor = AppColors.lightNavyBlue.color
        screenTitle.textColor = AppColors.lightNavyBlue.color
    }
    
    private func resetLabels(){
        emailTitle.text = ConstantsStrings.none.rawValue
        passwordTitle.text = ConstantsStrings.none.rawValue
        confirmPasswordTitle.text = ConstantsStrings.none.rawValue
        emailTxtFeild.text = ConstantsStrings.none.rawValue
        passwordTxtFeild.text = ConstantsStrings.none.rawValue
        confirmPasswordTxtField.text = ConstantsStrings.none.rawValue
    }
    
    private func setupLabelsForRegister(){
        resetLabels()
        screenTitle.text = ConstantsStrings.register.rawValue
        RegisterStatusLbl.text = ConstantsStrings.regidterState.rawValue
        resendEmailBtn.isHidden = false
        forgetPasswordBtn.isHidden = true
        confirmPasswordTitle.isHidden = false
        confirmPasswordTxtField.isHidden = false
    }
    
    private func setupLabelsForLogin(){
        resetLabels()
        screenTitle.text = ConstantsStrings.login.rawValue
        RegisterStatusLbl.text = ConstantsStrings.loginState.rawValue
        resendEmailBtn.isHidden = true
        forgetPasswordBtn.isHidden = false
        confirmPasswordTitle.isHidden = true
        confirmPasswordTxtField.isHidden = true
    }
    
    private func setupButtonsForRegister(){
        resendEmailBtn.setTitle(ConstantsStrings.resendEmail.rawValue, for: .normal)
        switchFormBtn.setTitle(ConstantsStrings.login.rawValue, for: .normal)
        RegisterBtn.setTitle(ConstantsStrings.register.rawValue, for: .normal)
    }
    
    private func setupButtonsForLogin(){
        forgetPasswordBtn.setTitle(ConstantsStrings.forgetPassword.rawValue, for: .normal)
        switchFormBtn.setTitle(ConstantsStrings.register.rawValue, for: .normal)
        RegisterBtn.setTitle(ConstantsStrings.login.rawValue, for: .normal)
    }
    
    private func screenState(){
        if isLogin{
            setupButtonsForLogin()
            setupLabelsForLogin()
        }else{
            setupButtonsForRegister()
            setupLabelsForRegister()
        }
        isLogin.toggle()
        resetViewModelProperaties()
    }
    
    private func resetViewModelProperaties(){
        viewModel.passwordIsConfirmed = nil
        viewModel.email = ""
        viewModel.password = ""
        viewModel.isValid = false
    }
    
    private func bindViewModelData(){
        bindRegisterResponce()
        bindLoginResponce()
        bindTxtFieldsValidation()
        bindResendEmailState()
        bindIndicatorState()
        bindForgetPasswordState()
    }
    
    private func bindTxtFieldsValidation(){
        viewModel.validationState.bind { [weak self] message in
            guard let self = self else {return}
            guard let message = message else {return}
            showError(message: message)
        }
    }
    
    private func bindRegisterResponce(){
        viewModel.registerResponce.bind { [weak self] responce in
            guard let self = self else {return}
            guard let responce = responce else {return}
            if responce == "done" {
                showSussess(message: "Verification mail sent successfully")
            }else{
                showError(message: responce)
            }
        }
    }
    
    private func bindLoginResponce(){
        viewModel.loginResponce.bind { [weak self] responce in
            guard let self = self else {return}
            guard let responce = responce else {return}
            if responce == "done" {
                navigateToChats()
                showSussess(message: "Logged SuccessFully")
            }else{
                showError(message: responce)
            }
        }
    }
    
    private func bindResendEmailState(){
        viewModel.resendEmailState.bind {[weak self] responce in
            guard let self = self else {return}
            guard let responce = responce else {return}
            if responce == "done"{
                showSussess(message: "Email has been Send")
            }else{
                showError(message: responce)
            }
        }
    }
    
    private func bindForgetPasswordState(){
        viewModel.forgetPasswordState.bind {[weak self] responce in
            guard let self = self else {return}
            guard let responce = responce else {return}
            if responce == "done"{
                showSussess(message: "Reset password email has been Send")
            }else{
                showError(message: responce)
            }
        }
    }
    
    private func bindIndicatorState(){
        activityIndicator.stopAnimating()
        viewModel.indicatorIsLoading.bind {[weak self] isLoading in
            guard let self = self else {return}
            guard let isLoading = isLoading else {return}
            if isLoading {
                activityIndicator.startAnimating()
            }else{
                activityIndicator.stopAnimating()
            }
        }
    }
    
    private func registerUser(){
        viewModel.registerUserValidated(email: emailTxtFeild.text, password: passwordTxtFeild.text, confirmPassword: confirmPasswordTxtField.text, isLogin: isLogin)
    }
    
    private func loginUser(){
        viewModel.loginUserValidated(email: emailTxtFeild.text, password: passwordTxtFeild.text, isLogin: isLogin)
    }
    
    private func userAuthintication(){
        if !isLogin {
            loginUser()
        }else{
            registerUser()
        }
    }
    
    private func resendEmail(){
        viewModel.resendEmailValidated(email: emailTxtFeild.text)
    }
    
    private func forgetPassword(){
        viewModel.forgetPasswordValidated(email: emailTxtFeild.text)
    }
    
    private func navigateToChats(){
        let vc = BaseTabBar()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - IBActions
    
    @IBAction func forgetPasswordBtn(_ sender: UIButton) {
        forgetPassword()
    }
    
    @IBAction func resendEmailBtn(_ sender: UIButton) {
        resendEmail()
    }
    
    @IBAction func RegisterBtn(_ sender: UIButton) {
        userAuthintication()
    }
    
    @IBAction func switchFormBtn(_ sender: UIButton) {
        screenState()
    }
    
    //MARK: - Constants
    
    private enum ConstantsStrings : String{
        case register = "Register"
        case regidterState = "Already Have Account ? "
        case loginState = "Create new account."
        case login = "Login"
        case resendEmail = "Resend Email ?"
        case forgetPassword = "Forget Password ?"
        case email = "Email"
        case password = "Password"
        case confirmPassword = "Confirm password"
        case none = ""
        
    }
}

extension LoginAndRegisterVC : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.emailTitle.text = self.emailTxtFeild.hasText ? ConstantsStrings.email.rawValue : ConstantsStrings.none.rawValue
        self.passwordTitle.text = self.passwordTxtFeild.hasText ? ConstantsStrings.password.rawValue : ConstantsStrings.none.rawValue
        self.confirmPasswordTitle.text = self.confirmPasswordTxtField.hasText ? ConstantsStrings.confirmPassword.rawValue : ConstantsStrings.none.rawValue
    }
}
