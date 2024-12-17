//
//  ProcessingBookJSON.swift
//  Reading_Tracker
//
//  Created by Данькевич Анастасія on 14.12.2024.
//

import Foundation
import UIKit

final class ProcessingBookJSON {
    static let shared = ProcessingBookJSON()

    let booksPath = FileManager.default.urls(for: .documentDirectory,
                    in: .userDomainMask).first!.appendingPathComponent("Books.json")

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
             img: "Harry_Potter"),
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
        if !FileManager.default.fileExists(atPath: booksPath.path) {
            let initialContent = Data("[]".utf8)
            try initialContent.write(to: booksPath)
        }

        let contents = try Data(contentsOf: booksPath)
        let books = try JSONDecoder().decode([Book].self, from: contents)

        return books
    }

    func writeBooks() throws {
        if !FileManager.default.fileExists(atPath: booksPath.path) {
            let initialContent = Data("[]".utf8)
            try initialContent.write(to: booksPath)
        }

        let contents = try JSONEncoder().encode(self.books)
        try contents.write(to: booksPath)
        print("Path Books \(booksPath)")
    }

    func addBook(userBook: Book) throws {
        let books = try parseBooks()
        self.books = books
        self.books.append(userBook)
        try writeBooks()
    }

    func favouriteBooks() -> [Book] {
        return self.books.filter { $0.like == true}
    }

    func likedBook(book: Book) throws {
        if let position = self.books.firstIndex(of: book) {
            self.books[position].like = true
            try writeBooks()
        }
    }

    func dislikedBook(book: Book) throws {
        if let position = self.books.firstIndex(of: book) {
            self.books[position].like = false
            try writeBooks()
        }
    }

    func gradeBook(book: Book, grade: Int) throws {
        if let position = self.books.firstIndex(of: book) {
            self.books[position].grade = grade
            try writeBooks()
        }
    }

    func gradedBooks() -> [Book] {
        return self.books.filter { $0.grade != nil }
    }
}
