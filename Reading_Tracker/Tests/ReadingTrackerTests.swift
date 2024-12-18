import Foundation
import XCTest
@testable import Reading_Tracker

//final class ReadingTrackerTests: XCTestCase {
//
//    func testAddQuote() throws {
//        let empty: [Quote] = []
//        let result: [Quote] = try ProcessingQuoteJSON().parseQuotes()
//        XCTAssertEqual(result, empty)
//
//        let quote = [Quote(title: "1", quote: "Hello")]
//        try ProcessingQuoteJSON.shared.addQuote(quote: Quote(title: "1", quote: "Hello"))
//        XCTAssertEqual(quote, ProcessingQuoteJSON.shared.quotes)
//    }
//}

final class MainTabBarControllerTests: XCTestCase {
    lazy var mainTabBarController = MainTabBarController()
    
    func testTabBarInitialization() {
        XCTAssertNotNil(mainTabBarController.viewControllers)
        XCTAssertEqual(mainTabBarController.viewControllers?.count, 3)
    }

    func testNavControllerComponents() {
        XCTAssertNotNil(mainTabBarController.tabBar)
        XCTAssertEqual(mainTabBarController.tabBar.items?.count, 3)
        
        XCTAssertNotNil(mainTabBarController.viewControllers)
        let viewControllers = mainTabBarController.viewControllers!
        let homeNavController = viewControllers[0] as? UINavigationController
        XCTAssertEqual(homeNavController?.tabBarItem.title, "Home")
        XCTAssertNotNil(homeNavController?.tabBarItem.image)
        XCTAssertEqual(homeNavController?.tabBarItem.tag, 0)

        
        let favNavController = viewControllers[1] as? UINavigationController
        XCTAssertEqual(favNavController?.tabBarItem.title, "Favourite")
        XCTAssertNotNil(favNavController?.tabBarItem.image)
        XCTAssertEqual(favNavController?.tabBarItem.tag, 1)

        
        let profileNavController = viewControllers[2] as? UINavigationController
        XCTAssertEqual(profileNavController?.tabBarItem.title, "Profile")
        XCTAssertNotNil(profileNavController?.tabBarItem.image)
        XCTAssertEqual(profileNavController?.tabBarItem.tag, 2)
    }
    
    func testTabBarAppearance() {
        let appearance = mainTabBarController.tabBar.standardAppearance
        
        // Background
        XCTAssertEqual(appearance.backgroundColor, .lightGreen)
        XCTAssertEqual(appearance.shadowColor, .black)
        
        // Normal
        XCTAssertEqual(appearance.stackedLayoutAppearance.normal.iconColor, .darkGreen)
        XCTAssertEqual(appearance.stackedLayoutAppearance.normal.titleTextAttributes[.foregroundColor] as? UIColor, .darkGreen)
        
        // Selected
        XCTAssertEqual(appearance.stackedLayoutAppearance.selected.iconColor, .black)
        XCTAssertEqual(appearance.stackedLayoutAppearance.selected.titleTextAttributes[.foregroundColor] as? UIColor, .black)
    }
    
    func testJSONParsing() {
        XCTAssertFalse(ProcessingBookJSON.shared.books.isEmpty)
        XCTAssert(ProcessingQuoteJSON.shared.quotes.isEmpty)
    }
}


final class HomeViewControllerTests: XCTestCase {
    private var homeViewController: HomeViewController!
    
    override func setUp() {
        super.setUp()
        homeViewController = HomeViewController()
        homeViewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        homeViewController = nil
        super.tearDown()
    }
    
    func testHomeViewInitialization() {
        XCTAssertNotNil(homeViewController.view)
        XCTAssertTrue(homeViewController.view is HomeView)
    }
    
