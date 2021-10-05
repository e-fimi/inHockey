//
//  ViewController.swift
//  inHockey
//
//  Created by Георгий on 18.08.2021.
//

import UIKit
import PinLayout


class AuthViewController: UIViewController {
    
    private let headlabel = UILabel()
    private let logInButton = UIButton()
    private let signUpButton = UIButton()
    
    let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor.rawValue : UIColor.black,
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.strokeWidth : -1.0,
        NSAttributedString.Key.font : UIFont(name: "IndieFlower", size: 72)!
    ] as! [NSAttributedString.Key : Any]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headlabel.textAlignment = .center
        headlabel.attributedText = NSMutableAttributedString(string: "inHockey", attributes: strokeTextAttributes)
        headlabel.textColor = #colorLiteral(red: 0.5537394881, green: 0.8924116492, blue: 0.9830355048, alpha: 1)
        headlabel.textDropShadow()
        
        logInButton.setTitle("Log in", for: .normal)
        signUpButton.setTitle("Sign Up", for: .normal)
        
        view.backgroundColor = .white
        view.addSubview(headlabel)
        view.addSubview(logInButton)
        view.addSubview(signUpButton)
        
        [logInButton, signUpButton].forEach {
            ($0).layer.masksToBounds = true
            ($0).frame = CGRect(x: 0, y: 0, width: 337, height: 56)
            ($0).addStyle()
        }
        
        logInButton.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headlabel.pin
            .top(view.pin.safeArea.top + 40)
            .sizeToFit()
            .hCenter()
        
        logInButton.pin
            .bottom(view.pin.safeArea.bottom + 80)
            .hCenter()
            
        signUpButton.pin
            .bottom(view.pin.safeArea.bottom + 10)
            .hCenter()

    }
    
    @objc
    private func didTapLogInButton(){
       
        let logInController = LogInViewController()
        logInController.modalPresentationStyle = .fullScreen
        present(logInController, animated: true, completion: nil)
    }
    @objc
    private func didTapSignUpButton(){
        let signUpController = SignUpViewController()
        signUpController.modalPresentationStyle = .fullScreen
        present(signUpController, animated: true, completion: nil)
    }
}
