//
//  BookDetailsViewController.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 17.12.2024.
//

import UIKit
import SnapKit

class BookDetailsViewController: UIViewController {
    
    var book: Book

    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 35)
        label.textColor = .white
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    private let commentsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    private let commentsTextLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private var starButtons: [UIButton] = []

    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
       super.viewDidLoad()
       setupBackground()
       setupView()
       setupLayout()
   }
    
    private func setupView() {
        view.addSubview(bookImageView)
        view.addSubview(bookNameLabel)
        view.addSubview(authorLabel)
        view.addSubview(genreLabel)
        view.addSubview(commentsTitleLabel)
        view.addSubview(commentsTextLabel)

        if let grade = book.grade {
            displayGrade(grade)
        } else {
            createStarButtons()
        }
    }

    private func setupLayout() {
        bookImageView.image = UIImage(named: book.img)
        bookImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(130)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(350)
        }
        
        bookNameLabel.text = book.title
        bookNameLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(10)
            $0.centerX.equalTo(bookImageView)
        }

        authorLabel.text = book.author
        authorLabel.snp.makeConstraints {
            $0.bottom.equalTo(bookImageView.snp.top).offset(-20)
            $0.centerX.equalTo(bookImageView)
        }

        genreLabel.text = book.genre
        genreLabel.snp.makeConstraints {
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(bookImageView)
        }

        commentsTitleLabel.text = "Comments: "
        commentsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(20)
            $0.leading.equalTo(genreLabel)
        }

        commentsTextLabel.text = book.extraComments ?? "No extra comments"
        commentsTextLabel.snp.makeConstraints {
            $0.top.equalTo(commentsTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(genreLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.lessThanOrEqualTo(150)
        }
    }

    private func displayGrade(_ grade: Int) {
        let gradeLabel = UILabel()
        gradeLabel.text = String(repeating: "⭐ ", count: grade)
        gradeLabel.font = .systemFont(ofSize: 40)
        gradeLabel.textColor = .yellow
        view.addSubview(gradeLabel)
        gradeLabel.snp.makeConstraints {
            $0.top.equalTo(commentsTitleLabel.snp.bottom).offset(110)
            $0.leading.equalTo(commentsTitleLabel)
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
        for (index, button) in starButtons.enumerated() {
            button.snp.makeConstraints { make in
                make.top.equalTo(commentsTitleLabel.snp.bottom).offset(110)
                make.leading.equalTo(view).offset(16 + (index * 50))
                make.width.height.equalTo(40)
            }
        }
    }

    @objc private func starButtonTapped(_ sender: UIButton) {
        let selectedGrade = sender.tag
        book.grade = selectedGrade
        print("Grade set to \(selectedGrade) stars")
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
