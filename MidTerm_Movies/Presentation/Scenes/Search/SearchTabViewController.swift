//
//  SearchTabViewController.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 24.10.21.
//

import UIKit

class SearchTabViewController: UIViewController {
    @IBOutlet weak var searchMovieInput: UITextField!
    @IBOutlet weak var searchedMoviesTable: UITableView!
    
    private var networkManager: NetworkManagerProtocol!
    private var movieManager: MoviesDataManager!
    
    private var movies:[Movie] = []
    private var page = 1
    fileprivate var cellIndexPathRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        searchedMoviesTable.dataSource = self
        searchedMoviesTable.delegate = self
        searchedMoviesTable.register(UINib(nibName: "SearchedResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchedResultTableViewCell")
        
        searchMovieInput.addTarget(self, action: #selector(self.textFieldDidChange(sender:)), for: .editingChanged)

        
        networkManager = NetworkManager()
        // DI - Dependenc injection
        movieManager = MoviesDataManager(networkManager: networkManager)
        
       
    }

    @objc func textFieldDidChange(sender: UITextField){
       print("textFieldDidChange is called")
       // print(sender.text)
        
        guard let valueChangedText = sender.text  else { return }
        
        movieManager.SearchMoviesBy(Name: valueChangedText ) { movies in
            self.movies = movies.results ?? []
            // print(movies)
            
            DispatchQueue.main.async {
                self.searchedMoviesTable.reloadData()
            }
            
        }
    }

}


extension SearchTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedResultTableViewCell", for: indexPath) as! SearchedResultTableViewCell
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
}

extension SearchTabViewController: UITableViewDelegate{
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        cellIndexPathRow = indexPath.row
//        performSegue(withIdentifier: "MovieFullScreenViewController", sender: nil)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let viewControler =   segue.destination as? MovieFullScreenViewController
//        viewControler?.movie = movies[cellIndexPathRow]
//        print("taskkkkkkkk \(cellIndexPathRow)")
//    }
    
}
