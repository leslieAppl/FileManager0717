//
//  Book.swift
//  FileManager0717
//
//  Created by leslie on 7/20/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import Foundation
//TODO: - 14 Archiving Custom Objects to Property List
///Encoding and decoding a custom class
struct Book: Codable {
    var title: String
    var author: String
    var edition: Int
}
