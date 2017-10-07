//
//  StoryJSON.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 05/10/2017.
//

import Foundation
import SwiftyJSON

public struct StoryJSON {
    var title : String
    var imgUrl : String
    var item_type : String
    var published_date : String
    var abstract : String
    var storyLink : String
    
    init?(_ json: JSON) {
        guard let title =  json["title"].string,
            let abstract = json["abstract"].string,
            let item_type = json["item_type"].string,
            let storyLink = json["url"].string,
            let published_date = json["published_date"].string else { return nil }
        
        self.imgUrl = StoryJSON.getPhotoUrl(json: json)
        self.title = title
        self.abstract = abstract
        self.item_type = item_type
        self.published_date = published_date
        self.storyLink = storyLink
    }
}

fileprivate extension StoryJSON {
    fileprivate static func getPhotoUrl(json: JSON) -> String {
        if let multimedia = json["multimedia"].array {
            for item in multimedia {
                if let format = item["format"].string {
                    if(format.isEqual("thumbLarge")) {
                        if let url = item["url"].string {
                            return url
                        }
                    }
                }
            }
        }
        return ""
    }
}
