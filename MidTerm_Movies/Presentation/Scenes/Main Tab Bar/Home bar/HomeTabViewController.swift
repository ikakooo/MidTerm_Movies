//
//  HomeTabViewController.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 24.10.21.
//

import UIKit

class HomeTabViewController: UIViewController {
    @IBOutlet weak var popularMoviesHorisontalColectionView: UICollectionView!
    @IBOutlet weak var newMoviesHorisontalColectionView: UICollectionView!
    @IBOutlet weak var nowPlayingMoviesHorisontalColectionView: UICollectionView!
    @IBOutlet weak var topRatedMoviesHorisontalColectionView: UICollectionView!
    
    private var networkManager: NetworkManagerProtocol!
    private var movieManager: MoviesDataManager!
    
    private var PopularMovies:[Movie] = []
    private var NewMovies:[Movie] = []
    private var NowPlayingMovies:[Movie] = []
    private var TopRatedMovies:[Movie] = []
    
    
    
    private var page = 1
    fileprivate var cellIndexPathRow = 0
    
    
    let collectionViewAIdentifier = "MoviesCollectionViewCell"
    let collectionViewBIdentifier = "CollectionViewBCell"
    
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
        
        switch sender.tag {
        case 0:print(sender.tag)
        case 1:print(sender.tag)
        case 2:print(sender.tag)
        case 3:print(sender.tag)
        default:print(sender.tag)
        }
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
        
        
//        if collectionView == self.popularMoviesHorisontalColectionView {
//            return PopularMovies.count
//            }
//        if collectionView == self.newMoviesHorisontalColectionView {
//            return NewMovies.count
//            }
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
        //print("ikakooo \(width)")
        return CGSize(
            width: width - 16 - 16,
            height:  45
        )
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        cellIndexPathRow = indexPath.row
        performSegue(withIdentifier: "MovieFullScreenViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewControler =   segue.destination as? MovieFullScreenViewController
        viewControler?.movie = PopularMovies[cellIndexPathRow]
        print("taskkkkkkkk \(cellIndexPathRow)")
    }
}
