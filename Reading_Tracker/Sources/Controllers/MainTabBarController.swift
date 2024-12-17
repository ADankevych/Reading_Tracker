//
//  MainTabBarController.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 15.12.2024.
//

import UIKit
import SwiftUI

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainTabBarController loaded!")
        self.delegate = self
        let homeVC = HomeViewController()
        let homeIcon = UIImage(systemName: "house")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 26, weight: .medium, scale: .large))
        let homeNavController = UINavigationController(rootViewController: homeVC)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 0)

        let favouriteVC = FavouriteViewController()
        let favouriteNavController = UINavigationController(rootViewController: favouriteVC)
        let favIcon = UIImage(systemName: "heart")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 26, weight: .medium, scale: .large))
        favouriteNavController.tabBarItem = UITabBarItem(title: "Favourite", image: favIcon, tag: 1)

        let profileVC = ProfileViewController()
        let profileNavController = UINavigationController(rootViewController: profileVC)
        let profileIcon = UIImage(systemName: "person.crop.circle")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 26, weight: .medium, scale: .large))
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: profileIcon, tag: 2)

        viewControllers = [homeNavController, favouriteNavController, profileNavController]
        customizeTabBarAppearance()

        tabBar.setNeedsLayout()
        tabBar.layoutIfNeeded()

        if let tabBarFrame = tabBar.superview?.frame {
            var newFrame = tabBar.frame
            newFrame.origin.y = tabBarFrame.height - 200
            newFrame.size.height = 200
            tabBar.frame = newFrame
        }
    }

    private func customizeTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .lightGreen
        appearance.shadowColor = .black
        appearance.stackedLayoutAppearance.normal.iconColor = .darkGreen
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.darkGreen,
            .font: UIFont.systemFont(ofSize: 14)
        ]

        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

extension UIColor {
    static var darkGreen: UIColor {
        return UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
    }

    static var lightGreen: UIColor {
        return UIColor(red: 166/255, green: 215/255, blue: 106/255, alpha: 1.0)
    }
}

extension UITabBar {
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 100
        return sizeThatFits
    }
}

#if DEBUG

struct MainTabBarControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainTabBarController {
        return MainTabBarController()
    }

    func updateUIViewController(_ uiViewController: MainTabBarController, context: Context) {
        // No-op
    }
}

struct MainTabBarController_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarControllerPreview()
            .ignoresSafeArea()
    }
}

#endif
