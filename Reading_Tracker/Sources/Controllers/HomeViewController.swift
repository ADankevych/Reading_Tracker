//
//  HomeViewController.swift
//  Reading_Tracker
//
//  Created by Данькевич Анастасія on 16.12.2024.
//

import UIKit
import SwiftUI
import SnapKit

protocol AddBookDelegate: AnyObject {
    func didAddNewBook(_ book: Book)
}

class HomeViewController: UIViewController {
    
    private var homeView: HomeView!
    
    override func loadView() {
        homeView = HomeView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView.addMyBooksCollectionView.delegate = self
        homeView.addMyBooksCollectionView.dataSource = self
        homeView.booksOfMonthCollectionView.delegate = self
        homeView.booksOfMonthCollectionView.dataSource = self
        homeView.programingBooksCollectionView.delegate = self
        homeView.programingBooksCollectionView.dataSource = self
        homeView.addMyBooksButton.addTarget(self, action: #selector(didTapAddMyBooksButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeView.addMyBooksCollectionView.reloadData()
    }
    
    @objc private func didTapAddMyBooksButton() {
        let addBookViewController = AddBookViewController()
        addBookViewController.delegate = self
        navigationController?.pushViewController(addBookViewController, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView.addMyBooksCollectionView {
            return ProcessingBookJSON.shared.gradedBooks().count
        } else if collectionView == homeView.booksOfMonthCollectionView {
            return 5
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView.addMyBooksCollectionView {
            return configureGradedBookCell(for: collectionView, at: indexPath)
        } else if collectionView == homeView.booksOfMonthCollectionView {
            return configureMonthBookCell(for: collectionView, at: indexPath)
        } else {
            return configureProgrammingBookCell(for: collectionView, at: indexPath)
        }
    }
   private func configureGradedBookCell(for collectionView: UICollectionView, at
                                        indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)

       cell.contentView.subviews.forEach { $0.removeFromSuperview() }

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
       
       if book.like {
           let heartIcon = UIImageView(image: UIImage(systemName: "heart.fill"))
           heartIcon.tintColor = .red
           cell.contentView.addSubview(heartIcon)

           heartIcon.snp.makeConstraints {
               $0.width.height.equalTo(20)
               $0.top.equalTo(cell.contentView).offset(15)
               $0.right.equalTo(cell.contentView).offset(-22)
           }
       }

       return cell
   }

   private func configureMonthBookCell(for collectionView: UICollectionView, at
                                       indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)

       let bookIndex = indexPath.item + 5
       guard bookIndex < ProcessingBookJSON.shared.books.count else {
           print("Error: Index out of bounds for booksOfMonthCollectionView. Index: \(bookIndex), Total Books: \(ProcessingBookJSON.shared.books.count)")
           return cell
       }

       let book = ProcessingBookJSON.shared.books[bookIndex]

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

   private func configureProgrammingBookCell(for collectionView: UICollectionView, at
                                             indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCell", for: indexPath)

       guard indexPath.item < ProcessingBookJSON.shared.books.count else {
           print("Error: Index out of bounds for programingBooksCollectionView. Index: \(indexPath.item), Total Books: \(ProcessingBookJSON.shared.books.count)")
           return cell
       }

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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var selectedBook: Book
        if collectionView == homeView.addMyBooksCollectionView {
            selectedBook = ProcessingBookJSON.shared.gradedBooks()[indexPath.item]
        } else if collectionView == homeView.booksOfMonthCollectionView {
            selectedBook = ProcessingBookJSON.shared.books[indexPath.item + 5]
        } else {
            selectedBook = ProcessingBookJSON.shared.books[indexPath.item]
        }
        
        let bookDetailsVC = BookDetailsViewController(book: selectedBook)
        bookDetailsVC.delegate = self
        navigationController?.pushViewController(bookDetailsVC, animated: true)
    }

}

extension HomeViewController: AddBookDelegate {
    func didAddNewBook(_ book: Book) {
        homeView.addMyBooksCollectionView.reloadData()
    }
}

extension HomeViewController: BookDetailsViewControllerDelegate {
    func didUpdateLikeState(for book: Book) {
        do {
            if book.like == true {
                try ProcessingBookJSON.shared.likedBook(book: book)
            } else {
                try ProcessingBookJSON.shared.dislikedBook(book: book)
            }
            homeView.addMyBooksCollectionView.reloadData()
            
        } catch {
            print("Error updating like state: \(error)")
        }
    }
}
