//
//  AddBookViewController.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 17.12.2024.
//

import UIKit
import SnapKit

class AddBookViewController: UIViewController {
    
    private let titleTextField = UITextField()
    private let authorTextField = UITextField()
    private let genreTextField = UITextField()
    private let commentsTextView = UITextView()
    private var rating: Int = 0
    private var starButtons: [UIButton] = []
    private let saveButton = UIButton(type: .system)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add New Book"
        label.font = .boldSystemFont(ofSize: 42)
        label.textAlignment = .center
        label.textColor = .darkGreen
        return label
    }()
    
    private let commentsPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Extra comments"
        label.font = .systemFont(ofSize: 22)
        label.textColor = .lightGray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        view.backgroundColor = .lightGreen
        
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        
        titleTextField.placeholder = "Enter book title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.font = .systemFont(ofSize: 32)
        
        authorTextField.placeholder = "Enter author name"
        authorTextField.borderStyle = .roundedRect
        authorTextField.font = .systemFont(ofSize: 26)
        
        genreTextField.placeholder = "Enter genre"
        genreTextField.borderStyle = .roundedRect
        genreTextField.font = .systemFont(ofSize: 26)
        
        commentsTextView.layer.borderColor = UIColor.lightGray.cgColor
        commentsTextView.layer.borderWidth = 3
        commentsTextView.layer.cornerRadius = 8
        commentsTextView.font = .systemFont(ofSize: 22)
        commentsTextView.delegate = self
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .bold)
        saveButton.setTitleColor(.black, for: .normal)
        
        createStarButtons()
        
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(authorTextField)
        view.addSubview(genreTextField)
        view.addSubview(commentsTextView)
        commentsTextView.addSubview(commentsPlaceholderLabel)
        view.addSubview(saveButton)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        authorTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(titleTextField)
        }
        
        genreTextField.snp.makeConstraints {
            $0.top.equalTo(authorTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(authorTextField)
        }
        
        let starSpacing: CGFloat = 35
        for (index, starButton) in starButtons.enumerated() {
            starButton.snp.makeConstraints {
                $0.top.equalTo(genreTextField.snp.bottom).offset(20)
                $0.leading.equalToSuperview().inset(20 + CGFloat(index) * (40 + starSpacing))
                $0.width.height.equalTo(50)
            }
        }
        
        commentsTextView.snp.makeConstraints {
            $0.top.equalTo(genreTextField).offset(120)
            $0.leading.trailing.equalTo(genreTextField)
            $0.height.equalTo(150)
        }
        
        commentsPlaceholderLabel.snp.makeConstraints {
            $0.top.leading.equalTo(commentsTextView).inset(8)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(commentsTextView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        
    }
    private func createStarButtons() {
        let starCount = 5
        
        for index in 0..<starCount {
            let starButton = UIButton()
            
            let normalStarImage = UIImage(systemName: "star")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
            let selectedStarImage = UIImage(systemName: "star.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
            starButton.setImage(normalStarImage, for: .normal)
            starButton.setImage(selectedStarImage, for: .selected)
            starButton.tintColor = .yellow
            
            starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            starButton.tag = index + 1
            starButtons.append(starButton)
            view.addSubview(starButton)
        }
    }
    
    @objc private func starButtonTapped(_ sender: UIButton) {
        rating = sender.tag
        updateStarButtons()
    }
    
    private func updateStarButtons() {
        for (index, button) in starButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    @objc private func saveButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty,
              let author = authorTextField.text, !author.isEmpty,
              let genre = genreTextField.text, !genre.isEmpty else {
            // TODO: handle invalid input
            return
        }
        
        let newBook = Book(
            title: title,
            author: author,
            genre: genre,
            extraComments: commentsTextView.text,
            img: "User_book",
            grade: rating,
            like: false
        )
        print("New book added: \(newBook.title)")
        
        dismiss(animated: true, completion: nil)
    }
}

extension AddBookViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentsPlaceholderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            commentsPlaceholderLabel.isHidden = false
        }
    }
}
