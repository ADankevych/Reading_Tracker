//
//  LaunchView.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 18.12.2024.
//


import UIKit
import SnapKit

class LaunchView: UIView {
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

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupDefaultGradientBackground(for: self)
        setupViews()
        setupLayers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupDefaultGradientBackground(for: self)
    }

    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(200)
            $0.centerX.equalTo(self)
        }
    }

    private func setupLayers() {
        hillLayer.fillColor = UIColor(red: 0.196, green: 0.449, blue: 0.133, alpha: 0.42).cgColor
        hillLayer.path = UIBezierPath().cgPath
        layer.addSublayer(hillLayer)

        treeLayer.fillColor = UIColor(red: 0.318, green: 0.271, blue: 0.184, alpha: 1.0).cgColor
        treeLayer.path = UIBezierPath().cgPath
        layer.addSublayer(treeLayer)

        leafLayer.fillColor = UIColor(red: 0.733, green: 0.922, blue: 0.471, alpha: 1.0).cgColor
        leafLayer.path = UIBezierPath().cgPath
        layer.addSublayer(leafLayer)
    }

    private func makeHill(height: CGFloat) -> UIBezierPath {
       let path = UIBezierPath()
       let width = bounds.width
       let maxY = bounds.height - 30
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
       let centerX = bounds.midX
       let bottomY = bounds.height - 210
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
           let centerX = bounds.midX
           let centerY = bounds.height - 390
           let radius: CGFloat = 80 * scale
           
           return UIBezierPath(
               arcCenter: CGPoint(x: centerX, y: centerY),
               radius: radius,
               startAngle: 0,
               endAngle: 360,
               clockwise: true
           )
       }
}
