//
//  LaunchViewController.swift
//  Reading_Tracker
//
//  Created by Mac on 17.12.2024.
//

import UIKit

class LaunchViewController: UIViewController {
    private var launchView: LaunchView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLaunchView()
        createHillAnimation()
        createTreeAndCrownAnimations()
    }

    private func setupLaunchView() {
        launchView = LaunchView(frame: view.bounds)
        view.addSubview(launchView)
    }

    private func createHillAnimation() {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = launchView.makeHill(height: 0).cgPath
        animation.toValue = launchView.makeHill(height: 30).cgPath
        animation.duration = 1.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        launchView.hillLayer.add(animation, forKey: "hillGrowth")
    }

    private func createTreeAndCrownAnimations() {
        let treeAnimation = CAKeyframeAnimation(keyPath: "path")
        treeAnimation.duration = 3.0
        treeAnimation.values = [
            launchView.makeTree(height: 0).cgPath,
            launchView.makeTree(height: 5).cgPath,
            launchView.makeTree(height: 20).cgPath,
            launchView.makeTree(height: 50).cgPath,
            launchView.makeTree(height: 100).cgPath,
            launchView.makeTree(height: 150).cgPath
        ]
        treeAnimation.keyTimes = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        treeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        treeAnimation.fillMode = .forwards
        treeAnimation.isRemovedOnCompletion = false

        let leafAnimation = CAKeyframeAnimation(keyPath: "path")
        leafAnimation.duration = 3.0
        leafAnimation.values = [
            launchView.makeLeaf(scale: 0).cgPath,
            launchView.makeLeaf(scale: 0).cgPath,
            launchView.makeLeaf(scale: 0).cgPath,
            launchView.makeLeaf(scale: 0.3).cgPath,
            launchView.makeLeaf(scale: 0.6).cgPath,
            launchView.makeLeaf(scale: 1.0).cgPath
        ]
        leafAnimation.keyTimes = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        leafAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        leafAnimation.fillMode = .forwards
        leafAnimation.isRemovedOnCompletion = false

        launchView.treeLayer.add(treeAnimation, forKey: "treeGrowth")
        launchView.leafLayer.add(leafAnimation, forKey: "leafGrowth")
    }
}
