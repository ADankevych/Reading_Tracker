//
//  BookModel.swift
//  FinalProject
//
//  Created by Данькевич Анастасія on 14.12.2024.
//

import Foundation
import UIKit

struct Book: Codable, Equatable {
    let title: String
    let author: String
    let genre: String
    var extraComments: String?
    var img: String = "User_book"
    var grade: Int?
    var like: Bool = false
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title && lhs.author == rhs.author
    }
}
