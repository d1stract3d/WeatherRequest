//
//  URLHelper.swift
//  WeatherRequest
//
//  Created by Alex McCall on 5/1/20.
//  Copyright © 2020 Alex McCall. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries:[String:String])->URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap {
            URLQueryItem(name: $0.0, value: $0.1)
        }
        return components?.url
    }
}
