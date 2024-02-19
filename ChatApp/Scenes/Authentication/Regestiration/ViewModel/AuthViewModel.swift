//
//  AuthViewModel.swift
//  ChatApp
//
//  Created by 2B on 14/02/2024.
//

import Foundation

class AuthViewModel {
    
    //MARK: - Variables
    var indicatorIsLoading : Observable<Bool> = Observable(nil)
    var registerResponce : Observable<String> = Observable(nil)
    var loginResponce : Observable<String> = Observable(nil)
    var validationState : Observable<String> = Observable(nil)
    var resendEmailState : Observable<String> = Observable(nil)
    var forgetPasswordState : Observable<String> = Observable(nil)
    var passwordIsConfirmed : String?
    var email = ""
    var password = ""
    var isValid = true
    
    //MARK: - Register
    
    private func registerNewUser(email: String,password: String){
        indicatorIsLoading.value = true
        FIBManger.shared.registerUser(email: email, password: password) { responseMessage in
            if responseMessage == "done" {
                self.indicatorIsLoading.value = false
                self.registerResponce.value = responseMessage
            }else{
                self.indicatorIsLoading.value = false
                self.registerResponce.value = responseMessage
            }
        }
    }
    
    func registerUserValidated(email : String? , password : String? , confirmPassword : String? , isLogin : Bool ) {
        validation(email: email, password: password, confirmPassword: confirmPassword, isLogin: isLogin)
        if let passConfirmed = passwordIsConfirmed {
            if passConfirmed == password{
                registerNewUser(email: self.email, password: self.password)
            }else{
                validationState.value = "Passwords don't match"
            }
        }
    }
    
    //MARK: - Login
    
    private func loginUser(email:String,password:String){
        indicatorIsLoading.value = true
        FIBManger.shared.loginUser(email: email, password: password) { error, isEmailVerified in
            if error == nil {
                if isEmailVerified ?? false {
                    self.indicatorIsLoading.value = false
                    self.loginResponce.value = "done"
                }else{
                    self.indicatorIsLoading.value = false
                    self.loginResponce.value = "Check your email and verify registeration"
                }
            }else{
                self.indicatorIsLoading.value = false
                self.loginResponce.value = error
            }
        }
    }
    
    func loginUserValidated(email:String?,password:String?,isLogin:Bool){
        validation(email: email, password: password, confirmPassword: nil, isLogin: isLogin)
        if isValid {
            loginUser(email: self.email, password: self.password)
            isValid = false
        }
    }
    
    //MARK: - Resend Email
    
    func resendEmailValidated(email:String?){
        validation(email: email, password: "N/A", confirmPassword: nil, isLogin: false)
        if isValid{
            resendEmail(email: self.email)
            isValid = false
        }
    }
    
    private func resendEmail(email:String){
        indicatorIsLoading.value = true
        FIBManger.shared.resendEmail(email: email) { error in
            if error == nil {
                self.indicatorIsLoading.value = false
                self.resendEmailState.value = "done"
            }else{
                self.indicatorIsLoading.value = false
                self.resendEmailState.value = error
            }
        }
    }
    
    //MARK: - Forget Password
    
    func forgetPasswordValidated(email:String?){
        validation(email: email, password: "N/A", confirmPassword: nil, isLogin: false)
        if isValid{
            forgetPassword(email: self.email)
            isValid = false
        }
    }
    
    private func forgetPassword(email: String){
        indicatorIsLoading.value = true
        FIBManger.shared.resetPassword(email: email) { error in
            if error == nil {
                self.indicatorIsLoading.value = false
                self.forgetPasswordState.value = "done"
            }else{
                self.indicatorIsLoading.value = false
                self.forgetPasswordState.value = error
            }
        }
    }
    
    //MARK: - Validation
    
    private func validation(email : String? , password : String? ,confirmPassword : String? , isLogin : Bool ){
        guard let email = email , !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            validationState.value = "Enter Email"
            return
        }
        self.email = email
        guard let password = password , !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            validationState.value = "Enter password"
            return
        }
        self.password = password
        
        if isLogin{
            guard let confirmPassword = confirmPassword , !confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty else {
                validationState.value = "confirm Password"
                return
            }
            passwordIsConfirmed = confirmPassword
        }
        isValid = true
    }
}
