//
//  SceneDelegate.swift
//  ReadingTracker
//
//  Created by Данькевич Анастасія on 15.12.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options
               connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        print("SceneDelegate: Scene connected")

        window = UIWindow(windowScene: windowScene)
        let launchVC = LaunchViewController()
        window?.rootViewController = launchVC
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.transitionToMainTabBarController()
        }
        
        print("SceneDelegate: Launch screen is visible")
    }
    
    private func transitionToMainTabBarController() {
        let mainTabBarController = MainTabBarController()
        guard let window = self.window else { return }
        UIView.transition(with: window, duration: 1.0, options: .transitionCrossDissolve, animations: {
            window.rootViewController = mainTabBarController
        }, completion: nil)
        
        print("SceneDelegate: Transitioned to MainTabBarController")
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
