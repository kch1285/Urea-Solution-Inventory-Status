//
//  FavoritesViewController.swift
//  Urea Solution Inventory Status
//
//  Created by chihoooon on 2022/01/02.
//

import UIKit
import Then
import SnapKit

class FavoritesViewController: UIViewController {
//    private var favorites: Results<Favorite>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFavoritesView()
        loadFavorites()
    }
    
    private let favoritesTableView = UITableView().then {
        $0.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.idenrifier)
        $0.backgroundColor = .clear
    }
    
    private func setUpFavoritesView() {
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        title = "즐겨찾기"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(favoritesTableView)
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func loadFavorites() {
        favoritesTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.idenrifier, for: indexPath)
        cell.textLabel?.text = "@@@@"
        return cell
    }
}
