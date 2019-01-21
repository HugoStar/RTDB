//
//  ThoughtCell.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 20/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit
import Firebase

class ThoughtCell: UITableViewCell {

  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var timestampLabel: UILabel!
  @IBOutlet weak var thoughtTextLabel: UILabel!
  @IBOutlet weak var starImageView: UIImageView!
  @IBOutlet weak var likesNumberLabel: UILabel!
  
  private var thought: Thought!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(likeTaped))
    starImageView.addGestureRecognizer(tap)
    starImageView.isUserInteractionEnabled = true
    
    }

  @objc func likeTaped() {
    //Method 1
//    Firestore.firestore().collection(THOUGHTS_REF)
//      .document(thought.documentId)
//      .setData([NUM_LIKES : thought.numLikes + 1], merge: true)
    //Method 2
    Firestore.firestore().document("thoughts/\(thought.documentId)").updateData([NUM_LIKES : thought.numLikes + 1])
    

  }
  
  func configureCell(thought: Thought) {
    self.thought = thought
    usernameLabel.text = thought.username
    thoughtTextLabel.text = thought.thoughtTxt
    likesNumberLabel.text = String(thought.numLikes)
    
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, hh:mm"
    let timestamp = formatter.string(from: thought.timestamp)
    timestampLabel.text = timestamp
    
  }

  
}
