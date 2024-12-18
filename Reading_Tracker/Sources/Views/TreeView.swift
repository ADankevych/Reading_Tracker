//
//  TreeView.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 18.12.2024.
//


import UIKit
import SnapKit

class TreeView: UIView {

    
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        setupDefaultGradientBackground(for: self)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupLayout()
        setupDefaultGradientBackground(for: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupDefaultGradientBackground(for: self)
    }

    private func setupView() {
        addSubview(booksReadLabel)
    }

    private func setupLayout() {
        booksReadLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
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

    func updateBooksReadLabel(numberOfBooks: Int) {
        if numberOfBooks == 0 {
            booksReadLabel.text = " \(numberOfBooks) book \n Looking like \n a lot of work to do😉 "
        } else if numberOfBooks == 1 {
            booksReadLabel.text = " \(numberOfBooks) book \n Yay😍"
        } else {
            booksReadLabel.text = " \(numberOfBooks) books \n Yay🥳"
        }
        booksReadLabel.font = .boldSystemFont(ofSize: 32)
    }

    func addTreeImage(for bookCount: Int) {
        let treeImageName = getTreeImage(for: bookCount)
        guard let treeImage = treeImageName else { return }

        let treeImageView = UIImageView()
        treeImageView.image = UIImage(named: treeImage)
        treeImageView.contentMode = .scaleAspectFit
        treeImageView.layer.cornerRadius = 10
        treeImageView.clipsToBounds = true
        let treeSize = treeImageSize(for: treeImage)

        let hillPath = makeHill(height: bounds.height)
        let hillRect = hillPath.bounds

        treeImageView.frame = CGRect(
            x: (bounds.width - treeSize.width) / 2,
            y: hillRect.origin.y - treeSize.height,
            width: treeSize.width,
            height: treeSize.height
        )

        addSubview(treeImageView)
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

    private func setupDefaultGradientBackground(for view: UIView) {
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
