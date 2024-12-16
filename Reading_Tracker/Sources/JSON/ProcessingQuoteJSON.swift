//
//  ProcessingQuoteJSON.swift
//  Reading_Tracker
//
//  Created by Данькевич Анастасія on 16.12.2024.
//

import Foundation
import UIKit

final class ProcessingQuoteJSON {
    static let shared = ProcessingQuoteJSON()

    let quotesPath = FileManager.default.urls(for: .documentDirectory,
                    in: .userDomainMask).first!.appendingPathComponent("Quotes.json")

    var quotes: [Quote] = []

    func parseQuotes() throws -> [Quote] {
        let contents = try Data(contentsOf: quotesPath)
        let quotes = try JSONDecoder().decode([Quote].self, from: contents)

        return quotes
    }

    func writeQuotes() throws {
        let contents = try JSONEncoder().encode(self.quotes)
        try contents.write(to: quotesPath)
//        print("Path \(quotesPath)")
    }

    func addQuote(quote: Quote) throws {
        let quotes = try parseQuotes()
        self.quotes = quotes
        self.quotes.append(quote)
        try writeQuotes()
    }

    func amountOfQuotes() -> Int {
        return self.quotes.count
    }
}
