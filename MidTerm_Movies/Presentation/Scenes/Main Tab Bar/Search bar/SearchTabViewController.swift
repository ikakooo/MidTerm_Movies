//
//  SearchTabViewController.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 24.10.21.
//

import UIKit

class SearchTabViewController: UIViewController {
     @IBOutlet weak private var searchMovieInput: UITextField!
     @IBOutlet weak private var searchedMoviesTable: UITableView!
    
    private var networkManager: NetworkManagerProtocol!
    private var movieManager: MoviesDataManager!
    
    private var movies:[Movie] = []
    
    private var tvShows:[Media] = []
    
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
             print(movies)

            DispatchQueue.main.async {
                self.searchedMoviesTable.reloadData()
            }

        }
//        movieManager.MultiMediaSearchBy(Name: valueChangedText){ allContent in
//            print(allContent)
//            print("sndfkjnsd")
//
//            self.movies = (allContent.results ?? []).filter{$0.mediaType == MediaType.movie}
//            self.tvShows = (allContent.results ?? []).filter{$0.mediaType == MediaType.tv}
//            print(self.movies.count)
//            print(self.tvShows.count)
//
//            DispatchQueue.main.async {
//                self.searchedMoviesTable.reloadData()
//            }
//        }
        
//        movieManager.TvShowSearchBy(Name: valueChangedText){tvShows in
//            self.tvShows = tvShows.results ?? []
//             print(tvShows)
//
//            DispatchQueue.main.async {
//                self.searchedMoviesTable.reloadData()
//            }
//
//        }
    }
    
    
    func createCustomTableHeaderView (title : String)->UIView{
        let headerView = UIView()
      
        
        lazy var myLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = title
            label.backgroundColor = .white
            label.font = UIFont.systemFont(ofSize: 17)
            return label
        }()
        
        let lineView = UIView(frame: CGRect(x: 0,y: 0,width: self.searchedMoviesTable.frame.width ,height: 3))
        
        
        headerView.addSubview(lineView)
        lineView.backgroundColor = .gray
        
        headerView.addSubview(myLabel)
        headerView.backgroundColor = .white
       
        
        
        // Set its constraint to display it on screen
    NSLayoutConstraint.activate([
    
        headerView.heightAnchor.constraint(equalToConstant:  40),
//        line.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//        line.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
//        line.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant:   20.0)
    ])
        
       
     
            // Set its constraint to display it on screen
        NSLayoutConstraint.activate([
            myLabel.heightAnchor.constraint(equalToConstant:  40),
           // myLabel.widthAnchor.constraint(equalToConstant:  headerView.frame.width),
            myLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            //myLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            //myLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
           // myLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            myLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            //myLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
       
       // line.center =  myLabel.center
        
        
      
        // Set its constraint to display it on screen
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant:  40),
           // lineView.widthAnchor.constraint(equalToConstant: headerView.frame.width - myLabel.frame.width),
           // lineView.leadingAnchor.constraint(equalTo: myLabel.trailingAnchor),
            lineView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            // lineView.topAnchor.constraint(equalTo: headerView.topAnchor),
            lineView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            lineView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            //lineView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
        //lineView.frame.origin.y =   headerView.bounds.maxY / 2 // headerView.bounds.maxY/2
        
        return headerView
    }

}


extension SearchTabViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch (true) {
        case !self.movies.isEmpty && !self.tvShows.isEmpty: return 2
        case !self.movies.isEmpty || !self.tvShows.isEmpty  : return 1
       
        default: return 0
        }
    }
    
    
//    // Header Cell
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        var headerCell:UIView?
//
//            switch (section) {
//            case 0:
//                if !self.movies.isEmpty{ headerCell = createCustomTableHeaderView (title : "TV SHOWS")} else {
//                    headerCell =  createCustomTableHeaderView (title : "MOVIES")}
//            case 1:
//                headerCell =  createCustomTableHeaderView (title : "MOVIES")
//            case 2:
//                headerCell = createCustomTableHeaderView (title : "Vegetable")
//            default:
//                headerCell = createCustomTableHeaderView (title : "Other")
//            }
//
////        switch (true) {
////        case !self.movies.isEmpty:
////        case !self.tvShows.isEmpty  : return 1
////        case !self.movies.isEmpty && !self.tvShows.isEmpty: return 2
////        default: return 0
////        }
//
//            return headerCell
//        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
//        case 0:
//            return tvShows.count
//        case 1:
//            return movies.count
        default:
            return movies.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.row < tvShows.count {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedResultTableViewCell", for: indexPath) as! SearchedResultTableViewCell
//            cell.configure(with: tvShows[indexPath.row])
//
//            return cell
//        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedResultTableViewCell", for: indexPath) as! SearchedResultTableViewCell
            cell.configure(with: movies[indexPath.row - tvShows.count])
            
            return cell
      //  }
        
       
    }
}

extension SearchTabViewController: UITableViewDelegate{
    
    
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
