//
//  MovieTableViewCell.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 3/10/22.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    static let id = "movieCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    func setMovie(_ movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = movie.year
        posterImageView.kf.setImage(with: URL(string: movie.poster), placeholder: ImageStore.eyeSlashSquare.image)
    }

}
