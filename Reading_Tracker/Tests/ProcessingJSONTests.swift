import Foundation
import XCTest
@testable import Reading_Tracker

final class ProcessingQuoteJSONTests: XCTestCase {
    
    let processingQuoteJSON = ProcessingQuoteJSON.shared
    
    override func setUp() {
        super.setUp()
        processingQuoteJSON.reload()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoadQuotesWhenFileExistsAndContainsQuotes() {
        let quotes = [
            Quote(title: "Test Quote 1", quote: "first test quote"),
            Quote(title: "Test Quote 2", quote: "second test quote")
        ]
        
        do {
            processingQuoteJSON.quotes = quotes
            try processingQuoteJSON.writeQuotes()
        } catch {
            XCTFail("Error writing quotes to file: \(error)")
        }
        
        do {
            try processingQuoteJSON.loadQuotes()
            
            XCTAssertEqual(processingQuoteJSON.quotes.count, 2, "Quotes should be 2")
            XCTAssertEqual(processingQuoteJSON.quotes[0], quotes[0], "First quote should match")
            XCTAssertEqual(processingQuoteJSON.quotes[1], quotes[1], "Second quote should match")
        } catch {
            XCTFail("Error loading quotes when file exists and contains quotes: \(error)")
        }
    }
    
    func testLoadQuotesWhenFileDoesNotExist() {
        do {
            try FileManager.default.removeItem(at: processingQuoteJSON.quotesPath)
        } catch {
           
        }
        
        do {
            try processingQuoteJSON.loadQuotes()
            XCTAssertTrue(processingQuoteJSON.quotes.isEmpty, "Quotes should be empty when file doesn't exist")
        } catch {
            XCTFail("Error loading quotes when file doesn't exist: \(error)")
        }
    }
    
    func testAddQuote() {
        let initialQuote = Quote(title: "First Quote", quote: "This is the first quote.")
        
        do {
            try processingQuoteJSON.addQuote(quote: initialQuote)

            XCTAssertEqual(processingQuoteJSON.amountOfQuotes(), 1, "There should be 1 quote")
            XCTAssertEqual(processingQuoteJSON.quotes.first, initialQuote, "The first quote should match")
            
            let secondQuote = Quote(title: "Second Quote", quote: "This is the second quote.")
            try processingQuoteJSON.addQuote(quote: secondQuote)
            
            XCTAssertEqual(processingQuoteJSON.amountOfQuotes(), 2, "There should be 2 quotes")
            XCTAssertEqual(processingQuoteJSON.quotes.last, secondQuote, "The last quote should match")
            
        } catch {
            XCTFail("Error adding quote: \(error)")
        }
    }
    
    func testWriteQuotesWhenFileDoesNotExist() {
        try? FileManager.default.removeItem(at: processingQuoteJSON.quotesPath)
        
        let quote = Quote(title: "Test Quote", quote: "quote tests file creation")
        
        do {
            try processingQuoteJSON.addQuote(quote: quote)
            let data = try Data(contentsOf: processingQuoteJSON.quotesPath)
            let loadedQuotes = try JSONDecoder().decode([Quote].self, from: data)
            
            XCTAssertEqual(loadedQuotes.count, 1, "File should contain 1 quote")
            XCTAssertEqual(loadedQuotes.first, quote, "The added quote should match")
        } catch {
            XCTFail("Error in writing or reading quotes: \(error)")
        }
    }

    func testAmountOfQuotes() {
        let quote1 = Quote(title: "First Quote", quote: "First quote for the test")
        let quote2 = Quote(title: "Second Quote", quote: "Second quote for the test")
        
        do {
            try processingQuoteJSON.addQuote(quote: quote1)
            try processingQuoteJSON.addQuote(quote: quote2)
            
            XCTAssertEqual(processingQuoteJSON.amountOfQuotes(), 2, "There should be 2 quotes")
        } catch {
            XCTFail("Error in adding quotes: \(error)")
        }
    }
}

final class ProcessingBookJSONTests: XCTestCase {
    
    let processingBookJSON = ProcessingBookJSON.shared
    
