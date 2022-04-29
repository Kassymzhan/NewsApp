//
//  NewsPage.swift
//  NewsApp
//
//  Created by Касымжан Гиждуан on 27.04.2022.
//

import UIKit

class NewsPage: UIViewController {
    private let viewModel: NewsViewModel
    
    private let items: [CellConfigurator] = []
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search news",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        return searchController
    }()
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let loaderIndicatorView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.color = UIColor.darkGray
        return loader
    }()
    
    private lazy var tableDirector: TableDirector = {
        let tableDirector = TableDirector(tableView: tableView, items: items)
        return tableDirector
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemBackground
        navigationController?.navigationBar.backgroundColor = .tertiarySystemBackground
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        bindViewModel()
        fetchData()
        layoutUI()
        cellActionHandlers()
        tableDirector.tableView.reloadData()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func fetchData() {
        viewModel.getTopHeadLines()
    }
    
    private func buildCells(searchText: String = "") {
        let newPOs = viewModel.news.map { new in
            NewPO(id: new.id, imageURL: new.urlToImage, title: new.title, author: new.author)
        }
        var cellConfigurators: [NewsCellCongigurator] = []
        for newPO in newPOs {
            if newPO.title.lowercased().contains(searchText.lowercased()) || searchText.isEmpty {
                let config = NewsCellCongigurator(item: newPO)
                cellConfigurators.append(config)
            }
        }
        tableDirector.items = cellConfigurators
        tableDirector.tableView.reloadData()
    }
    
    private func showError(error: Error) {
        let errorStirng = "\(error)"
        let alert = UIAlertController(title: "Error", message: errorStirng, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            exit(0)
        }))
        present(alert, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.showError = showError(error:)
        viewModel.didLoadNews = { [weak self] _ in
            self?.buildCells()
        }
        viewModel.didStartRequest = { [weak self] in
            self?.loaderIndicatorView.startAnimating()
        }
        viewModel.didEndRequest = { [weak self] in
            self?.loaderIndicatorView.stopAnimating()
        }
    }
    
    private func layoutUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints(){
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.backgroundColor = .secondarySystemBackground
        
        view.addSubview(loaderIndicatorView)
        loaderIndicatorView.snp.makeConstraints() {
            $0.center.equalToSuperview()
        }
    }
    
    private func cellActionHandlers() {
        self.tableDirector.actionProxy
            .on(action: .didSelect) { [weak self] (config: NewsCellCongigurator, cell) in
                if let new = self?.viewModel.getNew(byId: config.item.id) {
                    let vc = NewsDetailsViewController(new: new)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }.on(action: .willDisplay) { (config: NewsCellCongigurator, cell) in
                
            }
    }
}

extension NewsPage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        buildCells(searchText: searchText)
    }
}
