//
//  XTableViewCell.swift
//  XSampleApp
//
//  Created by にしいけんすけ on 2024/04/09.
//

import UIKit

class XTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(userName: String, detail: String) {
       nameLabel.text = userName
       detailLabel.text = detail
    }
}
