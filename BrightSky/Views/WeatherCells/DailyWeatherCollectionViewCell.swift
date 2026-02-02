//
//  DailyWeatherCollectionViewCell.swift
//  BrightSky
//
//  Created by Tarun Sharma on 27/01/26.
//

import UIKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "DailyWeatherCollectionViewCell"
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
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
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.addSubview(timeLabel)
        contentView.addSubview(icon)
        contentView.addSubview(tempLabel)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 40),
            
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leftAnchor.constraint(equalTo: timeLabel.rightAnchor),
            icon.heightAnchor.constraint(equalToConstant: 32),
            
            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tempLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            tempLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 20),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
        tempLabel.text = nil
        timeLabel.text = nil
    }
    
    public func configure(with viewModel: DailyWeatherCollectionViewCellViewModel) {
        icon.image = UIImage(systemName: viewModel.iconname)
        timeLabel.text = viewModel.day
        
        tempLabel.text = viewModel.temperature
    }
}


