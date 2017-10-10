//
//  StoryTableViewCell.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import Foundation
import UIKit

class StoryTableViewCell: UITableViewCell
{
    var storyImgView = { return CommonImageView(image: UIImage(named: "placeholder_logo")) }()
    var titleLabel:CommonLabel = { return CommonLabel() }()
    var publicationDateLabel:CommonLabel = {return CommonLabel() }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpWith(_ story: StoryDisplayData) {
        titleLabel.text = story.title
        publicationDateLabel.text = story.published_date
        self.storyImgView.image = story.storyImageView.image
        story.delegate = self
    }
}

extension StoryTableViewCell: StoryDisplayDelegate {
    func didReceiveImage(image: UIImage) {
        DispatchQueue.main.async(execute: {
            self.storyImgView.image = image
        })
    }
}

