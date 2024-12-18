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
    
    private var isLiked: Bool = false

    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let bookNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let commentsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let commentsTextLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let normalHeartImage = UIImage(systemName: "heart")?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        let filledHeartImage = UIImage(systemName: "heart.fill")?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 40, weight: .heavy))
        
        button.setImage(normalHeartImage, for: .normal)
        button.setImage(filledHeartImage, for: .highlighted)
        button.tintColor = .black
        button.backgroundColor = .clear
        return button
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
        view.addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        updateLikeButtonAppearance()

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
            $0.width.lessThanOrEqualTo(320)
        }

        authorLabel.text = book.author
        authorLabel.snp.makeConstraints {
            $0.bottom.equalTo(bookImageView.snp.top).offset(-20)
            $0.centerX.equalTo(bookImageView)
            $0.width.lessThanOrEqualTo(350)
        }

        genreLabel.text = book.genre
        genreLabel.snp.makeConstraints {
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(bookImageView)
        }

        if book.grade != nil {
            commentsTitleLabel.text = "Comments: "
            commentsTextLabel.text = book.extraComments
        }
        commentsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(20)
            $0.leading.equalTo(genreLabel)
        }

        commentsTextLabel.snp.makeConstraints {
            $0.top.equalTo(commentsTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(genreLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.lessThanOrEqualTo(150)
        }
        
        likeButton.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(210)
            $0.leading.equalTo(commentsTitleLabel).offset(300)
            $0.width.equalTo(70)
            $0.height.equalTo(50)
        }
    }

    private func displayGrade(_ grade: Int) {
        let gradeLabel = UILabel()
        gradeLabel.text = String(repeating: "⭐", count: grade)
        gradeLabel.font = .systemFont(ofSize: 40)
        gradeLabel.textColor = .yellow
        view.addSubview(gradeLabel)
        gradeLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(210)
            $0.leading.equalTo(commentsTitleLabel)
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

            starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            starButton.tag = index + 1
            starButtons.append(starButton)
            view.addSubview(starButton)
        }
        for (index, button) in starButtons.enumerated() {
            button.snp.makeConstraints {
                $0.top.equalTo(bookImageView.snp.bottom).offset(210)
                $0.leading.equalTo(commentsTitleLabel).offset(5 + (index * 50))
                $0.width.height.equalTo(40)
            }
        }
    }

    @objc private func starButtonTapped(_ sender: UIButton) {
        let selectedGrade = sender.tag
        book.grade = selectedGrade
        do { try ProcessingBookJSON.shared.gradeBook(book: book, grade: selectedGrade) } catch { }
        updateStarButtons()
        print("Grade set to \(selectedGrade) stars")
    }

    @objc private func likeButtonTapped() {
        isLiked.toggle()
        book.like = isLiked
        updateLikeButtonAppearance()
        print("Book is now \(isLiked ? "liked" : "unliked")")
    }

    private func updateStarButtons() {
        for (index, button) in starButtons.enumerated() {
            button.isSelected = index < book.grade ?? 0
        }
    }

    private func updateLikeButtonAppearance() {
        let imageName = isLiked ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))
        likeButton.setImage(image, for: .normal)
        likeButton.tintColor = isLiked ? .red : .black
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