    func testHomeViewControllerLabelsSetup() {
        let homeView = homeViewController.view as! HomeView
        
        XCTAssertEqual(homeView.myBooksLabel.text, "My Books")
        XCTAssertEqual(homeView.myBooksLabel.font, UIFont.boldSystemFont(ofSize: 24))
        XCTAssertEqual(homeView.myBooksLabel.textColor, .black)
        XCTAssertEqual(homeView.myBooksLabel.textAlignment, .left)
        
        XCTAssertEqual(homeView.booksOfMonthLabel.text, "Top - 5 books of the month")
        XCTAssertEqual(homeView.booksOfMonthLabel.font, UIFont.boldSystemFont(ofSize: 24))
        XCTAssertEqual(homeView.booksOfMonthLabel.textColor, .black)
        XCTAssertEqual(homeView.booksOfMonthLabel.textAlignment, .left)
        
        XCTAssertEqual(homeView.programingBooksLabel.text, "Top - 5 books about programming")
        XCTAssertEqual(homeView.programingBooksLabel.font, UIFont.boldSystemFont(ofSize: 24))
        XCTAssertEqual(homeView.programingBooksLabel.textColor, .black)
        XCTAssertEqual(homeView.programingBooksLabel.textAlignment, .left)
    }
    
    func testHomeViewControllerButtonSetup() {
        let homeView = homeViewController.view as! HomeView
        
        XCTAssertEqual(homeView.addMyBooksButton.image(for: .normal), UIImage(systemName: "plus.circle"))
        XCTAssertEqual(homeView.addMyBooksButton.tintColor, .black)
    }
    
    func testTouchAddBookButton() {
        let homeView = homeViewController.view as! HomeView
        let button = homeView.addMyBooksButton
        
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        button.sendActions(for: .touchUpInside)
        
        let topViewController = navigationController.topViewController
        XCTAssertTrue(topViewController is AddBookViewController)
    }
}

final class FavouriteViewControllerTests: XCTestCase {
    private var favouriteViewController: FavouriteViewController!
    
    override func setUp() {
        super.setUp()
        favouriteViewController = FavouriteViewController()
        favouriteViewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        favouriteViewController = nil
        super.tearDown()
    }
//    lazy var favouriteViewController = FavouriteViewController()
    
    func testFavouriteViewControllerInitialization() {
        XCTAssertNotNil(favouriteViewController.view)
        XCTAssertNotNil(favouriteViewController.view.layer.sublayers?.first as? CAGradientLayer)
    }
    
    func testАavouriteViewControllerLablesSetup() {
        func testFavouriteViewControllerLabelsSetup() {
        let mainStackView = favouriteViewController.view.subviews.first as! UIStackView
        let favoriteBooksLabel = mainStackView.arrangedSubviews[0] as! UILabel
        let savedQuotesLabel = mainStackView.arrangedSubviews[2] as! UILabel
            
        XCTAssertEqual(favoriteBooksLabel.text, "Favourite Books")
        XCTAssertEqual(favoriteBooksLabel.font, UIFont.boldSystemFont(ofSize: 24))
        XCTAssertEqual(favoriteBooksLabel.textColor, .black)
        XCTAssertEqual(favoriteBooksLabel.textAlignment, .left)
            
        XCTAssertEqual(savedQuotesLabel.text, "Saved Quotes")
        XCTAssertEqual(savedQuotesLabel.font, UIFont.boldSystemFont(ofSize: 24))
        XCTAssertEqual(savedQuotesLabel.textColor, .black)
        XCTAssertEqual(savedQuotesLabel.textAlignment, .left)
        }
    }
    
    func testFavouriteViewControllerButtonSetup() {
        let mainStackView = favouriteViewController.view.subviews.first as! UIStackView
        let quotesStackView = mainStackView.arrangedSubviews[3] as! UIStackView
        let addQuoteButton = quotesStackView.arrangedSubviews[0] as! UIButton
        
        XCTAssertNotNil(addQuoteButton)
        XCTAssertEqual(addQuoteButton.image(for: .normal), UIImage(systemName: "plus.circle"))
        XCTAssertEqual(addQuoteButton.tintColor, .black)
    }
}

final class ProfileViewControllerTests: XCTestCase {
    private var profileViewController: ProfileViewController!
    
    override func setUp() {
        super.setUp()
        profileViewController = ProfileViewController()
        profileViewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        profileViewController = nil
        super.tearDown()
    }
//    lazy var profileViewController = ProfileViewController()
    
