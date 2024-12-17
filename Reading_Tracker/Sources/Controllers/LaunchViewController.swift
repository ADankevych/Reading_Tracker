//
//  LaunchViewController.swift
//  Reading_Tracker
//
//  Created by Mac on 17.12.2024.
//

import UIKit
import SwiftUI
import SnapKit

class LaunchViewController: UIViewController {
    let gradientLayer = CAGradientLayer()
    let hillLayer = CAShapeLayer()
    let treeLayer = CAShapeLayer()
    let leafLayer = CAShapeLayer()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ReLeaf"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupViews()
        setupLayers()
        createHillAnimation()
        createTreeAndCrownAnimations()
    }

    private func setupGradient() {
        gradientLayer.frame = view.bounds

        gradientLayer.colors = [
            UIColor(red: 0.66, green: 0.88, blue: 0.44, alpha: 1.0).cgColor,
            UIColor(red: 0.22, green: 0.44, blue: 0.11, alpha: 1.0).cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupViews() {

        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            $0.centerX.equalTo(view)
        }
    }

    private func setupLayers() {

        hillLayer.fillColor = UIColor(red: 0.196, green: 0.449, blue: 0.133, alpha: 0.42).cgColor
        hillLayer.path = UIBezierPath().cgPath
        view.layer.addSublayer(hillLayer)

        treeLayer.fillColor = UIColor(red: 0.318, green: 0.271, blue: 0.184, alpha: 1.0).cgColor
        treeLayer.path = UIBezierPath().cgPath
        view.layer.addSublayer(treeLayer)

//        leafLayer.fillColor = UIColor(red: 0.8, green: 0.9, blue: 0.4, alpha: 1.0).cgColor
        leafLayer.fillColor = UIColor(red: 0.733, green: 0.922, blue: 0.471, alpha: 1.0).cgColor
        leafLayer.path = UIBezierPath().cgPath
        view.layer.addSublayer(leafLayer)
    }

    private func makeHill(height: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let width = view.bounds.width
        let maxY = view.bounds.height - 30
        let centerY = maxY + 300

        path.move(to: CGPoint(x: 0, y: maxY + 30))
        path.addArc(
            withCenter: CGPoint(x: width/2, y: centerY),
            radius: width * 1.2,
            startAngle: 180,
            endAngle: 0,
            clockwise: true
        )
        path.addLine(to: CGPoint(x: width, y: maxY + 30))
        path.addLine(to: CGPoint(x: 0, y: maxY + 30))
        path.close()

        return path
    }

    private func makeTree(height: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let centerX = view.bounds.midX
        let bottomY = view.bounds.height - 210
        let bottomWidth: CGFloat = 15
        let topWidth: CGFloat = 8

        path.move(to: CGPoint(x: centerX - bottomWidth/2, y: bottomY))
        path.addLine(to: CGPoint(x: centerX - topWidth/2, y: bottomY - height))
        path.addLine(to: CGPoint(x: centerX + topWidth/2, y: bottomY - height))
        path.addLine(to: CGPoint(x: centerX + bottomWidth/2, y: bottomY))
        path.close()

           return path
       }

    private func makeLeaf(scale: CGFloat) -> UIBezierPath {
        let centerX = view.bounds.midX
        let centerY = view.bounds.height - 390
        let radius: CGFloat = 80 * scale

        return UIBezierPath(
            arcCenter: CGPoint(x: centerX, y: centerY),
            radius: radius,
            startAngle: 0,
            endAngle: 360,
            clockwise: true
        )
    }

    private func createHillAnimation() {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = makeHill(height: 0).cgPath
        animation.toValue = makeHill(height: 30).cgPath
        animation.duration = 1.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        hillLayer.add(animation, forKey: "hillGrowth")
    }

    private func createTreeAndCrownAnimations() {
        let treeAnimation = CAKeyframeAnimation(keyPath: "path")
        treeAnimation.duration = 3.0
        treeAnimation.values = [
            makeTree(height: 0).cgPath,
            makeTree(height: 5).cgPath,
            makeTree(height: 20).cgPath,
            makeTree(height: 50).cgPath,
            makeTree(height: 100).cgPath,
            makeTree(height: 150).cgPath
        ]
        treeAnimation.keyTimes = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        treeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        treeAnimation.fillMode = .forwards
        treeAnimation.isRemovedOnCompletion = false

        let leafAnimation = CAKeyframeAnimation(keyPath: "path")
        leafAnimation.duration = 3.0
        leafAnimation.values = [
            makeLeaf(scale: 0).cgPath,
            makeLeaf(scale: 0).cgPath,
            makeLeaf(scale: 0).cgPath,
            makeLeaf(scale: 0.3).cgPath,
            makeLeaf(scale: 0.6).cgPath,
            makeLeaf(scale: 1.0).cgPath
        ]
        leafAnimation.keyTimes = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        leafAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        leafAnimation.fillMode = .forwards
        leafAnimation.isRemovedOnCompletion = false

        treeLayer.add(treeAnimation, forKey: "treeGrowth")
        leafLayer.add(leafAnimation, forKey: "leafGrowth")
    }
}

#if DEBUG

struct LaunchViewControllerPreviews: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LaunchViewController {
        return LaunchViewController()
    }

    func updateUIViewController(_ uiViewController: LaunchViewController, context: Context) {
        // No-op
    }
}

struct LaunchViewController_Previews: PreviewProvider {
    static var previews: some View {
        LaunchViewControllerPreviews()
            .ignoresSafeArea()
    }
}

#endif
