//
//  ProfileView.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 18.12.2024.
//

import UIKit
import SnapKit

class ProfileView: UIView {

    let userImage: UIImageView = {
        let userImage = UIImageView(image: UIImage(named: "User_Profile"))
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = 125
        userImage.clipsToBounds = true
        return userImage
    }()

    let userName: UILabel = {
        let userName = UILabel()
        userName.text = "BookLover<3"
        userName.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        userName.textColor = .black
        userName.textAlignment = .center
        return userName
    }()

    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGreen
        button.layer.cornerRadius = 20
        return button
    }()

    let buttonText: UILabel = {
        let buttonText = UILabel()
        buttonText.text = "Hey, click here to see your activity - tree!"
        buttonText.font = UIFont.systemFont(ofSize: 18)
        buttonText.textColor = .black
        buttonText.textAlignment = .center
        buttonText.numberOfLines = 2
        return buttonText
    }()

    let buttonTree: UILabel = {
        let buttonTree = UILabel()
        buttonTree.text = "🌳"
        buttonTree.font = UIFont.systemFont(ofSize: 74)
        buttonTree.textColor = .black
        buttonTree.textAlignment = .center
        return buttonTree
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupDefaultGradientBackground(for: self)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupDefaultGradientBackground(for: self)
    }

    private func setupView() {
        button.addSubview(buttonText)
        button.addSubview(buttonTree)

        addSubview(userImage)
        addSubview(userName)
        addSubview(button)
    }

    private func setupLayout() {
        userImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(250)
        }

        userName.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }

        button.snp.makeConstraints {
            $0.top.equalTo(userName.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(200)
        }

        buttonText.snp.makeConstraints {
            $0.top.equalTo(button.snp.top).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
        }

        buttonTree.snp.makeConstraints {
            $0.centerY.equalTo(button.snp.centerY).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
