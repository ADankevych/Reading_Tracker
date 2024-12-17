//
//  HomeViewController.swift
//  Reading_Tracker
//
//  Created by Данькевич Анастасія on 16.12.2024.
//

import UIKit
import SwiftUI
import SnapKit

class HomeViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
   }()
   
    private let contentView = UIView()
    private var addMyBooksCollectionView: UICollectionView!
    private var booksOfMonthCollectionView: UICollectionView!
    private var programingBooksCollectionView: UICollectionView!
   
    let gradientLayer = CAGradientLayer()
    let myBooksLable = UILabel()
    let booksOfMonth = UILabel()
    let programingBooks = UILabel()
    let addMyBooksButton = UIButton(type: .system)
   
    private var mainStackView: UIStackView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupLables()
        setupCollectionViews()
        setupButton()
        setupLayout()
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
   
   private func setupLables() {
       myBooksLable.text = "My Books"
       myBooksLable.font = UIFont.boldSystemFont(ofSize: 24)
       myBooksLable.textColor = .black
       myBooksLable.textAlignment = .left
       
       booksOfMonth.text = "Top - 5 books of the month"
       booksOfMonth.font = UIFont.boldSystemFont(ofSize: 24)
       booksOfMonth.textColor = .black
       booksOfMonth.textAlignment = .left
       
       programingBooks.text = "Top - 5 books about programming"
       programingBooks.font = UIFont.boldSystemFont(ofSize: 24)
       programingBooks.textColor = .black
       programingBooks.textAlignment = .left
   }
   
   private func setupButton() {
       addMyBooksButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
       addMyBooksButton.tintColor = .black
       addMyBooksButton.addTarget(self, action: #selector(didTapAddMyBooksButton), for: .touchUpInside)
   }
   
   @objc private func didTapAddMyBooksButton() {
       
   }
   
   private func setupCollectionViews() {
       addMyBooksCollectionView = createCollectionView()
       booksOfMonthCollectionView = createCollectionView()
       programingBooksCollectionView = createCollectionView()
       
       [addMyBooksCollectionView, booksOfMonthCollectionView, programingBooksCollectionView].forEach {
           $0.delegate = self
           $0.dataSource = self
       }
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
       view.addSubview(scrollView)
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
           myBooksLable,
           myBooksStack,
           booksOfMonth,
           booksOfMonthCollectionView,
           programingBooks,
           programingBooksCollectionView
       ])
       
       mainStackView.axis = .vertical
       mainStackView.spacing = 16
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if collectionView == addMyBooksCollectionView {
           return ProcessingBookJSON.shared.gradedBooks().count
       } else if collectionView == booksOfMonthCollectionView {
           return 5
       } else {
           return 5
       }
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if collectionView == addMyBooksCollectionView {
           return configureGradedBookCell(for: collectionView, at: indexPath)
       } else if collectionView == booksOfMonthCollectionView {
           return configureMonthBookCell(for: collectionView, at: indexPath)
       } else {
           return configureProgrammingBookCell(for: collectionView, at: indexPath)
       }
   }

   private func configureGradedBookCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)
      
       let book = ProcessingBookJSON.shared.gradedBooks()[indexPath.item]

       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFit
       imageView.layer.cornerRadius = 8
       imageView.clipsToBounds = true
       imageView.image = UIImage(named: book.img)
       cell.contentView.addSubview(imageView)

       imageView.snp.makeConstraints {
           $0.top.equalTo(cell.contentView).offset(5)
           $0.left.equalTo(cell.contentView).offset(5)
           $0.right.equalTo(cell.contentView).offset(-5)
           $0.height.equalTo(cell.bounds.height * 0.75)
       }

       let titleLabel = UILabel()
       titleLabel.text = book.title
       titleLabel.textAlignment = .center
       titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
       titleLabel.numberOfLines = 0
       titleLabel.textColor = .black
       cell.contentView.addSubview(titleLabel)

       titleLabel.snp.makeConstraints {
           $0.top.equalTo(imageView.snp.bottom).offset(5)
           $0.left.equalTo(cell.contentView).offset(5)
           $0.right.equalTo(cell.contentView).offset(-5)
       }

       let authorLabel = UILabel()
       authorLabel.text = book.author
       authorLabel.textAlignment = .center
       authorLabel.font = UIFont.systemFont(ofSize: 12)
       authorLabel.textColor = .black
       cell.contentView.addSubview(authorLabel)

       authorLabel.snp.makeConstraints {
           $0.top.equalTo(titleLabel.snp.bottom).offset(2)
           $0.left.equalTo(cell.contentView).offset(5)
           $0.right.equalTo(cell.contentView).offset(-5)
           $0.bottom.lessThanOrEqualToSuperview().offset(-5)
       }

       return cell
   }

   private func configureMonthBookCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)
    
       let book = ProcessingBookJSON.shared.books[indexPath.item + 5]

       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFit
       imageView.layer.cornerRadius = 8
       imageView.clipsToBounds = true
       imageView.image = UIImage(named: book.img)
       cell.contentView.addSubview(imageView)

       imageView.snp.makeConstraints {
           $0.top.equalTo(cell.contentView).offset(5)
           $0.left.equalTo(cell.contentView).offset(5)
           $0.right.equalTo(cell.contentView).offset(-5)
           $0.height.equalTo(cell.bounds.height * 0.7)
       }

       let titleLabel = UILabel()
       titleLabel.text = book.title
       titleLabel.textAlignment = .center
       titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
       titleLabel.numberOfLines = 0
       titleLabel.textColor = .black
       cell.contentView.addSubview(titleLabel)

       titleLabel.snp.makeConstraints {
           $0.top.equalTo(imageView.snp.bottom).offset(5)
           $0.left.equalTo(cell.contentView).offset(5)
           $0.right.equalTo(cell.contentView).offset(-5)
       }

       let authorLabel = UILabel()
       authorLabel.text = book.author
       authorLabel.textAlignment = .center
       authorLabel.font = UIFont.systemFont(ofSize: 12)
       authorLabel.textColor = .black
       cell.contentView.addSubview(authorLabel)

       authorLabel.snp.makeConstraints {
           $0.top.equalTo(titleLabel.snp.bottom).offset(2)
           $0.left.equalTo(cell.contentView).offset(5)
           $0.right.equalTo(cell.contentView).offset(-5)
           $0.bottom.lessThanOrEqualToSuperview().offset(-5)
       }

       return cell
   }

   private func configureProgrammingBookCell(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)
       
       let book = ProcessingBookJSON.shared.books[indexPath.item]

       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFit
       imageView.layer.cornerRadius = 8
       imageView.clipsToBounds = true
       imageView.image = UIImage(named: book.img)
       cell.contentView.addSubview(imageView)

       imageView.snp.makeConstraints {
           $0.top.equalTo(cell.contentView).offset(5)
           $0.left.equalTo(cell.contentView).offset(5)
           $0.right.equalTo(cell.contentView).offset(-5)
           $0.height.equalTo(cell.bounds.height * 0.7)
       }

       let titleLabel = UILabel()
       titleLabel.text = book.title
       titleLabel.textAlignment = .center
       titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
       titleLabel.numberOfLines = 0
       titleLabel.textColor = .black
       cell.contentView.addSubview(titleLabel)

       titleLabel.snp.makeConstraints {
           $0.top.equalTo(imageView.snp.bottom).offset(5)
           $0.left.equalTo(cell.contentView).offset(5)
           $0.right.equalTo(cell.contentView).offset(-5)
       }

       let authorLabel = UILabel()
       authorLabel.text = book.author
       authorLabel.textAlignment = .center
       authorLabel.font = UIFont.systemFont(ofSize: 12)
       authorLabel.textColor = .black
       cell.contentView.addSubview(authorLabel)

       authorLabel.snp.makeConstraints {
           $0.top.equalTo(titleLabel.snp.bottom).offset(2)
           $0.left.equalTo(cell.contentView).offset(5)
           $0.right.equalTo(cell.contentView).offset(-5)
           $0.bottom.lessThanOrEqualToSuperview().offset(-5)
       }

       return cell
   }
}
