//
//  MovieDetailViewController.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 3/10/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: Movie!
    
    override func loadView() {
        let movieDetailView = MovieDetailView(movie: movie)
        view = movieDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
    }
    
}
