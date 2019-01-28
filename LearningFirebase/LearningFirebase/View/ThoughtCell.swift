//
//  ThoughtCell.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 20/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit
import Firebase


protocol ThoughtDelegate {
  func thoughtOptionsTapped(thought: Thought)
}


class ThoughtCell: UITableViewCell {

  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var timestampLabel: UILabel!
  @IBOutlet weak var thoughtTextLabel: UILabel!
  @IBOutlet weak var starImageView: UIImageView!
  @IBOutlet weak var likesNumberLabel: UILabel!
  @IBOutlet weak var commentsImage: UIImageView!
  @IBOutlet weak var commentsNumLabel: UILabel!
  
  @IBOutlet weak var optionsMenu: UIImageView!
  private var thought: Thought!
  private var delegate: ThoughtDelegate?
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(likeTaped))
    starImageView.addGestureRecognizer(tap)
    starImageView.isUserInteractionEnabled = true
    
    }

  @objc func likeTaped() {
    //Method 1
    Firestore.firestore().collection(THOUGHTS_REF)
      .document(thought.documentId)
      .setData([NUM_LIKES : thought.numLikes + 1], merge: true)
  }
  
  func configureCell(thought: Thought, delegate: ThoughtDelegate? = nil) {
    optionsMenu.isHidden = true
    self.thought = thought
    usernameLabel.text = thought.username
    thoughtTextLabel.text = thought.thoughtTxt
    likesNumberLabel.text = String(thought.numLikes)
    commentsNumLabel.text = String(thought.numComments)
    self.delegate = delegate
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, hh:mm"
    let timestamp = formatter.string(from: thought.timestamp)
    timestampLabel.text = timestamp
    
    
    if thought.userID == Auth.auth().currentUser?.uid {
      optionsMenu.isHidden = false
      optionsMenu.isUserInteractionEnabled = true
      let tapGester = UITapGestureRecognizer(target: self, action: #selector(thoughtOptionTapped))
      optionsMenu.addGestureRecognizer(tapGester)
    }
    
    
  }
  
  @objc func thoughtOptionTapped() {
    delegate?.thoughtOptionsTapped(thought: thought)
  }
  
  
  
  
  

  
}
