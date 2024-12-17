//
//  SceneDelegate.swift
//  ReadingTracker
//
//  Created by Данькевич Анастасія on 15.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        print("SceneDelegate: Scene connected")

        window = UIWindow(windowScene: windowScene)
        let mainTabBarController = MainTabBarController()
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
        print("SceneDelegate: Window is visible")
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
