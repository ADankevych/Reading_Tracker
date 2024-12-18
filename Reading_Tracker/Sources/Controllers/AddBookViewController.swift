//
//  AddBookViewController.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 17.12.2024.
//

import UIKit

class AddBookViewController: UIViewController {

    weak var delegate: AddBookDelegate?

    private let addBookView = AddBookView()
    private var rating: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view = addBookView
        setupActions()
    }

    private func setupActions() {
        addBookView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        for starButton in addBookView.starButtons {
            starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        }
    }

    @objc private func starButtonTapped(_ sender: UIButton) {
        rating = sender.tag
        updateStarButtons()
    }

    private func updateStarButtons() {
        for (index, button) in addBookView.starButtons.enumerated() {
            button.isSelected = index < rating
        }
    }

    @objc private func saveButtonTapped() {
        guard let title = addBookView.titleTextField.text, !title.isEmpty,
              let author = addBookView.authorTextField.text, !author.isEmpty,
              let genre = addBookView.genreTextField.text, !genre.isEmpty else {
            return
        }

        let newBook = Book(
            title: title,
            author: author,
            genre: genre,
            extraComments: addBookView.commentsTextView.text,
            img: "User_book",
            grade: rating,
            like: false
        )
        
        do {
            try ProcessingBookJSON.shared.addBook(userBook: newBook)
            delegate?.didAddNewBook(newBook)
        } catch {
            print("Error adding new book: \(error)")
        }
        
        navigationController?.popViewController(animated: true)
    }
}
