//
//  HourlyWeatherCollectionViewCell.swift
//  BrightSky
//
//  Created by Tarun Sharma on 27/01/26.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "HourlyWeatherCollectionViewCell"
    
    private let blurView: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.layer.cornerRadius = 20
        blur.clipsToBounds = true
        return blur
    }()

    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.7)
        return label
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Glass border
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.white.withAlphaComponent(0.25).cgColor
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = true
        
        contentView.addSubview(blurView)
        blurView.contentView.addSubview(timeLabel)
        blurView.contentView.addSubview(icon)
        blurView.contentView.addSubview(tempLabel)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            blurView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            blurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            timeLabel.topAnchor.constraint(equalTo: blurView.contentView.topAnchor, constant: 12),
            timeLabel.leftAnchor.constraint(equalTo: blurView.contentView.leftAnchor),
            timeLabel.rightAnchor.constraint(equalTo: blurView.contentView.rightAnchor),
            
            icon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            icon.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: 30),
            icon.widthAnchor.constraint(equalToConstant: 30),
            
            tempLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 8),
            tempLabel.leftAnchor.constraint(equalTo: blurView.contentView.leftAnchor),
            tempLabel.rightAnchor.constraint(equalTo: blurView.contentView.rightAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: blurView.contentView.bottomAnchor, constant: -12)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
        tempLabel.text = nil
        timeLabel.text = nil
    }
    
    public func configure(with viewModel: HourlyWeatherCollectionViewCellViewModel) {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
        icon.image = UIImage(systemName: viewModel.iconname, withConfiguration: config)
        timeLabel.text = viewModel.hour
        tempLabel.text = Resources().formatTemperature(temp: viewModel.temperature)
    }
}
