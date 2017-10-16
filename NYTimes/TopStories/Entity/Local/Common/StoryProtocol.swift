//
//  StoryProtocol.swift
//  NYTimes
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import CoreData

protocol StoryProtocol: class {
    var title : String! { get set }
    var imgUrl : String? { get set }
    var item_type : String? { get set }
    var published_date : String! { get set }
    var storyLink : String? { get set }
    var abstract : String! { get set }
}

