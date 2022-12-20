//
//  UserDetailsswift
//  ViperDemo
//
//  Created by Adeel Tahir on 18/12/2022.
//

import UIKit

class UserDetailsCell: UITableViewCell {
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var hireableView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(withDetails details: UserDetailsModel) {
        if let bio = details.bio {
            bioLabel.text = bio
            bioLabel.isHidden = false
        } else {
            bioLabel.isHidden = true
        }
        
        if let email = details.email {
            emailLabel.text = email
            emailLabel.isHidden = false
        } else {
            emailLabel.isHidden = true
        }
        
        if let blog = details.blog {
            blogLabel.text = blog
            blogLabel.isHidden = false
        } else {
            blogLabel.isHidden = true
        }
        
        if let company = details.company {
            companyLabel.text = company
            companyLabel.isHidden = false
        } else {
            companyLabel.isHidden = true
        }
        
        if let hireable = details.hireable {
            hireableView.isHidden = hireable
        }
        else {
            hireableView.isHidden = true
        }
    }
}
