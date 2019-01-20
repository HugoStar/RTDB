//
//  ThoughtCell.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 20/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {

  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var timestampLabel: UILabel!
  @IBOutlet weak var thoughtTextLabel: UILabel!
  @IBOutlet weak var starImageView: UIImageView!
  @IBOutlet weak var likesNumberLabel: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
  func configureCell(thought: Thought) {
    
    usernameLabel.text = thought.username
    thoughtTextLabel.text = thought.thoughtTxt
    likesNumberLabel.text = String(thought.numLikes)
    
  }

  
}
