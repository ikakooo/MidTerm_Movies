//
//  SearchedResultTableViewCell.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 24.10.21.
//

import UIKit
import Kingfisher

class SearchedResultTableViewCell: UITableViewCell {
    @IBOutlet weak var filmMainPhoto: UIImageView!
    @IBOutlet weak var raitingStar: UIButton!
    @IBOutlet weak var filmName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(with: Movie){
        
        
        print("iakaooooo")
        print(with)
        filmName.text = with.title
        raitingStar.setAllStatesTitle("\(String(describing: with.voteAverage ?? 0))")
        loadIMGFromInternet(ImgURL: MovieConstants.BASE_IMG_URL + (with.posterPath ?? ""))
    }
    
    
    func loadIMGFromInternet(ImgURL:String){
        let url = URL(string: ImgURL)
        let processor = DownsamplingImageProcessor(size: filmMainPhoto.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        filmMainPhoto.kf.indicatorType = .activity
        filmMainPhoto.kf.setImage(
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
