//
//  PackageTableViewCell.swift
//  packages
//
//  Created by LOANER on 8/19/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit

class PackageTableViewCell: UITableViewCell {

    @IBOutlet weak var metaLabel: UILabel!
    @IBOutlet weak var trackingLabel: UILabel!
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var contactImage: UIImageView! {
        didSet {
            contactImage.layer.cornerRadius = contactImage.frame.width / 2
        }
    }
    
    var packageInformation: PackageInformation? {
        didSet {
            metaLabel.text = packageInformation?.meta
            trackingLabel.text = packageInformation?.tracking
            receiverNameLabel.text = packageInformation?.recipient
        }
    }

}
