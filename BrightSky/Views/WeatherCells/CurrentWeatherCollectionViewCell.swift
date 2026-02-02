//
//  CurrentWeatherCollectionViewCell.swift
//  BrightSky
//
//  Created by Tarun Sharma on 27/01/26.
//

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CurrentWeatherCollectionViewCell"
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 45, weight: .medium)
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .regular)
        return label
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tempLabel)
        contentView.addSubview(icon)
        contentView.addSubview(conditionLabel)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            tempLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            icon.heightAnchor.constraint(equalToConstant: 55),
            icon.widthAnchor.constraint(equalToConstant: 55),
            icon.topAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            conditionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            conditionLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 10),
            conditionLabel.heightAnchor.constraint(equalToConstant: 80),
            conditionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15),
            conditionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        conditionLabel.text = nil
        icon.image = nil
        tempLabel.text = nil
    }
    
    public func configure(with viewModel: CurrentWeatherCollectionViewCellViewModel) {
        icon.image = UIImage(systemName: viewModel.iconName)
        conditionLabel.text = viewModel.condition
        
        tempLabel.text = Resources().formatTemperature (temp: viewModel.temperature)
    }
}