    override func setUp() {
        super.setUp()
        processingBookJSON.reload()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadBooksWhenFileExistsAndContainsBooks() {
        let books = [
            Book(title: "Test Book 1", author: "Test Author", genre: "Genre", img: "Image1"),
            Book(title: "Test Book 2", author: "Test Author", genre: "Genre", img: "Image2")
        ]
        
        do {
            processingBookJSON.books = books
            try processingBookJSON.writeBooks()
        } catch {
            XCTFail("Error writing books to file: \(error)")
        }
        
        do {
            processingBookJSON.loadBooks()
            XCTAssertEqual(processingBookJSON.books.count, 12, "Books should be 2")
            XCTAssertEqual(processingBookJSON.books[0], books[11], "First book should match")
            XCTAssertEqual(processingBookJSON.books[1], books[12], "Second book should match")
        } catch {
            XCTFail("Error loading books when file exists and contains books: \(error)")
        }
    }
    
    func testLoadBooksWhenFileDoesNotExist() {
        do {
            try FileManager.default.removeItem(at: processingBookJSON.booksPath)
        } catch { }
        
        do {
            processingBookJSON.loadBooks()
            XCTAssertEqual(processingBookJSON.books, ProcessingBookJSON.defaultBooks, "Books should contain default books")
        } catch {
            XCTFail("Error loading books when file doesn't exist: \(error)")
        }
    }
    
    func testAddBook() {
        let newBook = Book(title: "New Book", author: "New Author", genre: "Genre", img: "NewImage")
        
        do {
            try processingBookJSON.addBook(userBook: newBook)
            XCTAssertEqual(processingBookJSON.books.count, 11, "There should be 11 book")
            XCTAssertEqual(processingBookJSON.books[11], newBook, "The first book should match")
            
            let anotherBook = Book(title: "Another Book", author: "Another Author", genre: "Genre", img: "AnotherImage")
            try processingBookJSON.addBook(userBook: anotherBook)
            
            XCTAssertEqual(processingBookJSON.books.count, 12, "There should be 12 books")
            XCTAssertEqual(processingBookJSON.books.last, anotherBook, "The last book should match")
        } catch {
            XCTFail("Error adding book: \(error)")
        }
    }
    
    func testWriteBooksWhenFileDoesNotExist() {
        try? FileManager.default.removeItem(at: processingBookJSON.booksPath)
        
        let newBook = Book(title: "Test Book", author: "Test Author", genre: "Genre", img: "TestImage")
        
        do {
            try processingBookJSON.addBook(userBook: newBook)
            let data = try Data(contentsOf: processingBookJSON.booksPath)
            let loadedBooks = try JSONDecoder().decode([Book].self, from: data)
            
            XCTAssertEqual(loadedBooks.count, 11, "File should contain 1 book")
            XCTAssertEqual(loadedBooks.first, newBook, "The added book should match")
        } catch {
            XCTFail("Error in writing or reading books: \(error)")
        }
    }
    
    func testFavouriteBooks() {
        let book1 = Book(title: "Fav Book 1", author: "Author 1", genre: "Genre", img: "Image1")
        let book2 = Book(title: "Fav Book 2", author: "Author 2", genre: "Genre", img: "Image2")
        
        do {
            try processingBookJSON.addBook(userBook: book1)
            try processingBookJSON.addBook(userBook: book2)
            try processingBookJSON.likedBook(book: book1)
            
            let favouriteBooks = processingBookJSON.favouriteBooks()
            XCTAssertEqual(favouriteBooks.count, 1, "There should be 1 favourite book")
            XCTAssertEqual(favouriteBooks.first, book1, "The favourite book should match")
        } catch {
            XCTFail("Error in adding or liking books: \(error)")
        }
    }
    
    func testGradedBooks() {
        let book1 = Book(title: "Graded Book 1", author: "Author 1", genre: "Genre", img: "Image1")
        let book2 = Book(title: "Graded Book 2", author: "Author 2", genre: "Genre", img: "Image2")
        
        do {
            try processingBookJSON.addBook(userBook: book1)
            try processingBookJSON.addBook(userBook: book2)
            try processingBookJSON.gradeBook(book: book1, grade: 5)
            
            let gradedBooks = processingBookJSON.gradedBooks()
            XCTAssertEqual(gradedBooks.count, 1, "There should be 1 graded book")
            XCTAssertEqual(gradedBooks.first?.grade, 5, "The graded book should have the correct grade")
        } catch {
            XCTFail("Error in adding or grading books: \(error)")
        }
    }
    
    func testReloadBooks() {
        let book = Book(title: "Book to Reload", author: "Author", genre: "Genre", img: "Image")
        
        do {
            try processingBookJSON.addBook(userBook: book)
            processingBookJSON.reload()
            XCTAssertEqual(processingBookJSON.books, ProcessingBookJSON.defaultBooks, "Books should be reloaded to default books")
        } catch {
            XCTFail("Error in reloading books: \(error)")
        }
    }
}

final class ParsingReloadTests: XCTestCase {

