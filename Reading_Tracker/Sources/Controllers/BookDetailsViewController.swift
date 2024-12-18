//
//  BookDetailsViewController.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 17.12.2024.
//

import UIKit
import SnapKit

protocol BookDetailsViewControllerDelegate: AnyObject {
    func didUpdateLikeState(for book: Book)
}

class BookDetailsViewController: UIViewController {
    
    var book: Book
    weak var delegate: BookDetailsViewControllerDelegate?
    private let bookDetailsView: BookDetailsView
    
    init(book: Book) {
        self.book = book
        self.bookDetailsView = BookDetailsView(book: book)
        super.init(nibName: nil, bundle: nil)
        bookDetailsView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookDetailsView.updateLikeButtonAppearance(isLiked: book.like)
    }

    private func setupView() {
        view.addSubview(bookDetailsView)
        bookDetailsView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension BookDetailsViewController: BookDetailsViewDelegate {
    func didTapLikeButton() {
        do {
            if book.like {
                book.like = false
                try ProcessingBookJSON.shared.dislikedBook(book: book)
            } else {
                book.like = true
                try ProcessingBookJSON.shared.likedBook(book: book)
            }
        } catch {
            print("Error saving like state: \(error)")
        }

        bookDetailsView.updateLikeButtonAppearance(isLiked: book.like)
        delegate?.didUpdateLikeState(for: book)

        if !book.like {
            navigationController?.popViewController(animated: true)
        }
    }

    func didSetGrade(to grade: Int) {
        book.grade = grade
        do { try ProcessingBookJSON.shared.gradeBook(book: book, grade: grade) } catch { }
    }
}
