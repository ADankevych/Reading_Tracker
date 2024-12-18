//
//  HomeView.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 18.12.2024.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    let contentView = UIView()
    let gradientLayer = CAGradientLayer()
    
    let myBooksLabel = UILabel()
    let booksOfMonthLabel = UILabel()
    let programingBooksLabel = UILabel()
    let addMyBooksButton = UIButton(type: .system)
    
    var addMyBooksCollectionView: UICollectionView!
    var booksOfMonthCollectionView: UICollectionView!
    var programingBooksCollectionView: UICollectionView!
    
    var mainStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaultGradientBackground(for: self)
        setupLabels()
        setupCollectionViews()
        setupButton()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupDefaultGradientBackground(for: self)
    }
    
    private func setupLabels() {
        myBooksLabel.attributedText = NSAttributedString(string: "My Books", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        myBooksLabel.font = UIFont.boldSystemFont(ofSize: 24)
        myBooksLabel.textColor = .black
        myBooksLabel.textAlignment = .left
        
        booksOfMonthLabel.attributedText = NSAttributedString(string: "Top - 5 books of the month", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        booksOfMonthLabel.font = .boldSystemFont(ofSize: 24)
        booksOfMonthLabel.textColor = .black
        booksOfMonthLabel.textAlignment = .left
        
        programingBooksLabel.attributedText = NSAttributedString(string: "Top - 5 books about programming", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        programingBooksLabel.font = .boldSystemFont(ofSize: 24)
        programingBooksLabel.textColor = .black
        programingBooksLabel.textAlignment = .left
    }
    
    private func setupButton() {
        addMyBooksButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addMyBooksButton.tintColor = .black
    }
    
    private func setupCollectionViews() {
        addMyBooksCollectionView = createCollectionView()
        booksOfMonthCollectionView = createCollectionView()
        programingBooksCollectionView = createCollectionView()
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "BookCell")
        return collectionView
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        let myBooksStack = UIStackView(arrangedSubviews: [addMyBooksButton, addMyBooksCollectionView])
        myBooksStack.axis = .horizontal
        myBooksStack.alignment = .center
        
        mainStackView = UIStackView(arrangedSubviews: [
            myBooksLabel,
            myBooksStack,
            booksOfMonthLabel,
            booksOfMonthCollectionView,
            programingBooksLabel,
            programingBooksCollectionView
        ])
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 20
        mainStackView.alignment = .fill
        
        contentView.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        addMyBooksCollectionView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        booksOfMonthCollectionView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        programingBooksCollectionView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        addMyBooksButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
    }
}
