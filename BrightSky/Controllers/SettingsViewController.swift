//
//  SettingsViewController.swift
//  BrightSky
//
//  Created by Tarun Sharma on 08/01/26.
//

import UIKit

class SettingsViewController: UIViewController {

    
    private let primaryView :  SettingsView = {
        let view = SettingsView()
        let viewModel = SettingsViewModel(options: SettingOption.allCases)
        view.configure(with: viewModel)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(primaryView)
        primaryView.delegate = self
        addConstraints()
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


extension SettingsViewController : SettingsViewDelegate {
    func settingsView(_ view: SettingsView, didTap option: SettingOption) {
        switch option {
        case .upgrade:
            print("upgrade")
        case .privacyPolicy:
            print("pp")
        case .terms:
            print("terms")
        case .contact:
            print("contact")
        case .getHelp:
            print("get help")
        case .rateApp:
            print("rate app")
        }
    }
}
