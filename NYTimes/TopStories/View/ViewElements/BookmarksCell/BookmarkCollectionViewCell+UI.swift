//
//  BookmarkCollectionViewCell+UI.swift
//  NYTimes
//
//  Created by Socratis on 07/10/2017.
//

import Foundation
import SnapKit

extension BookmarkCollectionViewCell {
    func setupUI() {
        contentView.backgroundColor = #colorLiteral(red: 0.6640621424, green: 0.7653500438, blue: 0.2051630616, alpha: 1)
        contentView.addSubview(titleLabel)
        contentView.addSubview(storyImgView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        storyImgView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(storyImgView.snp.bottom).offset(15)
            make.leading.equalTo(storyImgView)
            make.trailing.equalTo(contentView.snp.trailing).inset(15)
        }
    }
}
