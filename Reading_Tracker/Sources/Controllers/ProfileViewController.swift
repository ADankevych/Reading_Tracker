//
//  ProfileViewController.swift
//  Reading_Tracker
//
//  Created by Данькевич Анастасія on 16.12.2024.
//

import UIKit
import SwiftUI
import SnapKit


class ProfileViewController: UIViewController {

    private let userImage: UIImageView = {
        let userImage = UIImageView(image: UIImage(named: "User_Profile"))
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = 125
        userImage.clipsToBounds = true
        return userImage
    }()

    private let userName: UILabel = {
        let userName = UILabel()
        userName.text = "BookLover<3"
        userName.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        userName.textColor = .black
        userName.textAlignment = .center
        return userName
    }()

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightGreen
        button.layer.cornerRadius = 20
        button.addTarget(ProfileViewController.self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    private let buttonText: UILabel = {
        let buttonText = UILabel()
        buttonText.text = "Hey, click here to see your activity - tree!"
        buttonText.font = UIFont.systemFont(ofSize: 18)
        buttonText.textColor = .black
        buttonText.textAlignment = .center
        buttonText.numberOfLines = 2
        return buttonText
    }()

    private let buttonTree: UILabel = {
        let buttonTree = UILabel()
        buttonTree.text = "🌳"
        buttonTree.font = UIFont.systemFont(ofSize: 74)
        buttonTree.textColor = .black
        buttonTree.textAlignment = .center
        return buttonTree
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        setupView()
        setupLayout()
    }

    @objc private func buttonTapped() {
        let treeViewController = TreeViewController()
        navigationController?.pushViewController(treeViewController, animated: true)
    }

    private func setupView() {
        button.addSubview(buttonText)
        button.addSubview(buttonTree)

        view.addSubview(userImage)
        view.addSubview(userName)
        view.addSubview(button)
    }

    private func setupLayout() {
        userImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
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

    private func setupBackground() {
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = view.bounds

        gradientLayer.colors = [
            UIColor(red: 0.66, green: 0.88, blue: 0.44, alpha: 1.0).cgColor,
            UIColor(red: 0.22, green: 0.44, blue: 0.11, alpha: 1.0).cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
