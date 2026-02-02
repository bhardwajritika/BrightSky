//
//  WeatherViewController.swift
//  BrightSky
//
//  Created by Tarun Sharma on 08/01/26.
//

import UIKit
import RevenueCatUI
import RevenueCat
import WeatherKit

class WeatherViewController: UIViewController {
    
    private let primaryView =  CurrentWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(primaryView)
        addConstraints()
        getLocation()
        
       
    }
    
    @objc
    private func didTapUpgrade() {
        // show paywall
        let vc = PaywallViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func getLocation() {
        LocationManager.shared.getCurrentLocation { location in
                WeatherManager.shared.getWeather(for: location!) { [weak self] in
                    DispatchQueue.main.async {
                        guard let currentWeather = WeatherManager.shared.currentWeather else { return }
                        self?.createViewModels(currentWeather: currentWeather)
                    }
                }
        }
    }
    
    func createViewModels(currentWeather: CurrentWeather) {
        var viewModels: [WeatherViewModel] = [
            .current(viewModel: .init(model: currentWeather)),
            .hourly(viewModels: WeatherManager.shared.hourlyForecast.compactMap ({ .init(model: $0) }) ),
        ]
        // irrespect of the the subscrption show the current weather and the hourly weather to the user.
        primaryView.configure(with: viewModels)
        
        
        IAPManager.shared.isSubscribed {
            [weak self] subscribed in
            if subscribed {
                // if subscribed then show the daily weather detail too
                viewModels.append (
                    .daily(viewModels: WeatherManager.shared.dailyForecast.compactMap ({ .init(model: $0) }))
                )
                
                DispatchQueue.main.async {
                    self?.primaryView.configure(with: viewModels)
                    self?.navigationItem.rightBarButtonItem = nil
                }
            } else {
                // if the user have not subscibed then show the crown in the toolbar - subscription button
                DispatchQueue.main.async {
                    self?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "crown"), style: .done, target: self, action: #selector(self?.didTapUpgrade))
                }
            }
        }
    }
        
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}


extension WeatherViewController: PaywallViewControllerDelegate {
    func paywallViewController(_ controller: PaywallViewController, didFinishPurchasingWith customerInfo: CustomerInfo) {
        print("Purchse: \(customerInfo)")
        controller.dismiss(animated: true)
        guard let currentWeather = WeatherManager.shared.currentWeather else { return }
        createViewModels(currentWeather: currentWeather)
    }
    func paywallViewController(_ controller: PaywallViewController, didFinishRestoringWith customerInfo: CustomerInfo) {
        print("Restore: \(customerInfo)")
        controller.dismiss(animated: true)
    }
}
