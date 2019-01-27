//
//  CommentCell.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 26/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var timestemp: UILabel!
  @IBOutlet weak var commentText: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()

    }
  
  func configureCell(_ comment: Comment) {
    userName.text = comment.username
    commentText.text = comment.commentTxt
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, hh:mm"
    let timestamp = formatter.string(from: comment.timestamp)
    timestemp.text = timestamp
  }

}