    func testReloadBooks() {
        ProcessingBookJSON.shared.reload()

        let result = ProcessingBookJSON.shared.books
        XCTAssertEqual(result, ProcessingBookJSON.defaultBooks)
        
    }

    func testReloadQuotes() {
        ProcessingQuoteJSON.shared.reload()

        let result = ProcessingQuoteJSON.shared.quotes
        XCTAssertEqual(result, [])
        
    }
}

// UI TESTS should accessibilityIdentifiers be setUp
//
//class MainTabBarControllerUITests: XCTestCase {
//    var app: XCUIApplication!
//
//    override func setUpWithError() throws {
//        continueAfterFailure = false
//        app = XCUIApplication()
//        app.launch()
//    }
//
//    func testTabBarExistence() throws {
//        let tabBar = app.tabBars.firstMatch
//        XCTAssertTrue(tabBar.waitForExistence(timeout: 8), "Tab bar should exist.")
//    }
//
//    func testTabBarButtonsExistence() {
//        let homeTabButton = app.tabBars.buttons["Home"]
//        XCTAssertTrue(homeTabButton.exists, "The Home tab button should exist.")
//
//        let favouriteTabButton = app.tabBars.buttons["Favourite"]
//        XCTAssertTrue(favouriteTabButton.exists, "The Favourite tab button should exist.")
//
//        let profileTabButton = app.tabBars.buttons["Profile"]
//        XCTAssertTrue(profileTabButton.exists, "The Profile tab button should exist.")
//    }
//
//
//    func testFavouriteTabShowsAddQuoteButton() {
//        let favouriteTabButton = app.tabBars.buttons["favouriteTabButton"]
//        XCTAssertTrue(favouriteTabButton.waitForExistence(timeout: 5), "Favourite tab button should exist.")
//        favouriteTabButton.tap()
//
//        let addQuoteButton = app.buttons["addQuoteButton"]
//        XCTAssertTrue(addQuoteButton.waitForExistence(timeout: 5), "Add Quote button should be visible after tapping Favourite tab.")
//    }
//
//    func testTabBarSelection() {
//        let tabBar = app.tabBars.firstMatch
//        XCTAssertTrue(tabBar.waitForExistence(timeout: 8), "Tab bar should exist.")
//
//        let homeTabButton = app.tabBars.buttons["homeTabButton"]
//        XCTAssertTrue(homeTabButton.exists, "Home tab button should exist.")
//        homeTabButton.tap()
//
//        let homeScreenLabel = app.staticTexts["myBookLabel"]
//        XCTAssertTrue(homeScreenLabel.exists, "Home screen should be displayed.")
//
//        let favouriteTabButton = app.tabBars.buttons["favouriteTabButton"]
//        favouriteTabButton.tap()
//
//        let addQuoteButton = app.buttons["addQuoteButton"]
//        XCTAssertTrue(addQuoteButton.waitForExistence(timeout: 5), "Add Quote button should be visible after tapping Favourite tab.")
//
//        let profileTabButton = app.tabBars.buttons["profileTabButton"]
//        profileTabButton.tap()
//
//
//        let profileScreenLabel = app.staticTexts["userName"]
//        XCTAssertTrue(profileScreenLabel.exists, "Profile screen should be displayed.")
//    }
//}
//

