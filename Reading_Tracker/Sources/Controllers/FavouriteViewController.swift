//
//  FavouriteViewController.swift
//  Reading_Tracker
//
//  Created by Данькевич Анастасія on 16.12.2024.
//

import UIKit
import SwiftUI
import SnapKit

class FavouriteViewController: UIViewController {

    private var booksCollectionView: UICollectionView!
    private var quotesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()

        let favoriteBooksLabel = UILabel()
        favoriteBooksLabel.text = "Favourite Books"
        favoriteBooksLabel.font = UIFont.boldSystemFont(ofSize: 24)
        favoriteBooksLabel.textAlignment = .left
        favoriteBooksLabel.textColor = .black

        booksCollectionView = createCollectionView()

        let savedQuotesLabel = UILabel()
        savedQuotesLabel.text = "Saved Quotes"
        savedQuotesLabel.font = UIFont.boldSystemFont(ofSize: 24)
        savedQuotesLabel.textAlignment = .left
        savedQuotesLabel.textColor = .black

        quotesCollectionView = createCollectionView()

        let addQuoteButton = UIButton(type: .system)
        addQuoteButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addQuoteButton.tintColor = .black
        addQuoteButton.addTarget(self, action: #selector(didTapAddQuoteButton), for: .touchUpInside)
        let addQuoteAndQuotesStackView = UIStackView(arrangedSubviews: [addQuoteButton, quotesCollectionView])
        addQuoteAndQuotesStackView.axis = .horizontal
        addQuoteAndQuotesStackView.spacing = 16
        addQuoteAndQuotesStackView.alignment = .center

        let stackView = UIStackView(arrangedSubviews: [
            favoriteBooksLabel,
            booksCollectionView,
            savedQuotesLabel,
            addQuoteAndQuotesStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill

        view.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.bottom.lessThanOrEqualTo(view).offset(-20)
        }

        booksCollectionView.snp.makeConstraints {
            $0.height.equalTo(250)
        }

        quotesCollectionView.snp.makeConstraints {
            $0.height.equalTo(150)
        }

        addQuoteButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        do { try ProcessingQuoteJSON.shared.loadQuotes() } catch { }
        quotesCollectionView.reloadData()
    }

    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumLineSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }

    @objc private func didTapAddQuoteButton() {
        let alert = UIAlertController(
            title: "Add New Quote",
            message: "Enter the quote and its book",
            preferredStyle: .alert
        )

        alert.addTextField { textField in
            textField.placeholder = "Quote Text"
        }

        alert.addTextField { textField in
            textField.placeholder = "Book Title"
        }

        alert.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard
                let quoteText = alert.textFields?[0].text,
                let bookTitle = alert.textFields?[1].text,
                !quoteText.isEmpty,
                !bookTitle.isEmpty
            else {
                return
            }

            let newQuote = Quote(title: bookTitle, quote: quoteText)

            do {
                try ProcessingQuoteJSON.shared.addQuote(quote: newQuote)
                print("\(newQuote.title), \(newQuote.quote)")
                self.quotesCollectionView.reloadData()
            } catch {
                let errorAlert = UIAlertController(title: "Error",
                    message: "Failed to add quote: \(error.localizedDescription)", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(errorAlert, animated: true)
            }
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
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

extension FavouriteViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == booksCollectionView {
            return ProcessingBookJSON.shared.favouriteBooks().count
        } else {
            return ProcessingQuoteJSON.shared.amountOfQuotes()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == booksCollectionView {
            return configureBookCell(for: collectionView, at: indexPath)
        } else {
            return configureQuoteCell(for: collectionView, at: indexPath)
        }
    }

    private func configureBookCell(for collectionView: UICollectionView, at indexPath:
                        IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = 8

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let book = ProcessingBookJSON.shared.favouriteBooks()[indexPath.item]

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

        let label = UILabel()
        label.text = book.title
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .black
        cell.contentView.addSubview(label)

        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.left.equalTo(cell.contentView).offset(10)
            $0.right.equalTo(cell.contentView).offset(-10)
            $0.height.equalTo(cell.bounds.height * 0.3)
        }

        return cell
    }

    private func configureQuoteCell(for collectionView: UICollectionView, at indexPath:
                        IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        cell.layer.cornerRadius = 8
        cell.backgroundColor = .lightGreen

        let quote = ProcessingQuoteJSON.shared.quotes[indexPath.item]

        let label = UILabel()
        label.text = "“\(quote.quote)“"
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .black
        cell.contentView.addSubview(label)

        label.snp.makeConstraints {
            $0.top.equalTo(cell.contentView).offset(10)
            $0.left.equalTo(cell.contentView).offset(10)
            $0.right.equalTo(cell.contentView).offset(-10)
            $0.height.equalTo(cell.bounds.height * 0.6)
        }

        let labelTitle = UILabel()
        labelTitle.text = "from: “\(quote.title)“"
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        labelTitle.textColor = .gray
        cell.contentView.addSubview(labelTitle)

        labelTitle.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.left.equalTo(cell.contentView).offset(10)
            $0.right.equalTo(cell.contentView).offset(-10)
            $0.height.equalTo(20)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == quotesCollectionView {
            let quote = ProcessingQuoteJSON.shared.quotes[indexPath.item]
            let quoteDetailsVC = QuoteDetailsViewController(quote: quote)

            navigationController?.pushViewController(quoteDetailsVC, animated: true)
        }
    }
}
