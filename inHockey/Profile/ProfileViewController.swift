//
//  ProfileViewController.swift
//  inHockey
//
//  Created by Георгий on 28.09.2021.
//  
//

import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    
    private let tableView = UITableView()
    private let titleLabels: [String] = ["Personal Stats", "Team stats", "Settings"]
    private let logOutButton = UIButton()
    private let imageButton = LoadingButtonImage()
    private let nameLabel = UILabel()
	private let output: ProfileViewOutput
   

    init(output: ProfileViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupTableView()
        setupLogOutButton()
        setupImageButton()
        
        output.didLoadView()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logOutButton.pin
            .top(view.pin.safeArea.top + 10)
            .right(view.pin.safeArea.left + 20)
            .size(CGSize(width: 35, height: 25))
        
        imageButton.pin
            .top(view.pin.safeArea.top + 40)
            .hCenter()
            .size(CGSize(width: 150, height: 150))
        
        nameLabel.pin
            .below(of: imageButton)
            .marginTop(30)
            .hCenter()
            .width(view.frame.width)
            .height(50)
        
    }
    
    private func setupTableView() {
        tableView.frame = CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: 300)
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.identifier)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    private func setupLogOutButton() {
        
        logOutButton.setImage(UIImage(systemName: "person.fill.xmark"), for: .normal)
        logOutButton.tintColor = #colorLiteral(red: 0.9254902005, green: 0.4224890755, blue: 0.3696719875, alpha: 1)
        logOutButton.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
        logOutButton.contentVerticalAlignment = .fill
        logOutButton.contentHorizontalAlignment = .fill
        logOutButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.addSubview(logOutButton)
    }
    
    private func setupImageButton() {
        imageButton.addTarget(self, action: #selector(didTapAvatarButton), for: .touchUpInside)
        imageButton.setImage(UIImage(named: "defaultAvatar"), for: .normal)
        imageButton.layer.borderWidth = 1
        imageButton.layer.cornerRadius = 70
        imageButton.layer.borderColor = UIColor.black.cgColor
        imageButton.contentVerticalAlignment = .fill
        imageButton.contentHorizontalAlignment = .fill
        imageButton.imageView?.contentMode = .scaleAspectFit
        imageButton.layer.masksToBounds = true
        imageButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        view.addSubview(imageButton)
    }
    
    @objc private func didTapLogOutButton() {
        output.didTapLogOutButton()
    }
    
    @objc private func didTapAvatarButton() {
        output.didTapAvatarButton()
    }
    
    func setupAvatar(with avatarID: String) {
        imageButton.setImage(imageID: avatarID) { _ in }
    }
    
    func setupNameLabel(with name: (String, String)) {
        nameLabel.text = "\(name.0) \(name.1)"
        nameLabel.font = UIFont(name: "IndieFlower", size: 35)
        nameLabel.textColor = .black
        nameLabel.textAlignment = NSTextAlignment.center
        view.addSubview(nameLabel)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as? MyTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = titleLabels[indexPath.row]
        
        cell.setup()
        return cell
    }
}

extension ProfileViewController: ProfileViewInput {
 
}
