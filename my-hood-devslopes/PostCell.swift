//
//  PostCell.swift
//  my-hood-devslopes
//
//  Created by Zafer Celaloglu on 27.12.2015.
//  Copyright © 2015 Zafer Celaloglu. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        postImage.layer.cornerRadius = postImage.frame.size.width / 2
        postImage.clipsToBounds = true
    }

    func configureCell(post: Post) {
        titleLbl.text = post.title
        descLbl.text = post.postDesc
        postImage.image = DataService.instance.imageForPath(post.imagePath)
    }

}
