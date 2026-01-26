//
//  WeatherViewController.swift
//  BrightSky
//
//  Created by Tarun Sharma on 08/01/26.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private let primaryView =  CurrentWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(primaryView)
        addConstraints()
        getLocation()
    }
    
    private func getLocation() {
        LocationManager.shared.getCurrentLocation { location in
            print(String(describing: location))
            
            if let location = location {
                WeatherManager.shared.getWeather(for: location){
                    
                }
            }
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}

