//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by Faruk on 8.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import UIKit

class MovieDetailController: UIViewController {

    var movie = Movie()
    var selectedIndexPath = IndexPath()
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overViewLabel: UILabel!
    @IBOutlet var voteCountLabel: UILabel!
    @IBOutlet var favoriteButton: UIBarButtonItem!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w300\(movie.poster_path ?? "")")!
        posterImageView.load(url: posterUrl)
        
        titleLabel.text = movie.title
        overViewLabel.text = movie.overview
        voteCountLabel.text = String (movie.vote_count ?? 0)
        
        if fetchFavorites().contains(movie.id!){
            favoriteButton.image = UIImage(named: "star")
        }
        else{
            favoriteButton.image = UIImage(named: "favorite")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: stackView.frame.size.height + posterImageView.frame.size.height + 50)
    }
    
    @IBAction func fovariteAction(_ sender: Any) {
        
        var favoritesArray = fetchFavorites()
        if favoritesArray.contains(movie.id!){
            favoritesArray.removeAll(where: {$0 == movie.id!})
            favoriteButton.image = UIImage(named: "favorite")
        }
        else{
            favoritesArray.append(movie.id!)
            favoriteButton.image = UIImage(named: "star")
        }
        defaults.set(favoritesArray, forKey: "favorites")
         NotificationCenter.default.post(name: .favoriteNotificationKey, object: nil, userInfo: ["indexPath":selectedIndexPath])
    }
    
    func fetchFavorites() -> [Int]{
        
        return defaults.object(forKey: "favorites") as? [Int] ?? [Int]()
    }
}
