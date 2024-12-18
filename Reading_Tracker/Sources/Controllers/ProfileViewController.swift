//
//  ProfileViewController.swift
//  Reading_Tracker
//
//  Created by Данькевич Анастасія on 16.12.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    private let profileView = ProfileView()

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    private func setupActions() {
        profileView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        let treeViewController = TreeViewController()
        navigationController?.pushViewController(treeViewController, animated: true)
    }
}
