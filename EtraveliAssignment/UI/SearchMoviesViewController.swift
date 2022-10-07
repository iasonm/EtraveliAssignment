//
//  SearchMoviesViewController.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 3/10/22.
//

import UIKit
import Stevia

class SearchMoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let api: OMDBprovider = MoyaOMDBApi()

    private var movieList = [Movie]()
    
    private var fetching = false {
        didSet {
            DispatchQueue.main.async {
                self.fetching ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private var noResults = false {
        didSet {
            noResultsView.isHidden = !noResults
        }
    }
    
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureSearchBar() {
        searchBar.placeholder = "Enter text to search in OMDB"
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.searchTextField.becomeFirstResponder()
    }
    
    private func search(term: String) {
        fetching = true
        api.searchByTitle(term) { result in
            switch result {
            case .success(let moviesDataList):
                DispatchQueue.main.async {
                    let newList = moviesDataList.map { Movie(moviesData: $0) }
                    self.updateSearchList(newList)
                }
            case .failure(let error):
                self.showErrorAlert(error: error)
            }
        }
    }
    
    
    
    private func updateSearchList(_ list: [Movie]) {
        tableView.setContentOffset(.zero, animated: false)
        movieList = list
        if movieList.isEmpty {
            noResults = true
            searchBar.text = ""
            searchBar.searchTextField.becomeFirstResponder()
        } else {
            noResults = false
        }
        tableView.reloadData()
        fetching = false
    }
    
    private func showErrorAlert(error: Error) {
        DispatchQueue.main.async {
            self.noResults = true
            let alert = Alerts.okAlert(title: "Something went wrong!", message: "There was an error getting your data:\n\(error.localizedDescription)")
            self.present(alert, animated: true)
        }
    }
}

extension SearchMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movieList[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.id, for: indexPath) as? MovieTableViewCell {
            cell.setMovie(movie)
            return cell
        }
        return MovieTableViewCell()
    }
    
}

extension SearchMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !fetching else { return }
        let movie = movieList[indexPath.row]
        let vc = MovieDetailViewController()
        fetching = true
        api.searchById(id: movie.id) { result in
            switch result {
            case .success(let moviesData):
                let movie = Movie(moviesData: moviesData)
                DispatchQueue.main.async {
                    vc.movie = movie
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                self.showErrorAlert(error: error)
            }
            self.fetching = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

extension SearchMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let term = searchBar.text {
            if !fetching {
                search(term: term)
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
}
