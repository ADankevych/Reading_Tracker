//
//  AddBookView.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 18.12.2024.
//

import UIKit
import SnapKit

class AddBookView: UIView {
    let titleTextField = UITextField()
    let authorTextField = UITextField()
    let genreTextField = UITextField()
    let commentsTextView = UITextView()
    let saveButton = UIButton(type: .system)
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add New Book"
        label.font = .boldSystemFont(ofSize: 42)
        label.textAlignment = .center
        label.textColor = .darkGreen
        return label
    }()
    let commentsPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Extra comments"
        label.font = .systemFont(ofSize: 22)
        label.textColor = .lightGray
        return label
    }()
    var starButtons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupDefaultGradientBackground(for: self)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaultGradientBackground(for: self)
        setupView()
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupDefaultGradientBackground(for: self)
    }

    private func setupView() {
        layer.cornerRadius = 20
        layer.masksToBounds = true

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
    
        textViewDidChange(commentsTextView)

        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .bold)
        saveButton.setTitleColor(.black, for: .normal)
        
        createStarButtons()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            commentsPlaceholderLabel.isHidden = false
        } else {
            commentsPlaceholderLabel.isHidden = true
        }
    }

    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(titleTextField)
        addSubview(authorTextField)
        addSubview(genreTextField)
        addSubview(commentsTextView)
        addSubview(saveButton)
        commentsTextView.addSubview(commentsPlaceholderLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(150)
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
            let normalStarImage = UIImage(systemName: "star")?.withConfiguration(
                UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
            let selectedStarImage = UIImage(systemName: "star.fill")?.withConfiguration(
                UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
            starButton.setImage(normalStarImage, for: .normal)
            starButton.setImage(selectedStarImage, for: .selected)
            starButton.tintColor = .yellow
            starButton.tag = index + 1
            starButtons.append(starButton)
            addSubview(starButton)
        }
    }
}
