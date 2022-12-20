//
//  UserTableViewswift
//  ViperDemo
//
//  Created by Adeel Tahir on 17/12/2022.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(user: GithubUser) {
        userNameLabel.text = user.login
        
        self.userAvatar.sd_setImage(with: URL(string: user.avatarURL)) { image, error, cacheType, url in
            if image != nil {
                self.userAvatar.image = image
            }
        }
    }
    
    func configureRepo(repo: UserRepository) {
        mainView.backgroundColor = UIColor.clear
        infoImage.isHidden = true
        descriptionLabel.isHidden = true
        userAvatar.image = UIImage(named: "git-logo")
        userNameLabel.text = repo.name;
        
        userAvatar.layer.cornerRadius = userAvatar.frame.size.height/2
        userAvatar.layer.masksToBounds = true
        
        if let fullName = repo.fullName {
            descriptionLabel.isHidden = true
            descriptionLabel.text = fullName
        }
    }
    
    func configureFollower(follower: UserFollower) {
        mainView.backgroundColor = UIColor.clear
        infoImage.isHidden = true
        descriptionLabel.isHidden = true
        
        userNameLabel.text = follower.login
        
        if let type = follower.type {
            descriptionLabel.text = type
            descriptionLabel.isHidden = false
        }
        
        self.userAvatar.sd_setImage(with: URL(string: follower.avatarURL)) { image, error, cacheType, url in
            if image != nil {
                self.userAvatar.image = image
            }
        }
        
        userAvatar.layer.cornerRadius = userAvatar.frame.size.height/2
        userAvatar.layer.masksToBounds = true
    }
}
