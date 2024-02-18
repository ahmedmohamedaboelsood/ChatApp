//
//  Defaults.swift
//  ChatApp
//
//  Created by 2B on 14/02/2024.
//

import Foundation

class Defaults{
    
    enum Keys :String {
        case userData = "userData"
    }
    
    static var userData : User? {
        set {
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(newValue)
                UserDefaults.standard.set(data, forKey: Keys.userData.rawValue)
                UserDefaults.standard.synchronize()
            }catch{
                print("CanNot save user obj")
            }
        }
        
        get {
            let userData = UserDefaults.standard.object(forKey: Keys.userData.rawValue)
            return userData as? User
        }
    }
}
