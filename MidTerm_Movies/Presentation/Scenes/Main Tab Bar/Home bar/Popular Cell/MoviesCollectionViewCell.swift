//
//  PopularCollectionViewCell.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 24.10.21.
//

import UIKit
import Kingfisher

class MoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var movieName: UILabel!
    @IBOutlet weak private var movieIMG: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    
    func configure(with: Movie){
        movieName.text = with.title
        // reitingStars.setAllStatesTitle("\(String(describing: with.voteAverage ?? 0))")
        loadIMGFromInternet(ImgURL: MovieConstants.BASE_IMG_URL + (with.posterPath ?? ""))
    }
    
    
    func loadIMGFromInternet(ImgURL:String){
        let url = URL(string: ImgURL)
        let processor = DownsamplingImageProcessor(size: movieIMG.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 20)
        movieIMG.kf.indicatorType = .activity
        movieIMG.kf.setImage(
            with: url,
            placeholder: UIImage(named: "movie"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
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
