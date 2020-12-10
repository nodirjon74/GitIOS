//
//  RepoTableViewCell.swift
//  NewmaxTech
//
//  Created by Nodir on 10/12/20.
//

import UIKit

@IBDesignable
class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoSubTitle: UILabel!
    @IBOutlet weak var watchersCount: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    static func nib() -> UINib {
        return UINib(nibName: "RepoTableViewCell", bundle: nil)
    }
}
