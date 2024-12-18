//
//  QuoteDetailsViewController.swift
//  Reading_Tracker
//
//  Created by Данькевич Анастасія on 18.12.2024.
//

import UIKit

class QuoteDetailsViewController: UIViewController {

    var quote: Quote
    private let quoteDetailsView = QuoteDetailsView()

    init(quote: Quote) {
        self.quote = quote
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = quoteDetailsView
        setupBackground()
        quoteDetailsView.configure(with: quote)
    }

    private func setupBackground() {
        view.backgroundColor = .white
    }
}
