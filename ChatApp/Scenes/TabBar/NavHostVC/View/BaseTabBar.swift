//
//  BaseTabBar.swift
//  ChatApp
//
//  Created by 2B on 15/02/2024.
//

import UIKit

class BaseTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tabBar.backgroundColor = .white
    }
    
    func setupUI(){
        let VC1 = ChatsVC()
        VC1.title = "Chats"
        VC1.tabBarItem.image = UIImage(systemName: "message.fill")
        let VC2 = ChannelsVC()
        VC2.title = "Channels"
        VC2.tabBarItem.image = UIImage(systemName: "person.3.fill")
        let VC3 = SettingsVC()
        VC3.title = "Setting"
        VC3.tabBarItem.image = UIImage(systemName: "gear")
        self.viewControllers = [VC1,VC2,VC3]
        self.tabBar.tintColor = AppColors.lightNavyBlue.color
    }
}
