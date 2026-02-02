//
//  HourlyWeatherCollectionViewCellViewModel.swift
//  BrightSky
//
//  Created by Tarun Sharma on 27/01/26.
//

import WeatherKit
import Foundation


struct HourlyWeatherCollectionViewCellViewModel {
    private let model : HourWeather
    
    init(model: HourWeather) {
        self.model = model
    }
    
    public var iconname: String {
        return model.symbolName
    }
    
    public var temperature: String {
        return model.temperature.description
    }
    
    public var hour: String {
        let hour = Calendar.current.component(.hour, from: model.date)
        return "\(hour):00"
    }
    
}
