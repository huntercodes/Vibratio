//
//  Categories.swift
//  Vibratio
//
//  Created by hunter downey on 6/22/22.
//

import Foundation

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}

struct AllCategoriesResponse: Codable {
    let categories: Categories
}
