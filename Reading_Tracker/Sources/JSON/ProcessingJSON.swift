//
//  ParsingJSON.swift
//  FinalProject
//
//  Created by Данькевич Анастасія on 14.12.2024.
//

import Foundation
import UIKit

final class ProcessingJSON {
    let booksPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Books.json")
    let quotePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Quotes.json")

    var books = [
// Note: first 5 - top about programming
        Book(title: "Develop in Swift Fundamentals",
             author: "Apple Education",
             genre: "Education, Documentation",
             img: "Swift_Fundamentals"),
        Book(title: "The Art of Mac Malware",
             author: "Patrick Wardle",
             genre: "Education, Documentation",
             img: "The_Art_of_Mac_Malware"),
        Book(title: "Grokking algorithms",
             author: "Aditya Y. Bhargava",
             genre: "Education",
             img: "Grokking_algorithms"),
        Book(title: "Hacking. The art of exploitation",
             author: "Jon Erickson",
             genre: "Education",
             img: "Hacking"),
        Book(title: "Computer Systems. A Programmer's Perspective",
             author: "Randal E. Bryant, David R. O'Hallaron",
             genre: "Education",
             img: "Computer_systems"),
// Note: next 5 - top of the month
        Book(title: "Harry Potter and the Sorcerer’s Stone",
             author: "J.K. Rowling",
             genre: "Fantasy, Fiction",
             img: "Harrry_Potter"),
        Book(title: "Good Omens",
             author: "Terry Pratchett, Neil Gaiman",
             genre: "Fantasy, Fiction, Hummor",
             img: "Good_Omens"),
        Book(title: "The Hunger Games",
             author: "Suzanne Collins",
             genre: "Post Apocalyptic, Fantasy, Science Fiction",
             img: "The_Hunger_Games"),
        Book(title: "Divergent",
             author: "Veronica Roth",
             genre: "Dystopia, Fantasy, Science Fiction, Romance",
             img: "Divergent"),
        Book(title: "Eat, Pray, Love",
             author: "Elizabeth Gilbert",
             genre: "Nonfiction, Memoir, Travel, Biography, Romance",
             img: "Eat_Pray_Love")
    ]

    func parseBooks() throws -> [Book] {
        let contents = try Data(contentsOf: booksPath)
        let books = try JSONDecoder().decode([Book].self, from: contents)

        return books
    }

    func writeBooks() throws {
        let contents = try JSONEncoder().encode(self.books)
        try contents.write(to: booksPath)
//        print("Path \(booksPath)")
    }

    func addBook(userBook: Book) throws {
        let books = try parseBooks()
        self.books = books
        self.books.append(userBook)
        try writeBooks()
    }

    func favouriteBooks() throws -> [Book] {
        return self.books.filter { $0.like }
    }

    func likeBook(book: Book) throws {
        if let position = self.books.firstIndex(of: book) {
            self.books[position].like = true
            try writeBooks()
        }
    }

    func gradeBook(book: Book, grade: Int) throws {
        if let position = self.books.firstIndex(of: book) {
            self.books[position].grade = grade
            try writeBooks()
        }
    }

    func amountOfBooks() -> Int {
        return self.books.count
    }
}
