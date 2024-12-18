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
