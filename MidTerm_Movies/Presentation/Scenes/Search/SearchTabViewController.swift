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
    
    private var movies:[Media] = []
    
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
        
//        movieManager.SearchMoviesBy(Name: valueChangedText ) { movies in
//            self.movies = movies.results ?? []
//             print(movies)
//
//            DispatchQueue.main.async {
//                self.searchedMoviesTable.reloadData()
//            }
//
//        }
        movieManager.MultiMediaSearchBy(Name: valueChangedText){ allContent in
            print(allContent)
            print("sndfkjnsd")
            
            self.movies = (allContent.results ?? []).filter{$0.mediaType == MediaType.movie}
            self.tvShows = (allContent.results ?? []).filter{$0.mediaType == MediaType.tv}
            print(self.movies.count)
            print(self.tvShows.count)
            
            DispatchQueue.main.async {
                self.searchedMoviesTable.reloadData()
            }
        }
    }
    
    
    func createCustomTableHeaderView (title : String)->UIView{
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: self.searchedMoviesTable.frame.width,
                                              height: 40))
      
        
        lazy var myLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = title
            label.backgroundColor = .white
            label.font = UIFont.systemFont(ofSize: 17)
            return label
        }()
        
//        let lineView = UIView(frame: CGRect(x: 0,
//                                              y: 0,
//                                            width: self.searchedMoviesTable.frame.width - myLabel.frame.width,
//                                              height: 3))
       
        
        
//        headerView.addSubview(lineView)
//        lineView.backgroundColor = .gray
        
        headerView.addSubview(myLabel)
        headerView.backgroundColor = .white
        
     
        
       
            
            // Set its constraint to display it on screen
        myLabel.heightAnchor.constraint(equalToConstant:  myLabel.frame.height).isActive = true
        myLabel.widthAnchor.constraint(equalToConstant:  myLabel.frame.width).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        myLabel.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        myLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true

        
        
      
//        // Set its constraint to display it on screen
//        lineView.widthAnchor.constraint(equalToConstant: headerView.frame.width - myLabel.frame.width).isActive = true
//        lineView.leadingAnchor.constraint(equalTo: myLabel.leadingAnchor).isActive = true
//        lineView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
//        lineView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
//        lineView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        return headerView
    }

}


extension SearchTabViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
    
    // Create a standard header that includes the returned text.
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        
        
       return "Header \(section)"
    }
    
    // Header Cell
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           
        var headerCell:UIView?
        
            switch (section) {
            case 0:
                headerCell = createCustomTableHeaderView (title : "TV SHOWS")
            case 1:
                headerCell =  createCustomTableHeaderView (title : "MOVIES")
            case 2:
                headerCell = createCustomTableHeaderView (title : "Vegetable")
            default:
                headerCell = createCustomTableHeaderView (title : "Other")
            }

            return headerCell
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return tvShows.count
        case 1:
            return movies.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row <= tvShows.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedResultTableViewCell", for: indexPath) as! SearchedResultTableViewCell
            cell.configure(with: tvShows[indexPath.row])
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedResultTableViewCell", for: indexPath) as! SearchedResultTableViewCell
            cell.configure(with: movies[indexPath.row - tvShows.count])
            
            return cell
        }
        
       
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
