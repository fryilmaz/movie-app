//
//  ViewController.swift
//  MovieApp
//
//  Created by Faruk on 7.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import UIKit

private let detailSegueIdentifier = "movieDetailSegue"
private let movieCellIdentifier = "movieCell"

extension Notification.Name {
    public static let favoriteNotificationKey = Notification.Name(rawValue: "favoriteListener")
}

class MovieController: UIViewController {

    @IBOutlet var movieCollectionView: UICollectionView!
    @IBOutlet var loadMoreButton: UIButton!
    
    @IBOutlet var presentationTypeButton: UIBarButtonItem!
    @IBOutlet var searchBar: UISearchBar!
    var viewModel: MoviesViewModel!
    let movieService = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        searchBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.favoriteListener(_:)), name: .favoriteNotificationKey, object: nil)
        
        viewModel = MoviesViewModel(service: movieService)
        viewModel.fetchMovies()
        viewModel.moviesDidLoadSucceed = {
            self.movieCollectionView.performBatchUpdates({
                self.movieCollectionView.reloadSections(IndexSet(integer: 0))
            }, completion: nil)
        }
        viewModel.moviesDidLoadFailed = { err in
            print(err)
            let alert = UIAlertController(title: "Alert", message: err, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        movieCollectionView.decelerationRate = .init(rawValue: 0.7)
        
    }

    @IBAction func loadMoreAction(_ sender: Any) {
        viewModel.pageId += 1
        viewModel.fetchMovies()
    }

    @IBAction func changePresentationAction(_ sender: Any) {
        if viewModel.presentationStyle == .grid{
            viewModel.presentationStyle = .table
            presentationTypeButton.image = UIImage(named: "grid-icon")!
        }
        else {
            viewModel.presentationStyle = .grid
            presentationTypeButton.image = UIImage(named: "list-icon")!
        }
        
        movieCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier{
            let vc = segue.destination as! MovieDetailController
            vc.movie = viewModel.selectedMovie
            vc.selectedIndexPath = viewModel.selectedIndexPath
        }
    }
    
    @objc func favoriteListener(_ notification: Notification){
        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        movieCollectionView.reloadItems(at: [indexPath])
    }
}

extension MovieController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath) as! MovieCell
        let movie = viewModel.dataSource[indexPath.row]
        
        var posterWidth = "200"
        switch viewModel.presentationStyle {
        case .grid:
            posterWidth = "200"
        case .table:
            posterWidth = "300"
        }
        
        cell.configureCell(movie: movie,width: posterWidth)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch viewModel.presentationStyle {
        case .grid:
            return CGSize(width: (collectionView.frame.size.width - 10 - 10) / 2 , height: 300)
        case .table:
            return CGSize(width: (collectionView.frame.size.width - 10 - 10) , height: 450)
        }        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = viewModel.dataSource[indexPath.row]
        viewModel.selectedMovie = movie
        viewModel.selectedIndexPath = indexPath
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: detailSegueIdentifier, sender: nil)
        }       
    }
    
}

extension MovieController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchKey = searchText
        viewModel.handleCollectionData()
        self.movieCollectionView.performBatchUpdates({
            self.movieCollectionView.reloadSections(IndexSet(integer: 0))
        }, completion: nil)
    }
}
