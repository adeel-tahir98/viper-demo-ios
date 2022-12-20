//
//  UserDetailsOptionHeaderView.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 18/12/2022.
//

import UIKit

enum DetailOption : Int {
    case followers
    case repos
}

protocol UserDetailsOptionHeaderProtocol: AnyObject {
    func didSelect(_ option: DetailOption)
}

class UserDetailsOptionHeaderView: UIView {
    
    @IBOutlet weak var repositoriesView: UIView!
    @IBOutlet weak var followersView: UIView!
    @IBOutlet weak var selectedOptionView: UIView!
    @IBOutlet weak var repositoriesCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    weak var delegate: UserDetailsOptionHeaderProtocol?
    
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
    
    private func updateSelectedView(_ sourceView: UIView?) {
        // update selected view position
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: { [self] in
            selectedOptionView.center = CGPoint(x: sourceView?.center.x ?? 0.0, y: selectedOptionView.center.y)
        }) { finished in
            
        }
    }
    
    @IBAction func repositoriesPressed(_ sender: Any) {
        updateSelectedView(repositoriesView)
        delegate?.didSelect(.repos)
    }
    
    @IBAction func followersPressed(_ sender: Any) {
        updateSelectedView(followersView)
        delegate?.didSelect(.followers)
    }
}
