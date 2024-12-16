import Foundation
import XCTest
@testable import Reading_Tracker

final class ReadingTrackerTests: XCTestCase {

    func testWriteBooks() throws {
        XCTAssertNoThrow(try ProcessingBookJSON().writeBooks())
    }

    func testParseBooks() throws {
        let books = [
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

        let result = try ProcessingBookJSON().parseBooks()
        XCTAssertEqual(result, books)
    }

    func testAddQuote() throws {
        let empty: [Quote] = []
        let result: [Quote] = try ProcessingQuoteJSON().parseQuotes()
        XCTAssertEqual(result, empty)
        
        let quote = [Quote(title: "1", quote: "Hello")]
        try ProcessingQuoteJSON.shared.addQuote(quote: Quote(title: "1", quote: "Hello"))
        XCTAssertEqual(quote, ProcessingQuoteJSON.shared.quotes)
    }
}
