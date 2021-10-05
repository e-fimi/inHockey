//
//  TabBarController.swift
//  inHockey
//
//  Created by Георгий on 10.09.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        setupTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    private func setupTabBar() {
        
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.gray.cgColor
        
        let vc1 = FunctionalViewController()
        vc1.tabBarItem.image = UIImage(named: "hockeyField")
      
        let vc2 = CommunicationViewController()
        vc2.tabBarItem.image = UIImage(named: "chatImage")
   
        let vc3 = ProfileContainer.assemble(with: ProfileContext()).viewController
        vc3.tabBarItem.image = UIImage(named: "profileImage")
        
        [vc1, vc2, vc3].forEach {
            ($0).tabBarItem.imageInsets = UIEdgeInsets.init(top: 25,left: 0,bottom: -15 ,right: 0)
        }
       
        viewControllers = [vc1, vc2, vc3]
    }
}
