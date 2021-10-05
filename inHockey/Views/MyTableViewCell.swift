//
//  MyTableViewCell.swift
//  inHockey
//
//  Created by Георгий on 25.09.2021.
//

import UIKit

final class MyTableViewCell: UITableViewCell {
    
    static let identifier: String = "MyTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      func setup() {
        selectionStyle = .none
        textLabel?.font = UIFont(name: "IndieFlower", size: 25)
        textLabel?.textColor = .black
    }
}
