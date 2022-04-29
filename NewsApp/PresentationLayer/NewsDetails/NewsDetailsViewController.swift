//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Касымжан Гиждуан on 27.04.2022.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    private let new: New
    
    private lazy var tableDirector: TableDirector = {
        let tableDirector = TableDirector(tableView: tableView, items: [])
        return tableDirector
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    init(new: New) {
        self.new = new
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .tertiarySystemBackground
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        buildCells()
    }
    
    private func buildCells() {
        tableDirector.items = [
            ImageViewCellConfigurator(item: new.urlToImage ?? " "),
            DetailsViewCellConfigurator(
                item: Details(title: new.title, author: new.author, desctiption: new.articleDescription, articleURL: new.url))
        ]
        tableDirector.tableView.reloadData()
    }
}
