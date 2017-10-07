//
//  BookmarkCollectionViewCell.swift
//  NYTimes
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import UIKit

class BookmarkCollectionViewCell: UICollectionViewCell {
    
    var storyImgView = { return CommonImageView(image: UIImage(named: "placeholder_logo")) }()
    var titleLabel:CommonLabel = { return CommonLabel() }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpWith(_ story: StoryDisplayData) {
        titleLabel.text = story.title
        storyImgView.image = story.storyImageView.image
        story.delegate = self
    }
}

extension BookmarkCollectionViewCell: StoryDisplayDelegate {
    func didReceiveImage(image: UIImage) {
        DispatchQueue.main.async(execute: {
            self.storyImgView.image = image
        })
    }
}

