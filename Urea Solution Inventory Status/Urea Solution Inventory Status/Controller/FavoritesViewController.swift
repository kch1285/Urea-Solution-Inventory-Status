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
    static var favorites: [Favorite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFavoritesView()
        loadFavorites()
    }
    
    private let emptyLabel = UILabel().then {
        $0.isHidden = true
        $0.text = "즐겨찾기가 비어있습니다 !"
        $0.numberOfLines = 0
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
        
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func loadFavorites() {
        guard let data = UserDefaults.standard.value(forKey: "favorites") as? Data else {
            return
        }
        FavoritesViewController.favorites = try! PropertyListDecoder().decode([Favorite].self, from: data)
        
        if FavoritesViewController.favorites.isEmpty {
            showEmptyLabel(true)
        }
        else {
            showEmptyLabel(false)
            favoritesTableView.reloadData()
        }
    }
    
    private func showEmptyLabel(_ show: Bool) {
        emptyLabel.isHidden = !show
    }
}

//MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let stationName = FavoritesViewController.favorites[indexPath.row].data.name
        let stationAddr = FavoritesViewController.favorites[indexPath.row].data.addr
        let vc = SpecificViewController()
        
        UreaSolutionManager.shared.search(stationName) { [weak self] result in
            switch result {
            case .success(let data):
                vc.specificData = data.filter { $0.name == stationName && $0.addr == stationAddr }.first
                DispatchQueue.main.async {
                    self?.present(vc, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoritesViewController.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.idenrifier, for: indexPath) as! LocationTableViewCell
        cell.configure(with: FavoritesViewController.favorites[indexPath.row].data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavoritesViewController.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(FavoritesViewController.favorites), forKey: "favorites")
            if FavoritesViewController.favorites.isEmpty {
                showEmptyLabel(true)
            }
        }
    }
}
