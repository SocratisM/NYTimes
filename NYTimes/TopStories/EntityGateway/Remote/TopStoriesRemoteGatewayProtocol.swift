//
//  TopStoriesRemoteGatewayProtocol.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import Foundation

protocol TopStoriesRemoteGatewayProtocol: class {
	func fetchTopStories(completion: @escaping ([StoryJSON]? , Error?) -> ())
}
