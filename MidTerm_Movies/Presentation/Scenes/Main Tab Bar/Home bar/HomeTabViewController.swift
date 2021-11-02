//
//  HomeTabViewController.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 24.10.21.
//

import UIKit

class HomeTabViewController: UIViewController {
    @IBOutlet weak private var popularMoviesHorisontalColectionView: UICollectionView!
    @IBOutlet weak private var newMoviesHorisontalColectionView: UICollectionView!
    @IBOutlet weak private var nowPlayingMoviesHorisontalColectionView: UICollectionView!
    @IBOutlet weak private var topRatedMoviesHorisontalColectionView: UICollectionView!
    
    private var networkManager: NetworkManagerProtocol!
    private var movieManager: MoviesDataManager!
    
    private var PopularMovies:[Movie] = []
    private var NewMovies:[Movie] = []
    private var NowPlayingMovies:[Movie] = []
    private var TopRatedMovies:[Movie] = []
    private var SelectedMovie:Movie? = nil
    
    
    
    private var page = 1
    private var seeAllPageTag = 0
    fileprivate var cellIndexPathRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Popular movies
        popularMoviesHorisontalColectionView.dataSource = self
        popularMoviesHorisontalColectionView.delegate = self
        popularMoviesHorisontalColectionView.register(
            UINib(nibName: "MoviesCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MoviesCollectionViewCell"
        )
        // New Movies
        newMoviesHorisontalColectionView.dataSource = self
        newMoviesHorisontalColectionView.delegate = self
        newMoviesHorisontalColectionView.register(
            UINib(nibName: "MoviesCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MoviesCollectionViewCell"
        )
        // Now Playing
        nowPlayingMoviesHorisontalColectionView.dataSource = self
        nowPlayingMoviesHorisontalColectionView.delegate = self
        nowPlayingMoviesHorisontalColectionView.register(
            UINib(nibName: "MoviesCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MoviesCollectionViewCell"
        )
        // Top Rated
        topRatedMoviesHorisontalColectionView.dataSource = self
        topRatedMoviesHorisontalColectionView.delegate = self
        topRatedMoviesHorisontalColectionView.register(
            UINib(nibName: "MoviesCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MoviesCollectionViewCell"
        )
        
        
        networkManager = NetworkManager()
        // DI - Dependenc injection
        movieManager = MoviesDataManager(networkManager: networkManager)
        
        // Popular movies
        movieManager.getPopularMovies(page: 1 ) { movies in
            self.PopularMovies = movies.results ?? []
            DispatchQueue.main.async {
                self.popularMoviesHorisontalColectionView.reloadData()
            }
        }
        
        // New Movies
        movieManager.getNewMovies(page: 1){movies in
            self.NewMovies = movies.results ?? []
            DispatchQueue.main.async {
                self.newMoviesHorisontalColectionView.reloadData()
            }
        }
        //Now Playing
        movieManager.getNowPlayingMovies(page: 1){movies in
            self.NowPlayingMovies = movies.results ?? []
            DispatchQueue.main.async {
                self.nowPlayingMoviesHorisontalColectionView.reloadData()
            }
        }
        // Top Rated Movies
        movieManager.getTopRatedMovies(page: 1){movies in
            self.TopRatedMovies = movies.results ?? []
            DispatchQueue.main.async {
                self.topRatedMoviesHorisontalColectionView.reloadData()
            }
        }
    }
    
    @IBAction func seeAllMovies(_ sender: UIButton) {
        
        seeAllPageTag = sender.tag
        performSegue(withIdentifier: "InfinityMoviesByCategoryViewController", sender: nil)
        
    }
    
}



extension HomeTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.popularMoviesHorisontalColectionView: return PopularMovies.count
        case self.newMoviesHorisontalColectionView: return NewMovies.count
        case self.nowPlayingMoviesHorisontalColectionView: return NowPlayingMovies.count
        case self.topRatedMoviesHorisontalColectionView: return TopRatedMovies.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
        
        switch collectionView {
        case self.popularMoviesHorisontalColectionView:  cell.configure(with: PopularMovies[indexPath.row])
        case self.newMoviesHorisontalColectionView:  cell.configure(with: NewMovies[indexPath.row])
        case self.nowPlayingMoviesHorisontalColectionView:  cell.configure(with: NowPlayingMovies[indexPath.row])
        case self.topRatedMoviesHorisontalColectionView:  cell.configure(with: TopRatedMovies[indexPath.row])
        default:  print("No collectionView")
        }
        return cell
    }
}

extension HomeTabViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(
            width: width - 16 - 16,
            height:  45
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case self.popularMoviesHorisontalColectionView: SelectedMovie = PopularMovies[indexPath.row]
        case self.newMoviesHorisontalColectionView: SelectedMovie =  NewMovies[indexPath.row]
        case self.nowPlayingMoviesHorisontalColectionView: SelectedMovie =  NowPlayingMovies[indexPath.row]
        case self.topRatedMoviesHorisontalColectionView: SelectedMovie =  TopRatedMovies[indexPath.row]
        default:
            SelectedMovie = nil
        }
        performSegue(withIdentifier: "MovieFullScreenViewController", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewControler =   segue.destination as? MovieFullScreenViewController
        viewControler?.movie = SelectedMovie
        
        let InfinityMoviesViewControler =   segue.destination as? InfinityMoviesByCategoryViewController
        InfinityMoviesViewControler?.tag = seeAllPageTag
    }
}
