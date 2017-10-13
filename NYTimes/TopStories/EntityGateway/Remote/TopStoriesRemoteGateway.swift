//
//  TopStoriesRemoteGateway.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 03/10/2017.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

class TopStoriesRemoteGateway {
	private static var apiKey: String {
		return "00cb6d5449f84fa0b7839470dbc37526"
	}
	fileprivate static let endpoint = "https://api.nytimes.com/svc/topstories/v2/books.json?api-key=\(TopStoriesRemoteGateway.apiKey)"
}

extension TopStoriesRemoteGateway: TopStoriesRemoteGatewayProtocol {
	
	func fetchTopStories(completion: @escaping ([StoryJSON]? , Error?) -> ()) {
		Alamofire.request(TopStoriesRemoteGateway.endpoint)
			.responseSwiftyJSON { dataResponse in
				//debugPrint(dataResponse)
                if(!Connection.isConnectedToInternet()) {
                    //Todo: use localized strings for generic descriptions
                    let userInfo = [NSLocalizedDescriptionKey: "Check your internet connection"]
                    let error = NSError(domain: "fetchTopStories.connection.error", code: 0, userInfo: userInfo)
					DispatchQueue.main.async(execute: {
                    completion(nil, error)
					})
					return
                }
                self.handleResponse(dataResponse, completion)
		}
	}
	
	func handleResponse(_ dataResponse: Alamofire.DataResponse<SwiftyJSON.JSON>, _ completion: @escaping ([StoryJSON]? , Error?) -> ()) {
		guard let data = dataResponse.data else {
            //Todo: use localized strings for generic descriptions
            let userInfo = [NSLocalizedDescriptionKey: "A generic error has occured"]
            let genericError = NSError(domain: "fetchTopStories.generic.error", code: 1, userInfo: userInfo)
			DispatchQueue.main.async {
			//Todo: parse dataResponse.error in a  custom error class
			completion(nil, genericError)
			}
			return
		}
		let json = JSON(data: data)
		let jsonResults = json["results"]
		//parse with flat map
		let stories: [StoryJSON] = jsonResults.flatMap{StoryJSON($0.1)}
        DispatchQueue.main.async {
		completion(stories, nil)
        }
	}
}
