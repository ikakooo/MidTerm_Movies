//
//  MovieFullScreenViewController.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 01.11.21.
//

import UIKit
import Kingfisher

class MovieFullScreenViewController: UIViewController {
    @IBOutlet weak private var filmName: UILabel!
    @IBOutlet weak private var reitingStars: UIButton!
    @IBOutlet weak private var filmdescription: UILabel!
    @IBOutlet weak private var moviePhoto: UIImageView!
    
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .gray
        filmName.text = movie?.title
        filmdescription.text = movie?.overview
        loadIMGFromInternet(ImgURL:MovieConstants.BASE_IMG_URL + (movie?.posterPath ?? ""))
    }
    
    
    func loadIMGFromInternet(ImgURL:String){
        let url = URL(string: ImgURL)
        let processor = DownsamplingImageProcessor(size: moviePhoto.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 0)
        moviePhoto.kf.indicatorType = .activity
        moviePhoto.kf.setImage(
            with: url,
            placeholder: UIImage(named: "movie"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
}
