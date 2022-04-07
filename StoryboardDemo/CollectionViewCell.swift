//
//  CollectionViewCell.swift
//  StoryboardDemo
//
//  Created by Gajender Jangir on 06/04/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var MoviePic: UIImageView!
    @IBOutlet weak var MovieName: UILabel!
    
    func setup(with movie:Movie)
    {
        MoviePic.image=movie.image
        MovieName.text=movie.title 
    }
    
}
