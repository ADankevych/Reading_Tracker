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
    private var commentsTitleLabel = UILabel()
    
    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var starButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupBookDetailsView()
    }
    
    private func setupBookDetailsView() {
        let bookImageView = UIImageView()
        bookImageView.image = UIImage(named: book.img)
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.layer.cornerRadius = 8
        bookImageView.clipsToBounds = true
        view.addSubview(bookImageView)
        
        let bookNameLabel = UILabel()
        bookNameLabel.text = book.title
        bookNameLabel.font = .boldSystemFont(ofSize: 35)
        bookNameLabel.textColor = .white
        view.addSubview(bookNameLabel)
        
        let authorLabel = UILabel()
        authorLabel.text = book.author
        authorLabel.font = .systemFont(ofSize: 24)
        authorLabel.textColor = .black
        view.addSubview(authorLabel)
        
        let genreLabel = UILabel()
        genreLabel.text = book.genre
        genreLabel.font = .systemFont(ofSize: 18)
        genreLabel.textColor = .white
        view.addSubview(genreLabel)
        
        commentsTitleLabel.text = "Comments: "
        commentsTitleLabel.font = .boldSystemFont(ofSize: 18)
        commentsTitleLabel.textColor = .white
        view.addSubview(commentsTitleLabel)
        
        let commentsTextLabel = UILabel()
        commentsTextLabel.text = book.extraComments ?? "No extra comments"
        commentsTextLabel.font = .italicSystemFont(ofSize: 14)
        commentsTextLabel.textColor = .white
        commentsTextLabel.numberOfLines = 0
        commentsTextLabel.lineBreakMode = .byWordWrapping

        view.addSubview(commentsTextLabel)
        
        bookImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(130)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(350)
        }

        bookNameLabel.snp.makeConstraints {
            $0.top.equalTo(bookImageView.snp.bottom).offset(10)
            $0.centerX.equalTo(bookImageView)
            
        }

        authorLabel.snp.makeConstraints {
            $0.bottom.equalTo(bookImageView.snp.top).offset(-20)
            $0.centerX.equalTo(bookImageView)
        }

        genreLabel.snp.makeConstraints {
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(bookImageView)
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

        if let grade = book.grade {
            // displayGrade(grade)
        } else {
            // createStarButtons()
        }
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
