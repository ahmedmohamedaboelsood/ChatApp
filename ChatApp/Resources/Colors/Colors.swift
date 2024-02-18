//
//  Colors.swift
//  ChatApp
//
//  Created by Ahmed Abo Elsood on 13/02/2024.
//

import UIKit

enum AppColors{
    case babyBlue
    case navyBlue
    case lightNavyBlue
}

extension AppColors{
    var color : UIColor{
        switch self {
        case .babyBlue:
            return UIColor(named: "babyBlue") ?? .red
        case .navyBlue :
            return UIColor(named: "navyBlue") ?? .red
        case .lightNavyBlue:
            return UIColor(named: "lightNavyBlue") ?? .red
        }
    }
}
