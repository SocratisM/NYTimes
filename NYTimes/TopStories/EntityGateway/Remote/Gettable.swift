//
//  Gettable.swift
//  NYTimes
//
//  Created by Socratis Michaelides on 26/10/2017.
//

import Foundation

protocol Gettable {
	associatedtype T
	
	func get(completionHandler: @escaping (Result<T>) -> Void)
}

enum Result<T> {
	case Success([T])
	case Failure(Error)
}

//Todo: parse errors
enum ApiError: Error {
	case noInternet
	case requestFailed
	case jsonConversionFailure
	case invalidData
	case responseUnsuccessful
	case invalidURL
	case jsonParsingFailure
}