    func testFavouriteViewControllerInitialization() {
        XCTAssertNotNil(profileViewController.view)
        XCTAssertNotNil(profileViewController.view.layer.sublayers?.first as? CAGradientLayer)
    }
    
    func testUserImageSetup(){
        let userImage = profileViewController.view.subviews.first { $0 is UIImageView } as! UIImageView
        
        XCTAssertNotNil(userImage.image)
        XCTAssertEqual(userImage.image?.imageAsset, UIImage(named: "User_Profile")?.imageAsset)
    }
    
    func testUserNameSetup(){
        let userName = profileViewController.view.subviews.first { $0 is UILabel } as! UILabel
        
        XCTAssertEqual(userName.text, "BookLover<3")
        XCTAssertEqual(userName.font, UIFont.systemFont(ofSize: 24, weight: .bold))
        XCTAssertEqual(userName.textColor, .black)
        XCTAssertEqual(userName.textAlignment, .center)

    }
    
    func testProfileViewControllerButtonSetup(){
        let button = profileViewController.view.subviews.first { $0 is UIButton } as! UIButton
        
        XCTAssertEqual(button.backgroundColor, .lightGreen)
        XCTAssertEqual(button.layer.cornerRadius, 20)
        
        let buttonText = button.subviews.first { ($0 is UILabel) } as! UILabel
               
        XCTAssertEqual(buttonText.text, "Hey, click here to see your activity - tree!")
        XCTAssertEqual(buttonText.font, UIFont.systemFont(ofSize: 18))
        //        let buttonTree = button.subviews.first { ($0 is UILabel) } as! UILabel
        //        XCTAssertEqual(buttonTree.text, "Hey, click here to see your activity - tree! 🌳")
        //        XCTAssertEqual(buttonTree.font, UIFont.systemFont(ofSize: 74))
        //
            }
    func testTouchButton(){
        let button = profileViewController.view.subviews.first { $0 is UIButton } as! UIButton
        let navigationController = UINavigationController(rootViewController: profileViewController)
             
        button.sendActions(for: .touchUpInside)
            
        let topViewController = navigationController.topViewController
        XCTAssertTrue(topViewController is TreeViewController)
    }

}

final class AddBookViewControllerTests: XCTestCase {
    private var addBookViewController: AddBookViewController!
    private var addBookView: AddBookView {
        addBookViewController.view as! AddBookView
    }
    
    override func setUp() {
        super.setUp()
        addBookViewController = AddBookViewController()
        addBookViewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        addBookViewController = nil
        super.tearDown()
    }

    func testSetupView() {
        
        XCTAssertEqual(addBookView.titleTextField.placeholder, "Enter book title")
        XCTAssertEqual(addBookView.authorTextField.placeholder, "Enter author name")
        XCTAssertEqual(addBookView.genreTextField.placeholder, "Enter genre")
    }
    
    func testSetupTextLabel() {
        XCTAssertEqual(addBookView.titleLabel.text, "Add New Book")
        XCTAssertEqual(addBookView.titleLabel.font, .boldSystemFont(ofSize: 42))
        XCTAssertEqual(addBookView.titleLabel.textAlignment, .center)
        XCTAssertEqual(addBookView.titleLabel.textColor, .darkGreen)
    }
    
    func testStarButtonsSetup() {
        XCTAssertEqual(addBookView.starButtons.count, 5)
        
        for (index, button) in addBookView.starButtons.enumerated() {
            XCTAssertNotNil(button.image(for: .normal))
            XCTAssertNotNil(button.image(for: .selected))
            XCTAssertEqual(button.tag, index + 1)
            XCTAssertEqual(button.tintColor, .yellow)
        }
    }
    
    func testSaveButtonSetup() {
        XCTAssertEqual(addBookView.saveButton.titleLabel?.text, "Save")
        XCTAssertEqual(addBookView.saveButton.titleLabel?.font, .systemFont(ofSize: 28, weight: .bold))
        XCTAssertEqual(addBookView.saveButton.titleColor(for: .normal), .black)
    }
    
