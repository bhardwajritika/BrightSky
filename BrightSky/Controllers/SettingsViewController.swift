//
//  SettingsViewController.swift
//  BrightSky
//
//  Created by Tarun Sharma on 08/01/26.
//

import UIKit

class SettingsViewController: UIViewController {

    private let primaryView: SettingsView = {
        let view = SettingsView()
        let viewModel = SettingsViewModel(options: SettingOption.allCases)
        view.configure(with: viewModel)
        return view
    }()

    private let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupNavigationBar()
        view.addSubview(primaryView)
        primaryView.delegate = self
        addConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }

    private func setupGradient() {
        let (topColor, bottomColor) = getGradientColors()

        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.3, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.7, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
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


extension SettingsViewController: SettingsViewDelegate {
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
