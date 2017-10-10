//
//  Connection.swift
//  NYTimes
//
//  Created by Socratis on 06/10/2017.
//

import Foundation
import Alamofire

class Connection {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
