//
//  LogInViewControllew.swift
//  inHockey
//
//  Created by Георгий on 20.08.2021.
//

import UIKit
import PinLayout
import FirebaseAuth

class LogInViewController: UIViewController {

    private let headlabel = UILabel()
    private let letsGoButton = UIButton()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let separatorFirst = UIView()
    private let separatorSecond = UIView()
    private let navigationBar = UINavigationBar()
    private let passwordImageIcon = UIImageView()
    private let contentView = UIView()
    private let errorMessage = UILabel()
    
    var iconClick = false
    
    let strokeTextAttributes = [
        NSAttributedString.Key.strokeColor.rawValue : UIColor.black,
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.strokeWidth : -1.0,
        NSAttributedString.Key.font : UIFont(name: "IndieFlower", size: 72)!
    ] as! [NSAttributedString.Key : Any]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(image: UIImage.init(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(didTapBackButton))
        
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = backButton
        backButton.tintColor = #colorLiteral(red: 0.5537394881, green: 0.8924116492, blue: 0.9830355048, alpha: 1)
        
        headlabel.textAlignment = .center
        headlabel.attributedText = NSMutableAttributedString(string: "inHockey", attributes: strokeTextAttributes)
        headlabel.textColor = #colorLiteral(red: 0.5537394881, green: 0.8924116492, blue: 0.9830355048, alpha: 1)
        headlabel.textDropShadow()
        
        errorMessage.textAlignment = .center
        errorMessage.textDropShadow()
        errorMessage.font = UIFont(name: "IndieFlower", size: 15)
        errorMessage.textColor = #colorLiteral(red: 0.9830355048, green: 0.423397322, blue: 0.4428894218, alpha: 1)
        errorMessage.alpha = 0
        errorMessage.frame = CGRect(x: 0, y: 0, width: 353, height: 30)
        
        
        letsGoButton.addStyle()
        letsGoButton.setTitle("Let's go", for: .normal)
        letsGoButton.frame = CGRect(x: 0, y: 0, width: 337, height: 56)
        
        emailField.attributedPlaceholder =  NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        passwordField.attributedPlaceholder =  NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        passwordField.isSecureTextEntry.toggle()
        passwordField.rightView = contentView
        passwordField.rightViewMode = .always
    
        [emailField, passwordField].forEach{
            ($0).font = UIFont(name: "IndieFlower", size: 25)
            ($0).borderStyle = .none
            ($0).keyboardType = UIKeyboardType.default
            ($0).addTarget(nil, action: Selector(("FirstResponderAction")), for: .editingDidEndOnExit)
            ($0).textColor = UIColor.black
            ($0).autocapitalizationType = .none
            view.addSubview($0)
        }
        
        [separatorFirst, separatorSecond].forEach{
            ($0).backgroundColor = #colorLiteral(red: 0.5537394881, green: 0.8924116492, blue: 0.9830355048, alpha: 1)
            ($0).layer.cornerRadius = 2
            ($0).layer.borderColor = UIColor.black.cgColor
            ($0).layer.borderWidth = 0.5
            view.addSubview($0)
        }
        
        navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 0)
        navigationBar.setItems([navItem], animated: false)
        navigationBar.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        passwordImageIcon.image = UIImage(systemName: "eye.slash")
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        passwordImageIcon.frame = CGRect(x: -5, y: 0, width: UIImage(systemName: "eye.slash")!.size.width + 5, height: UIImage(systemName: "eye.slash")!.size.height + 3)
        passwordImageIcon.isUserInteractionEnabled = true
        passwordImageIcon.tintColor = #colorLiteral(red: 0.5537394881, green: 0.8924116492, blue: 0.9830355048, alpha: 1)
        passwordImageIcon.addGestureRecognizer(tapGestureRecognizer)
        contentView.addSubview(passwordImageIcon)
        
        view.backgroundColor = .white
        view.addSubview(headlabel)
        view.addSubview(letsGoButton)
        view.addSubview(navigationBar)
        view.addSubview(errorMessage)
        self.setupToHideKeyboard()
        letsGoButton.addTarget(self, action: #selector(didTapLetsGoButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headlabel.pin
            .top(view.pin.safeArea.top + 40)
            .sizeToFit()
            .hCenter()
        
        errorMessage.pin
            .hCenter()
            .horizontally(20)
            .bottom(view.pin.safeArea.bottom + 100)
        
        letsGoButton.pin
            .bottom(view.pin.safeArea.bottom + 20)
            .hCenter()
            
        emailField.pin
            .horizontally(20)
            .height(60)
            .center(-40)
        
        passwordField.pin
            .horizontally(20)
            .height(60)
            .center(30)
        
        separatorFirst.pin
            .below(of: emailField)
            .horizontally(20)
            .height(3)
        
        separatorSecond.pin
            .below(of: passwordField)
            .horizontally(20)
            .height(3)
        
        navigationBar.pin
            .top(view.pin.safeArea.top)
            .horizontally(0)
            .height(20)
    }
    
    func showErrorMessage(_ message: String){
        errorMessage.text = message
        errorMessage.alpha = 1
    }

    
    func transitionToHomeScreen(){
        let homeViewController = TabBarController()
        homeViewController.modalPresentationStyle = .fullScreen
        present(homeViewController, animated: true, completion: nil)
        UserDefaults.standard.setValue(true, forKey: "isAuth")
    }
    
    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapLetsGoButton(){
        let logIn = LogInModel()
        
        logIn.logIn(emailField, passwordField) { [weak self] isSignIn, errorMessage in
            
            if isSignIn == true {
                self?.transitionToHomeScreen()
            }
            else if isSignIn == false {
                self?.showErrorMessage(errorMessage ?? "Something went wrong")
            }
        }
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if iconClick {
            iconClick = false
            tappedImage.image = UIImage(systemName: "eye")
            passwordField.isSecureTextEntry = false
        }
        else {
            iconClick = true
            tappedImage.image = UIImage(systemName: "eye.slash")
            passwordField.isSecureTextEntry = true
        }
    }
}

extension UIViewController {
    func setupToHideKeyboard(){
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}


extension UILabel{
    func textDropShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity =  0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
}

extension UIButton{
    func addStyle(){
        self.backgroundColor = #colorLiteral(red: 0.5537394881, green: 0.8924116492, blue: 0.9830355048, alpha: 1)
        self.layer.cornerRadius = 20
        self.titleLabel?.font = UIFont(name: "IndieFlower", size: 25)
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
