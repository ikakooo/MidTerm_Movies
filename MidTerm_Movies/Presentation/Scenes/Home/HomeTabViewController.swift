//
//  HomeTabViewController.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 24.10.21.
//

import UIKit

class HomeTabViewController: UIViewController {
    @IBOutlet weak var popularMoviesHorisontalColectionView: UICollectionView!
    
    
    private var networkManager: NetworkManagerProtocol!
    private var movieManager: MoviesDataManager!
    
    private var movies:[Movie] = []
    private var page = 1
    fileprivate var cellIndexPathRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        popularMoviesHorisontalColectionView.dataSource = self
        popularMoviesHorisontalColectionView.delegate = self
    
        
        popularMoviesHorisontalColectionView.register(
            UINib(nibName: "PopularCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "PopularCollectionViewCell"
        )
        
        networkManager = NetworkManager()
        // DI - Dependenc injection
        movieManager = MoviesDataManager(networkManager: networkManager)
        
        movieManager.getMovies(page: 1 ) { movies in
            self.movies = movies.results ?? []
            // print(movies)
            print("\(movies) ikakoooooooooooo")
            let cvccdv = movies.results?[0]
            
            DispatchQueue.main.async {
                self.popularMoviesHorisontalColectionView.reloadData()
            }
            
        }
        
        movieManager.getNewMovies(page: 1){movies in
            
            let cvccdv = movies.results?[0]
            
//             print("\(movies) ikakoooooooooooo")
        }
    }
    @IBAction func seeAllPopularMovies(_ sender: UIButton) {
    
    
    }
    
    @IBAction func seeAllNewMovies(_ sender: UIButton) {
    
    
    }
    

}



extension HomeTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
        
        
        cell.configure(with: movies[indexPath.row])
        
//        if (indexPath.row == movies.count-1 && 500 > indexPath.row){
//            movieManager.getMovies(page: page ) { movies in
//                self.movies.append(contentsOf:movies.results ?? [])
//                // print(movies)
//
//                DispatchQueue.main.async {
//                    self.popularMoviesHorisontalColectionView.reloadData()
//                }
//                self.page+=1
//            }
//        }
        
        return cell
    }
}

extension HomeTabViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        print("ikakooo \(width)")
        return CGSize(
            width: width - 16 - 16,
            height:  45
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
