//
//  ImageViewCell.swift
//  NewsApp
//
//  Created by Касымжан Гиждуан on 28.04.2022.
//

import UIKit

typealias ImageViewCellConfigurator = TableCellConfigurator<ImageViewCell, String>

class ImageViewCell: UITableViewCell, ConfigurableCell {
    
    func configure(data: String) {
        if let url = URL(string: data) {
            downloadImage(from: (url), newsImage: newsImageView)
        }else {
            newsImageView.image = UIImage(named: "NoImage")
        }
    }
    
    private let newsImageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageViewConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func imageViewConfigure() {
        contentView.addSubview(newsImageView)
        newsImageView.snp.makeConstraints() {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
