//
//  CurrentWeatherCollectionViewCell.swift
//  BrightSky
//
//  Created by Tarun Sharma on 27/01/26.
//

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CurrentWeatherCollectionViewCell"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.75)
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 72, weight: .thin)
        label.textColor = .white
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.85)
        return label
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    // Groups icon + condition tightly with no SF Symbol whitespace gap
    private lazy var weatherInfoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [icon, conditionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(dateLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(weatherInfoStack)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 22),

            tempLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            tempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            weatherInfoStack.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 12),
            weatherInfoStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherInfoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            icon.heightAnchor.constraint(equalToConstant: 36),
            icon.widthAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        conditionLabel.text = nil
        icon.image = nil
        tempLabel.text = nil
        dateLabel.text = nil
    }
    
    public func configure(with viewModel: CurrentWeatherCollectionViewCellViewModel) {
        let config = UIImage.SymbolConfiguration(pointSize: 38, weight: .light)
        icon.image = UIImage(systemName: viewModel.iconName, withConfiguration: config)
        conditionLabel.text = viewModel.condition
        tempLabel.text = Resources().formatTemperature(temp: viewModel.temperature)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        dateLabel.text = formatter.string(from: Date())
    }
}
