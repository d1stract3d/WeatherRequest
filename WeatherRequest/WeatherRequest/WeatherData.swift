//
//  WeatherData.swift
//  WeatherRequest
//
//  Created by Alex McCall on 5/1/20.
//  Copyright © 2020 Alex McCall. All rights reserved.
//

import Foundation

struct Forecast : Decodable {
    var list: [ForecastList]
}

struct ForecastList: Decodable {
    let main : Main
    let weather : [Weather]
    let dt_txt : String
}

struct Main: Decodable {
    let temp : Double
}

struct Weather : Decodable {
    let description: String
    let icon: String
}

