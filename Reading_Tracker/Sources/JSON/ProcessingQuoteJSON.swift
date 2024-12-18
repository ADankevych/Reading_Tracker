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

    func loadQuotes() throws {
        if FileManager.default.fileExists(atPath: quotesPath.path) {
            do {
                let data = try Data(contentsOf: quotesPath)
                let loadedQuotes = try JSONDecoder().decode([Quote].self, from: data)
                self.quotes = quotes + loadedQuotes
            } catch {
                print("Error loading books: \(error)")
            }
        } else {
            print("Quotes file doesn't exist. Using default books.")
        }
    }
    
    func parseQuotes() throws -> [Quote] {
        if !FileManager.default.fileExists(atPath: quotesPath.path) {
            let initialContent = Data("[]".utf8)
            try initialContent.write(to: quotesPath)
        }

        let contents = try Data(contentsOf: quotesPath)
        let quotes = try JSONDecoder().decode([Quote].self, from: contents)
        print(quotes)

        return quotes
    }

    func writeQuotes() throws {
        if !FileManager.default.fileExists(atPath: quotesPath.path) {
            let initialContent = Data("[]".utf8)
            try initialContent.write(to: quotesPath)
        }

        let contents = try JSONEncoder().encode(self.quotes)
        try contents.write(to: quotesPath)
        // print("Path Quotes \(quotesPath)")
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

    func reload() {
        self.quotes = []
        do {
            try writeQuotes()
        }
        catch { }
    }
}
