//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Касымжан Гиждуан on 26.04.2022.
//

import UIKit
import SnapKit
        
struct NewPO {
    let id: Int
    let imageURL: String?
    let title: String
    let author: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageURL)
        hasher.combine(title)
        hasher.combine(author)
    }
}

typealias NewsCellCongigurator = TableCellConfigurator<NewsTableViewCell, NewPO>

class NewsTableViewCell: UITableViewCell, ConfigurableCell {
    
    static let didTapAddToFavouritesButtonAction = "NewsCellDidTapAddToFavouritesButtonAction"
    
    private let newsImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle
        label.numberOfLines = 3
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .body
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        accessoryType = .none
    }
    
    func configure(data: NewPO) {
        if let urlString = data.imageURL, let url = URL(string: urlString) {
            downloadImage(from: url, newsImage: newsImage)
        }else {
            newsImage.image = UIImage(named: "NoImage")
        }
        titleLabel.text = data.title
        authorLabel.text = data.author
    }
    
    private func layoutConfigure() {
        contentView.addSubview(newsImage)
        contentView.backgroundColor = .secondarySystemBackground
        newsImage.snp.makeConstraints() {
            $0.leading.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(ScreenDimentions.height / 5)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints() {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(newsImage.snp.bottom).offset(8)
        }
        
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints() {
            $0.leading.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}
