//
//  DetailsViewCell.swift
//  NewsApp
//
//  Created by Касымжан Гиждуан on 28.04.2022.
//

import UIKit

struct Details {
    let title: String
    let author: String?
    let desctiption: String?
    let articleURL: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(author)
        hasher.combine(desctiption)
        hasher.combine(articleURL)
    }
}

typealias DetailsViewCellConfigurator = TableCellConfigurator<DetailsViewCell, Details>

class DetailsViewCell: UITableViewCell, ConfigurableCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .title
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .body
        label.numberOfLines = 0
        return label
    }()
    
    private let desctiptionLabel: UILabel = {
        let label = UILabel()
        label.font = .largeBody
        label.numberOfLines = 0
        return label
    }()
    
    private let ArticleURLLabel: UILabel = {
        let label = UILabel()
        label.font = .largeBody
        label.numberOfLines = 0
        return label
    }()
    
    func configure(data: Details) {
        titleLabel.text = data.title
        authorLabel.text = data.author
        desctiptionLabel.text = data.desctiption
        ArticleURLLabel.text = "Full Article: \(data.articleURL)"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutConfigure() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints() {
            $0.leading.trailing.top.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints() {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(desctiptionLabel)
        desctiptionLabel.snp.makeConstraints() {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(authorLabel.snp.bottom).offset(20)
        }
        
        contentView.addSubview(ArticleURLLabel)
        ArticleURLLabel.snp.makeConstraints() {
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
}
