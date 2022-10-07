//
//  MovieDetailView.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 4/10/22.
//

import UIKit
import Stevia
import Kingfisher

final class MovieDetailView: UIView {
    
    var movie: Movie

    private var titleView = {
        let view = UIView()
        view.backgroundColor = ColorStore.detailBackground.color
        return view
    }()
    private var titleLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = ColorStore.detailLabelText.color
        label.textAlignment = .center
        return label
    }()
    private var topView = {
        let view = UIView()
        view.backgroundColor = ColorStore.detailBackground.color
        return view
    }()
    private var topLeftView = {
        let view = UIView()
        view.backgroundColor = ColorStore.detailBackground.color
        return view
    }()
    private var topRightView = {
        let view = UIView()
        view.backgroundColor = ColorStore.detailBackground.color
        return view
    }()
    private var posterView = {
        let view = UIImageView()
        view.image = ImageStore.eyeSlashRect.image
        view.contentMode = .scaleAspectFit
        return view
    }()
    private var directorLabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = ColorStore.detailLabelText.color
        label.text = "Director"
        return label
    }()
    private var directorTextView = {
        let textView = UITextView()
        textView.backgroundColor = ColorStore.detailBackground.color
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = ColorStore.detailLabelText.color
        textView.isEditable = false
        return textView
    }()
    private var staringLabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = ColorStore.detailLabelText.color
        label.text = "Starring"
        return label
    }()
    private var staringTextView = {
        let textView = UITextView()
        textView.backgroundColor = ColorStore.detailBackground.color
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = ColorStore.detailLabelText.color
        textView.isEditable = false
        return textView
    }()
    private var ratingsLabel = {
        let label = UILabel()
        label.textColor = ColorStore.detailLabelText.color
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Ratings"
        return label
    }()
    private var ratingsTextView = {
        let textView = UITextView()
        textView.backgroundColor = ColorStore.detailBackground.color
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = ColorStore.detailLabelText.color
        textView.isEditable = false
        return textView
    }()
    private var bottomView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private var bottomTextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = UIFont.italicSystemFont(ofSize: 14)
        textView.textColor = ColorStore.detailBackground.color
        textView.isEditable = false
        return textView
    }()
        
    init(movie: Movie) {
        self.movie = movie
        super.init(frame: CGRect.zero)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        backgroundColor = .white
        addViews()
        addData()
        layoutViews()
    }
    
    private func addViews() {
        addSubviews([titleView, topView, bottomView])
        titleView.addSubviews([titleLabel])
        topView.addSubviews([topLeftView, topRightView])
        topLeftView.addSubviews([posterView])
        topRightView.addSubviews([directorLabel, directorTextView, staringLabel, staringTextView, ratingsLabel, ratingsTextView])
        bottomView.addSubviews([bottomTextView])
    }
    
    private func addData() {
        titleLabel.text = checkForEmpty(movie.title)
        posterView.kf.setImage(with: URL(string: movie.poster), placeholder: ImageStore.eyeSlashRect.image)
        directorTextView.text = checkForEmpty(movie.director)
        staringTextView.text = checkForEmpty(movie.actors)
        ratingsTextView.text = checkForEmpty(movie.ratingsText)
        bottomTextView.text = checkForEmpty(movie.plot)
    }
    
    private func checkForEmpty(_ text: String) -> String {
        text.isBlank ? "N/A" : text
    }
    
    private let labelHeight:SteviaPercentage = 8%
    private let directorTextViewHeight:SteviaPercentage = 15%
    private let topLeftViewWidth:SteviaPercentage = 60%
    private let topRightViewWidth:SteviaPercentage = 40%
    private let staringTextViewHeight:SteviaPercentage = 25%
    private let ratingsTextViewHeight:SteviaPercentage = 42%
    private let posterViewHeight:SteviaPercentage = 95%
    private let posterViewWidth:SteviaPercentage = 95%

    private func layoutViews() {
        titleView.fillHorizontally().height(labelHeight).Top == safeAreaLayoutGuide.Top
        titleLabel.fillVertically().fillHorizontally(padding: 15)
        topView.height(55%).fillHorizontally().Top == titleView.Bottom
        topLeftView.fillVertically().left(0).width(topLeftViewWidth)
        topRightView.fillVertically().right(0).width(topRightViewWidth)
        directorLabel.left(5).top(0).height(labelHeight)
        directorTextView.fillHorizontally().height(directorTextViewHeight).Top == directorLabel.Bottom
        staringLabel.left(5).height(labelHeight).Top == directorTextView.Bottom
        staringTextView.fillHorizontally().height(staringTextViewHeight).Top == staringLabel.Bottom
        ratingsLabel.left(5).height(labelHeight).Top == staringTextView.Bottom
        ratingsTextView.fillHorizontally().height(ratingsTextViewHeight).Top == ratingsLabel.Bottom
        posterView.left(5).width(posterViewWidth).top(0).height(posterViewHeight)
        bottomView.fillHorizontally().bottom(0).Top == topView.Bottom
        bottomTextView.fillContainer(padding: 10)
    }
}
