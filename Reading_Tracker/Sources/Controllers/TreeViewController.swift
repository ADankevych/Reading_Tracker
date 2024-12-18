//
//  TreeViewController.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 17.12.2024.
//

import UIKit
import SwiftUI
import SnapKit

class TreeViewController: UIViewController {
    
    private let bookImages = [
        "tree_1", // 1 book
        "tree_2", // 2 to 3 books
        "tree_3", // 4 to 5 books
        "tree_4", // 7 to 9 books
        "tree_5"  // 10 books
    ]
    
    private let booksReadLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

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
    
    private func getTreeImage(for bookCount: Int) -> String? {
        if bookCount == 0 {
            return nil
        }
        let cycleCount = bookCount % 10

        switch cycleCount {
        case 1:
            return bookImages[0]
        case 2, 3:
            return bookImages[1]
        case 4, 5:
            return bookImages[2]
        case 6, 7, 8, 9:
            return bookImages[3]
        case 0:
            return bookImages[4]
        default:
            return bookImages[0]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        setupLayout()
        drawHill()
        addTreeImage()
        updateBooksReadLabel()
    }
    
    private func setupLayout() {
        view.addSubview(booksReadLabel)
        booksReadLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
    }

    private func drawHill() {
        let hillPath = makeHill(height: 300)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = hillPath.cgPath
        shapeLayer.fillColor = UIColor(red: 0.196, green: 0.449, blue: 0.133, alpha: 0.9).cgColor

        view.layer.addSublayer(shapeLayer)
    }

    private func addTreeImage() {
        let numberOfBooks = ProcessingBookJSON.shared.gradedBooks().count
        if let treeImageName = getTreeImage(for: numberOfBooks) {
            let treeImageView = UIImageView()
            treeImageView.image = UIImage(named: treeImageName)
            treeImageView.contentMode = .scaleAspectFit
            treeImageView.layer.cornerRadius = 10
            treeImageView.clipsToBounds = true
            let treeSize = treeImageSize(for: treeImageName)

            let hillPath = makeHill(height: view.bounds.height)
            let hillRect = hillPath.bounds
            
            treeImageView.frame = CGRect(
                x: (view.bounds.width - treeSize.width) / 2,
                y: hillRect.origin.y - treeSize.height,
                width: treeSize.width,
                height: treeSize.height
            )

            view.addSubview(treeImageView)
        } else {
            print("No image because there are 0 books.")
        }
    }

    private func treeImageSize(for treeImageName: String) -> CGSize {
        switch treeImageName {
        case "tree_1":
            return CGSize(width: 46, height: 51)
        case "tree_2":
            return CGSize(width: 48, height: 122)
        case "tree_3":
            return CGSize(width: 120, height: 214)
        case "tree_4":
            return CGSize(width: 167, height: 328)
        case "tree_5":
            return CGSize(width: 454, height: 470)
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    
    private func updateBooksReadLabel() {
        let numberOfBooks = ProcessingBookJSON.shared.gradedBooks().count
        booksReadLabel.text = " \(numberOfBooks) books \n Yay🥳"
        booksReadLabel.font = .boldSystemFont(ofSize: 32)
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
