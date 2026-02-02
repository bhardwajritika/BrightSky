//
//  WeatherViewModel.swift
//  BrightSky
//
//  Created by Tarun Sharma on 27/01/26.
//

import Foundation

enum WeatherViewModel {
    case current(viewModel: CurrentWeatherCollectionViewCellViewModel)
    case hourly(viewModels: [HourlyWeatherCollectionViewCellViewModel])
    case daily(viewModels: [DailyWeatherCollectionViewCellViewModel])
}
