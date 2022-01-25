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
    private let viewModel = FavoriteViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFavoritesView()
        loadFavorites()
        configureObserver()
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
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(ob), name: Notification.Name("ob"), object: nil)
    }
    
    @objc private func ob() {
        favoritesTableView.reloadData()
        if viewModel.getFavoriteList().isEmpty {
            showEmptyLabel(true)
        }
    }
    
    private func loadFavorites() {
        let favorites = viewModel.getFavoriteList()
        if favorites.isEmpty {
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
        
        let stationName = viewModel.getFavoriteList()[indexPath.row].data.name
        let stationAddr = viewModel.getFavoriteList()[indexPath.row].data.addr
        let vc = SpecificViewController()
        
        UreaSolutionManager.shared.fetchInventory(station: stationName) { [weak self] result in
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
        return viewModel.getFavoriteListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.idenrifier, for: indexPath) as! LocationTableViewCell
        print("cellForRowAt")
        cell.configure(with: viewModel.getFavoriteList()[indexPath.row].data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let beRemoved = viewModel.getFavoriteList()[indexPath.row]
            viewModel.removeFavoriteEntity(beRemoved)
            if viewModel.getFavoriteList().isEmpty {
                showEmptyLabel(true)
            }
        }
    }
}
