//
//  SettingsView.swift
//  BrightSky
//
//  Created by Tarun Sharma on 09/01/26.
//

import UIKit

protocol SettingsViewDelegate : AnyObject {
    func settingsView(_ view: SettingsView, didTap option: SettingOption)
}

final class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate?
    
    private var viewModel : SettingsViewModel? {
        didSet{
            tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let viewModel {
            cell.textLabel?.text = viewModel.options[indexPath.row].title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let viewModel else { return }
        let option = viewModel.options[indexPath.row]
        // Handle tap
        delegate?.settingsView(self, didTap: option)
    }
    
    
}
