//
//  FunctionalViewController.swift
//  inHockey
//
//  Created by Георгий on 10.09.2021.
//

import UIKit

class FunctionalViewController: UIViewController {

    private let createTeamButton = UIButton()
    private let joinTeamButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTemporaryButtons()
        view.backgroundColor = UIColor.white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createTeamButton.pin
            .hCenter()
            .center(40)
        
        joinTeamButton.pin
            .hCenter()
            .center(-40)
    }
    private func setupTemporaryButtons() {
        createTeamButton.addStyle()
        createTeamButton.setTitle("Create team", for: .normal)
        createTeamButton.frame = CGRect(x: 0, y: 0, width: 337, height: 56)
        createTeamButton.addTarget(self, action: #selector(didTapCreateTeamButton), for: .touchUpInside)
        
        joinTeamButton.addStyle()
        joinTeamButton.setTitle("Join team", for: .normal)
        joinTeamButton.frame = CGRect(x: 0, y: 0, width: 337, height: 56)
        createTeamButton.addTarget(self, action: #selector(didTapJoinTeamButton), for: .touchUpInside)

        
        view.addSubview(createTeamButton)
        view.addSubview(joinTeamButton)
    }
    
    @objc private func didTapCreateTeamButton() {
        let viewController = CreateTeamViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func didTapJoinTeamButton() {
        
    }
    
}
