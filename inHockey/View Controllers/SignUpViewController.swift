//
//  SignUpViewController.swift
//  inHockey
//
//  Created by Георгий on 20.08.2021.
//

import UIKit
import PinLayout
import Firebase
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController, UITextFieldDelegate {

    private let navigationBar = UINavigationBar()
    private let headLabel = UILabel()
    private let firstNameTextField = UITextField()
    private let secondNameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let passwordAgainTextField = UITextField()
    private let letsDoItButton = UIButton()
    private let separatorFirst = UIView()
    private let separatorSecond = UIView()
    private let separatorThird = UIView()
    private let separatorFourth = UIView()
    private let separatorFifth = UIView()
    private let passwordImageIcon = UIImageView()
    private let contentView = UIView()
    private let errorLabel = UILabel()
    public var activeTextField = UITextField()
    
    var imageClick = false
    
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
        
        headLabel.textAlignment = .center
        headLabel.attributedText = NSMutableAttributedString(string: "inHockey", attributes: strokeTextAttributes)
        headLabel.textColor = #colorLiteral(red: 0.5537394881, green: 0.8924116492, blue: 0.9830355048, alpha: 1)
        headLabel.textDropShadow()
        
        errorLabel.textAlignment = .center
        errorLabel.textDropShadow()
        errorLabel.font = UIFont(name: "IndieFlower", size: 15)
        errorLabel.textColor = #colorLiteral(red: 0.9830355048, green: 0.423397322, blue: 0.4428894218, alpha: 1)
        errorLabel.alpha = 0
        errorLabel.frame = CGRect(x: 0, y: 0, width: 353, height: 70)
        errorLabel.numberOfLines = 0
        
        
        letsDoItButton.addStyle()
        letsDoItButton.setTitle("Let's do it", for: .normal)
        letsDoItButton.frame = CGRect(x: 0, y: 0, width: 337, height: 56)
        
        firstNameTextField.attributedPlaceholder =  NSAttributedString(string: "First name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        secondNameTextField.attributedPlaceholder =  NSAttributedString(string: "Second name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        emailTextField.attributedPlaceholder =  NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        passwordTextField.attributedPlaceholder =  NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        passwordTextField.isSecureTextEntry.toggle()
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        passwordAgainTextField.attributedPlaceholder =  NSAttributedString(string: "Password again", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        passwordAgainTextField.isSecureTextEntry.toggle()
        
        navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 0)
        navigationBar.setItems([navItem], animated: false)
        navigationBar.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        
        [separatorFirst, separatorSecond, separatorThird, separatorFourth, separatorFifth].forEach{
            ($0).backgroundColor = #colorLiteral(red: 0.5537394881, green: 0.8924116492, blue: 0.9830355048, alpha: 1)
            ($0).layer.cornerRadius = 2
            ($0).layer.borderColor = UIColor.black.cgColor
            ($0).layer.borderWidth = 0.5
            view.addSubview($0)
        }
        
        [firstNameTextField, secondNameTextField, emailTextField, passwordTextField, passwordAgainTextField].forEach{
            ($0).font = UIFont(name: "IndieFlower", size: 25)
            ($0).borderStyle = .none
            ($0).keyboardType = UIKeyboardType.default
            ($0).addTarget(nil, action: Selector(("FirstResponderAction")), for: .editingDidEndOnExit)
            ($0).textColor = UIColor.black
            ($0).autocapitalizationType = .none
            ($0).delegate = self
            view.addSubview($0)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        passwordImageIcon.image = UIImage(systemName: "eye.slash")
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        passwordImageIcon.frame = CGRect(x: -5, y: 0, width: UIImage(systemName: "eye.slash")!.size.width + 5, height: UIImage(systemName: "eye.slash")!.size.height + 3)
        passwordImageIcon.isUserInteractionEnabled = true
        passwordImageIcon.tintColor = #colorLiteral(red: 0.5537394881, green: 0.8924116492, blue: 0.9830355048, alpha: 1)
        passwordImageIcon.addGestureRecognizer(tapGestureRecognizer)
        contentView.addSubview(passwordImageIcon)
        
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(headLabel)
        view.addSubview(letsDoItButton)
        view.addSubview(errorLabel)
        contentView.addSubview(passwordImageIcon)
        self.setupToHideKeyboard()
        
        letsDoItButton.addTarget(self, action: #selector(didTapLetsDoItButton), for: .touchUpInside)
    }
    

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        headLabel.pin
            .top(view.pin.safeArea.top + 40)
            .sizeToFit()
            .hCenter()
        
        errorLabel.pin
            .hCenter()
            .horizontally(20)
            .bottom(view.pin.safeArea.bottom + 100)
            
        letsDoItButton.pin
            .bottom(view.pin.safeArea.bottom + 20)
            .hCenter()
        
        navigationBar.pin
            .top(view.pin.safeArea.top)
            .horizontally(0)
            .height(20)
        
        firstNameTextField.pin
            .horizontally(20)
            .height(60)
            .center(-180)
        
        secondNameTextField.pin
            .horizontally(20)
            .height(60)
            .center(-90)
        
        emailTextField.pin
            .horizontally(20)
            .height(60)
            .center()
        
        passwordTextField.pin
            .horizontally(20)
            .height(60)
            .center(90)
        
        passwordAgainTextField.pin
            .horizontally(20)
            .height(60)
            .center(180)

        separatorFirst.pin
            .below(of: firstNameTextField)
            .horizontally(20)
            .height(3)
        
        separatorSecond.pin
            .below(of: secondNameTextField)
            .horizontally(20)
            .height(3)
        
        separatorThird.pin
            .below(of: emailTextField)
            .horizontally(20)
            .height(3)
        
        separatorFourth.pin
            .below(of: passwordTextField)
            .horizontally(20)
            .height(3)
        
        separatorFifth.pin
            .below(of: passwordAgainTextField)
            .horizontally(20)
            .height(3)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func showErrorMessage(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHomeScreen(){
        let homeViewController = TabBarController()
        homeViewController.modalPresentationStyle = .fullScreen
        present(homeViewController, animated: true, completion: nil)
    }
    
    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func didTapLetsDoItButton(){
    
        let signUp = SignUpModel()
        signUp.signUp(firstNameTextField, secondNameTextField, emailTextField, passwordTextField, passwordAgainTextField) {[weak self] isSignUp,
                                                                                                                            errorMessage in
            if isSignUp == true {
                self?.transitionToHomeScreen()
                UserDefaults.standard.setValue(true, forKey: "isAuth")
            } else if isSignUp == false {
                self?.showErrorMessage(errorMessage ?? "Something went wrong, try again later")
            }
    }
}
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if imageClick {
            imageClick = false
            tappedImage.image = UIImage(systemName: "eye")
            passwordTextField.isSecureTextEntry = false
            passwordAgainTextField.isSecureTextEntry = false
        }
        else {
            imageClick = true
            tappedImage.image = UIImage(systemName: "eye.slash")
            passwordTextField.isSecureTextEntry = true
            passwordAgainTextField.isSecureTextEntry = true
        }
    }
    
    @objc private func keyboardShown(notification: Notification){
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.height - keyboardSize.height
        let editingTextFieldY = activeTextField.convert(activeTextField.bounds, to: self.view).minY
        if self.view.frame.minY >= 0{
            if editingTextFieldY > keyboardY - 60 {
                UIView.animate(withDuration: 0.3,
                               delay: 0.0,
                               options: UIView.AnimationOptions.curveEaseIn,
                               animations: {
                                self.view.frame = CGRect(x: 0,
                                                         y: self.view.frame.origin.y - (editingTextFieldY - (keyboardY - 70)),
                                                         width: self.view.bounds.width,
                                                         height: self.view.bounds.height)
                               },
                               completion: nil)
            }
        }
    }
    
    @objc private func keyboardHidden(notification: Notification){
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.view.frame = CGRect(x: 0,
                                                 y: 0,
                                                 width: self.view.bounds.width,
                                                 height: self.view.bounds.height)
                       },
                       completion: nil)
    }
}


