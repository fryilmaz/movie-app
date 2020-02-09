//
//  MovieCell.swift
//  MovieApp
//
//  Created by Faruk on 8.02.2020.
//  Copyright © 2020 Faruk. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var starImageView: UIImageView!
    @IBOutlet var titleLabel: TitleLabel!
    
    func configureCell(movie:Movie,width:String = "200"){
        
        self.contentView.layer.cornerRadius = 10
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w\(width)\(movie.poster_path ?? "")")!
        posterImageView.load(url: posterUrl)
        titleLabel.text = movie.title ?? ""
        
        let defaults = UserDefaults.standard
        let favoritesArray = defaults.object(forKey: "favorites") as? [Int]
        starImageView.isHidden = !(favoritesArray?.contains(movie.id!) ?? true)
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//        posterImageView.image = nil
//    }
}
