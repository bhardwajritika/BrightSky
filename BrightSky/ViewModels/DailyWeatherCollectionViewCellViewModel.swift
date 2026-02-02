//
//  DailyWeatherCollectionViewCellViewModel.swift
//  BrightSky
//
//  Created by Tarun Sharma on 27/01/26.
//

import WeatherKit
import Foundation


struct DailyWeatherCollectionViewCellViewModel {
    private let model : DayWeather
    
    init(model: DayWeather) {
        self.model = model
    }
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    } ()
    
    
    public var iconname: String {
        return model.symbolName
    }
    
    public var temperature: String {
        
        var lowTemp = Resources().formatTemperature (temp: model.lowTemperature.description)
        
        var highTemp = Resources().formatTemperature (temp: model.highTemperature.description)
        
        return "\(lowTemp) - \(highTemp)"
    }
    
    public var day: String {
        let weekday = Calendar.current.component(.weekday, from: model.date)
        return string(from: weekday)
    }
    
    private func string(from weekday: Int) -> String {
        switch weekday {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "-"
        }
    }}
