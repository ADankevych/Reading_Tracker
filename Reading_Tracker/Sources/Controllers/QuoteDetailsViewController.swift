//
//  QuoteDetailsViewController.swift
//  Reading_Tracker
//
//  Created by Данькевич Анастасія on 18.12.2024.
//

import UIKit
import SnapKit
import SwiftUI

class QuoteDetailsViewController: UIViewController {

    var quote: Quote

    private let blockQuote: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .lightGreen
        return view
    }()

    private let quoteText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let quoteBookTitle: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        labelTitle.textColor = .gray
        labelTitle.numberOfLines = 0
        return labelTitle
    }()

    init(quote: Quote) {
        self.quote = quote
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
        view.addSubview(quoteText)
        view.addSubview(quoteBookTitle)
    }

    private func setupLayout() {
        quoteText.text = "“\(self.quote.quote)“"
        quoteBookTitle.text = "from: “\(self.quote.title)“"

        blockQuote.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalTo(view).offset(20)
            $0.trailing.equalTo(view).offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }

        quoteText.snp.makeConstraints {
            $0.top.equalTo(blockQuote).offset(20)
            $0.leading.equalTo(blockQuote).offset(20)
            $0.trailing.equalTo(blockQuote).offset(-20)
        }

        quoteBookTitle.snp.makeConstraints {
            $0.top.equalTo(quoteText.snp.bottom).offset(10)
            $0.leading.equalTo(blockQuote).offset(20)
            $0.trailing.equalTo(blockQuote).offset(-20)
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
