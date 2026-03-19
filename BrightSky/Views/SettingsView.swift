//
//  SettingsView.swift
//  BrightSky
//
//  Created by Tarun Sharma on 09/01/26.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func settingsView(_ view: SettingsView, didTap option: SettingOption)
}

final class SettingsView: UIView {

    weak var delegate: SettingsViewDelegate?

    private var viewModel: SettingsViewModel? {
        didSet {
            tableView.reloadData()
        }
    }

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorColor = UIColor.white.withAlphaComponent(0.15)
        table.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        addConstraints()
        tableView.delegate = self
        tableView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    public func configure(with viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
}


extension SettingsView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.options.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        if let viewModel {
            cell.configure(with: viewModel.options[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel else { return }
        let option = viewModel.options[indexPath.row]
        delegate?.settingsView(self, didTap: option)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}


// MARK: - Custom Glass Settings Cell

final class SettingsCell: UITableViewCell {
    static let identifier = "SettingsCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()

    private let chevron: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.white.withAlphaComponent(0.5)
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Frosted glass background
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
        blur.translatesAutoresizingMaskIntoConstraints = false
        backgroundView = blur

        // Highlight view on selection
        let selectedBlur = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
        selectedBackgroundView = selectedBlur

        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(titleLabel)
        contentView.addSubview(chevron)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: chevron.leadingAnchor, constant: -8),

            chevron.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevron.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(with option: SettingOption) {
        titleLabel.text = option.title
    }
}
