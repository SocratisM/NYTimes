//
//  StoryTableViewCell+UI.swift
//  NYTimes
//
//  Created by Socratis on 07/10/2017.
//

import Foundation
import SnapKit

extension StoryTableViewCell {
    func  setupViews() {
        contentView.backgroundColor = #colorLiteral(red: 0.6640621424, green: 0.7653500438, blue: 0.2051630616, alpha: 1)
        contentView.addSubview(storyImgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(publicationDateLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        storyImgView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(10)
            make.width.equalTo(130)
            make.height.equalTo(130)
            make.centerY.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.leading.equalTo(storyImgView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).inset(15)
        }
        publicationDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(15)
            make.trailing.equalTo(contentView.snp.trailing).inset(10)
        }
    }
}
