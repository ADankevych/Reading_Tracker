//
//  BackgroungSetup.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 18.12.2024.
//

import UIKit

func setupDefaultGradientBackground(for view: UIView) {
    let gradientLayer = CAGradientLayer()
    
    gradientLayer.colors = [
        UIColor(red: 0.66, green: 0.88, blue: 0.44, alpha: 1.0).cgColor,
        UIColor(red: 0.22, green: 0.44, blue: 0.11, alpha: 1.0).cgColor
    ]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    gradientLayer.frame = view.bounds

    view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
    view.layer.insertSublayer(gradientLayer, at: 0)
    view.layer.masksToBounds = true
}
