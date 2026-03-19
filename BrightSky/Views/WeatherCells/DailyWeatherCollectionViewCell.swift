//
//  DailyWeatherCollectionViewCell.swift
//  BrightSky
//
//  Created by Tarun Sharma on 27/01/26.
//

import UIKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "DailyWeatherCollectionViewCell"
    
    private let blurView: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        blur.translatesAutoresizingMaskIntoConstraints = false
        blur.layer.cornerRadius = 16
        blur.clipsToBounds = true
        return blur
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
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
        contentView.layer.cornerRadius = 16
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

            timeLabel.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            timeLabel.leftAnchor.constraint(equalTo: blurView.contentView.leftAnchor, constant: 20),
            timeLabel.widthAnchor.constraint(equalToConstant: 110),
            
            icon.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: 28),
            icon.widthAnchor.constraint(equalToConstant: 28),
            
            tempLabel.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12),
            tempLabel.rightAnchor.constraint(equalTo: blurView.contentView.rightAnchor, constant: -20),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
        tempLabel.text = nil
        timeLabel.text = nil
    }
    
    public func configure(with viewModel: DailyWeatherCollectionViewCellViewModel) {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .light)
        icon.image = UIImage(systemName: viewModel.iconname, withConfiguration: config)
        timeLabel.text = viewModel.day
        tempLabel.text = viewModel.temperature
    }
}
