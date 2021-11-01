//
//  InfinityMoviesByCategoryViewController.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 01.11.21.
//

import UIKit

class InfinityMoviesByCategoryViewController: UIViewController {
    @IBOutlet weak var movieTableView: UITableView!
    
    private var networkManager: NetworkManagerProtocol!
    private var movieManager: MoviesDataManager!

    private var movies:[Movie] = []
    var tag = 0
    var page = 1
    fileprivate var cellIndexPathRow = 0
    private var categoryBaseURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .gray
        // Do any additional setup after loading the view.
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        
        switch tag {
        case 0:categoryBaseURL = MovieConstants.popularMoviesPath
        case 1:categoryBaseURL = MovieConstants.newMoviesPath
        case 2:categoryBaseURL = MovieConstants.nowPlayingMoviesPath
        case 3:categoryBaseURL = MovieConstants.topRatedMoviesPath
        default:print(tag)
        }
        print(tag)
    
        
        
        networkManager = NetworkManager()
        // DI - Dependenc injection
        movieManager = MoviesDataManager(networkManager: networkManager)
        
        movieManager.getMovies(page: page, path: categoryBaseURL){movies in
            self.movies = movies.results ?? []
            
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }

    }
}

extension InfinityMoviesByCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        
        if (indexPath.row == movies.count-1 && 500 > indexPath.row){
            movieManager.getMovies(page: self.page, path: categoryBaseURL ) { movies in
                self.movies.append(contentsOf:movies.results ?? [])
                // print(movies)
                
                DispatchQueue.main.async {
                    self.movieTableView.reloadData()
                }
                self.page+=1
            }
        }
        return cell
    }
}

extension InfinityMoviesByCategoryViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellIndexPathRow = indexPath.row
        performSegue(withIdentifier: "MovieFullScreenViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewControler =   segue.destination as? MovieFullScreenViewController
        viewControler?.movie = movies[cellIndexPathRow]
        print("taskkkkkkkk \(cellIndexPathRow)")
    }
    
}
