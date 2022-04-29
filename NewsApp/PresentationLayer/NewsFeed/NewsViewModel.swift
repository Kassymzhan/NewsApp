//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Касымжан Гиждуан on 27.04.2022.
//

import Foundation

class NewsViewModel {
    private let newsService: NewsService
    private(set)var news: [New] = []
    
    var didStartRequest: (() -> Void)?
    var didEndRequest: (() -> Void)?
    var didLoadNews: (([New]) -> Void)?
    var showError: ((Error) -> Void)?
    
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func getNew(byId id: Int) -> New? {
        return news.first(where: { $0.id == id })
    }
    
    func getTopHeadLines() {
        didStartRequest?()
        newsService.getTopHeadLines(
            success: { [weak self] news in
                self?.didEndRequest?()
                self?.news = news
                self?.didLoadNews?(news)
            },
            failure: { [weak self]error in
                self?.didEndRequest?()
                self?.showError?(error)
            }
        )
    }
}