    func testSaveButtonAction() {
        let navigationController = UINavigationController(rootViewController: addBookViewController)
        
        addBookView.titleTextField.text = "Test Book"
        addBookView.authorTextField.text = "Test Author"
        addBookView.genreTextField.text = "Test Genre"
        
        addBookView.saveButton.sendActions(for: .touchUpInside)
        
        XCTAssertNotNil(navigationController.topViewController)
    }
    
    func testStarButtonAction() {
        let thirdStar = addBookView.starButtons[2]
        thirdStar.sendActions(for: .touchUpInside)
        
        for (index, button) in addBookView.starButtons.enumerated() {
            XCTAssertEqual(button.isSelected, index < 3)
        }
    }
}

final class BookDetailsViewControllerTests: XCTestCase {
    
    private var testBook: Book!
    private var bookDetailsViewController: BookDetailsViewController!
        
    override func setUp() {
        super.setUp()
        testBook = Book(
            title: "Test Book",
            author: "Test Author",
            genre: "Test Genre",
            extraComments: "Test Comments",
            img: "test_image",
            like: false
        )
        bookDetailsViewController = BookDetailsViewController(book: testBook)
        bookDetailsViewController.loadViewIfNeeded()
    }
        
    override func tearDown() {
        bookDetailsViewController = nil
        testBook = nil
        super.tearDown()
    }

    
    func testBookDetailsViewControllerInitialization() {
        XCTAssertNotNil(bookDetailsViewController)
        XCTAssertEqual(bookDetailsViewController.book.title, testBook.title)
        XCTAssertEqual(bookDetailsViewController.book.author, testBook.author)
        XCTAssertEqual(bookDetailsViewController.book.genre, testBook.genre)
    }
}


class BookDetailsViewTests: XCTestCase {
    private var testBook: Book!
    private var bookDetailsView: BookDetailsView!
    
    override func setUp() {
        super.setUp()
        testBook = Book(
            title: "Test Book",
            author: "Test Author",
            genre: "Test Genre",
            extraComments: "Test Comments",
            img: "test_image",
            like: false
        )
        bookDetailsView = BookDetailsView(book: testBook)
        bookDetailsView.layoutIfNeeded()
    }
    
    override func tearDown() {
        bookDetailsView = nil
        testBook = nil
        super.tearDown()
    }
    
    func testBookLabels() {
        guard let bookNameLabel = bookDetailsView.subviews.first(where: { ($0 as? UILabel)?.text == testBook.title }) as? UILabel,
              let authorLabel = bookDetailsView.subviews.first(where: { ($0 as? UILabel)?.text == testBook.author }) as? UILabel,
              let genreLabel = bookDetailsView.subviews.first(where: { ($0 as? UILabel)?.text == testBook.genre }) as? UILabel else {
            return
        }
        
        XCTAssertEqual(bookNameLabel.font, .boldSystemFont(ofSize: 28))
        XCTAssertEqual(bookNameLabel.textColor, .black)
        
        XCTAssertEqual(authorLabel.font, .systemFont(ofSize: 20))
        XCTAssertEqual(authorLabel.textColor, .black)
        
        XCTAssertEqual(genreLabel.font, .systemFont(ofSize: 18))
        XCTAssertEqual(genreLabel.textColor, .black)
    }
    
    func testLikeButtonSetup() {
        guard let button = bookDetailsView.subviews.first(where: { $0 is UIButton }) as? UIButton else {
            XCTFail("Like button not found")
            return
        }
        
        XCTAssertNotNil(button.image(for: .normal))
        XCTAssertEqual(button.tintColor, .black)
        XCTAssertEqual(button.backgroundColor, .clear)
    }
    
    func testImageViewConfiguration() {
        guard let imageView = bookDetailsView.subviews.first(where: { $0 is UIImageView }) as? UIImageView else {
            return
        }
        
        XCTAssertEqual(imageView.contentMode, .scaleAspectFit)
        XCTAssertEqual(imageView.image, UIImage(named: testBook.img))
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
            XCTAssertEqual(processingBookJSON.book[11], newBook, "The first book should match")
            
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
