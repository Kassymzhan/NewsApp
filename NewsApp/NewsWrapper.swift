//
//  NewsWrapper.swift
//  NewsApp
//
//  Created by Касымжан Гиждуан on 27.04.2022.
//

import Foundation

// MARK: - NewsWrapper
struct NewsWrapper: Codable {
    let status: String
    let totalResults: Int
    let articles: [New]
}

struct Counter {
    static var value = 0
}

// MARK: - New
struct New: Codable {
    let id: Int
    let source: Source
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let content: String?

    init(from decoder: Decoder) throws {
        self.id = Counter.value
        Counter.value += 1
        
        let contatiner = try decoder.container(keyedBy: CodingKeys.self)
        self.source = try contatiner.decode(Source.self, forKey: .source)
        self.author = try contatiner.decode(String?.self, forKey: .author)
        self.title = try contatiner.decode(String.self, forKey: .title)
        self.articleDescription = try contatiner.decode(String?.self, forKey: .articleDescription)
        self.url = try contatiner.decode(String.self, forKey: .url)
        self.urlToImage = try contatiner.decode(String?.self, forKey: .urlToImage)
        self.content = try contatiner.decode(String?.self, forKey: .content)
    }
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, content
    }
}


/*struct New: Codable {
    let id: Int
    let source: Source
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title, id
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}*/

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
