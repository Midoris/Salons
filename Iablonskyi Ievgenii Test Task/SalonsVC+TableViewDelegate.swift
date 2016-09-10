//
//  SalonsVC+TableViewDelegate.swift
//  Iablonskyi Ievgenii Test Task
//
//  Created by тигренок  on 10/09/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension SalonsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Table view delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.salons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.SalonCellID, forIndexPath: indexPath) as! SalonTableViewCell
        let salon = model.salons[indexPath.row]
        cell.nameLabel.text = salon.name
        cell.websiteTextView.text = salon.website
        let imageUrl = salon.originalProfileImageUrl
        let placeHoldeImage = UIImage(named: "placeholder")
        cell.disheImage.kf_setImageWithURL(NSURL(string: imageUrl)!, placeholderImage: placeHoldeImage, optionsInfo: [.Transition(ImageTransition.Fade(0.6))])
        
        return cell
    }
    
    
}
