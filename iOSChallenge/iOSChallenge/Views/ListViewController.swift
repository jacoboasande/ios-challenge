//
//  ListingViewController.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import UIKit
import Combine

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var viewModel: ListViewModel!
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupTableView()
        setupViewModel()
    }

    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        // Register custom cell
        tableView.register(ListingTableViewCell.self, forCellReuseIdentifier: ListingTableViewCell.reuseIdentifier)

        // Set delegates
        tableView.dataSource = self
        tableView.delegate = self

        // Set constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupViewModel() {
        // Initialize your ViewModel
        viewModel = ListViewModel()

        // Bind ViewModel data to TableView
        viewModel.$listings
            .receive(on: DispatchQueue.main) // 🛠️ Required for UI updates
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)


        // Fetch data
        viewModel.fetchListings()
    }

    // MARK: UITableView DataSource & Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingTableViewCell.reuseIdentifier, for: indexPath) as! ListingTableViewCell
        let listing = viewModel.listings[indexPath.row]
        cell.configure(with: listing)
        print("Rendering cell for: \(listing.address)")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let listing = viewModel.listings[indexPath.row]
//        // Push to details screen (e.g., AdDetailViewController)
//        let detailVC = AdDetailViewController()
//        detailVC.listing = listing
//        navigationController?.pushViewController(detailVC, animated: true)
    }
}
