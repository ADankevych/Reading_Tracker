//
//  QuoteDetailsView.swift
//  Reading_Tracker
//
//  Created by Адріана Григоришина on 18.12.2024.
//


import UIKit
import SnapKit

class QuoteDetailsView: UIView {

    let blockQuote: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .lightGreen
        return view
    }()

    let quoteText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    let quoteBookTitle: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        labelTitle.textColor = .gray
        labelTitle.numberOfLines = 0
        return labelTitle
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(blockQuote)
        addSubview(quoteText)
        addSubview(quoteBookTitle)
    }

    private func setupLayout() {
        blockQuote.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
            $0.leading.equalTo(self).offset(20)
            $0.trailing.equalTo(self).offset(-20)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-30)
        }

        quoteText.snp.makeConstraints {
            $0.centerX.equalTo(blockQuote)
            $0.centerY.equalTo(blockQuote)
            $0.trailing.equalTo(blockQuote).offset(-40)
        }

        quoteBookTitle.snp.makeConstraints {
            $0.top.equalTo(quoteText.snp.bottom).offset(10)
            $0.leading.equalTo(blockQuote).offset(20)
            $0.trailing.equalTo(blockQuote).offset(-20)
        }
    }

    func configure(with quote: Quote) {
        quoteText.text = "“\(quote.quote)“"
        quoteBookTitle.text = "from: “\(quote.title)“"
    }
}
