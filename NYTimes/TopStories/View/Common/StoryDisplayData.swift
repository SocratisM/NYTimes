//
//  StoryDisplayData.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import Foundation
import UIKit

public class StoryDisplayData {
    
    let title: String
    var published_date: String
    var abstract: String
    var storyImageView: UIImageView = UIImageView()
    var storyLink: String?
    weak var delegate: StoryDisplayDelegate?
    
    init(story: StoryProtocol) {
        
        self.title = story.title
        self.abstract = story.abstract
        published_date = story.published_date
        if let date = ISO8601DateFormatter().date(from: story.published_date){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            let dateString = dateFormatter.string(from:date as Date)
            published_date = dateString
        }
        
        let  placeholder = UIImage(named: "placeholder_logo")
        if let url = story.imgUrl {
            storyImageView.loadImageUsingCacheWithURLString(url, placeHolder: placeholder) {   image in
                self.delegate?.didReceiveImage(image: image)
            }
        }
    }
}

