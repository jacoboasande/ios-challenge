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
    private var expandedIndexPaths = Set<IndexPath>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        setupViewModel()
    }

    func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.register(ListingTableViewCell.self, forCellReuseIdentifier: ListingTableViewCell.reuseIdentifier)

        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupViewModel() {
        viewModel = ListViewModel()

        viewModel.$listings
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)

        viewModel.fetchListings()
    }

    // MARK: UITableView DataSource & Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listings.count
    }

    func tableView(_ tv: UITableView, cellForRowAt ip: IndexPath) -> UITableViewCell {
      let cell = tv.dequeueReusableCell(withIdentifier: ListingTableViewCell.reuseIdentifier, for: ip) as! ListingTableViewCell
      cell.delegate = self
      let listing = viewModel.listings[ip.row]
      let expanded = expandedIndexPaths.contains(ip)
      cell.configure(with: listing, isExpanded: expanded)
      return cell
    }

    func tableView(_ tv: UITableView, didSelectRowAt ip: IndexPath) {
      tv.deselectRow(at: ip, animated: true)
    }
}

// MARK: – ListingCellDelegate

extension ListViewController: ListingCellDelegate {
  func listingCell(_ cell: ListingTableViewCell, didToggleExpanded expanded: Bool) {
    guard let ip = tableView.indexPath(for: cell) else { return }

    if expanded {
      expandedIndexPaths.insert(ip)
    } else {
      expandedIndexPaths.remove(ip)
    }

    tableView.beginUpdates()
    cell.setExpanded(expanded)
    tableView.endUpdates()
  }
}
