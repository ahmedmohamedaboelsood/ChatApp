//
//  Colors.swift
//  ChatApp
//
//  Created by Ahmed Abo Elsood on 13/02/2024.
//

import UIKit

enum AppColors{
    case babyBlue
}

extension AppColors{
    var color : UIColor{
        switch self {
        case .babyBlue:
            return UIColor(named: "babyBlue") ?? .red
        }
    }
}
