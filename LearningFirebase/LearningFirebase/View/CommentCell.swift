//
//  CommentCell.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 26/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit
import Firebase

protocol CommentDelegate {
  func commentOptionsTapped(comment: Comment)
}

class CommentCell: UITableViewCell {

  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var timestemp: UILabel!
  @IBOutlet weak var commentText: UILabel!
  @IBOutlet weak var optionsMenu: UIImageView!
  
  private var delegate: CommentDelegate?
  private var comment: Comment!
  
  override func awakeFromNib() {
        super.awakeFromNib()

    }
  
  func configureCell(_ comment: Comment, delegate: CommentDelegate? = nil) {
    self.comment = comment
    userName.text = comment.username
    commentText.text = comment.commentTxt
    optionsMenu.isHidden = true
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, hh:mm"
    let timestamp = formatter.string(from: comment.timestamp)
    timestemp.text = timestamp
    self.delegate = delegate
    
    if comment.userId == Auth.auth().currentUser?.uid {
      optionsMenu.isHidden = false
      optionsMenu.isUserInteractionEnabled = true
      let tap = UITapGestureRecognizer(target: self, action: #selector(optionsMenuTapped))
      optionsMenu.addGestureRecognizer(tap)
      
    }
  }
  
  @objc func optionsMenuTapped() {
    delegate?.commentOptionsTapped(comment: comment)
  }

}
