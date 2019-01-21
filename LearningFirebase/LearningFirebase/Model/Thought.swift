//
//  Thought.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 20/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import Foundation
import Firebase


struct Thought {
  
  private(set) var username: String
  private(set) var timestamp: Date
  private(set) var thoughtTxt: String
  private(set) var numLikes: Int
  private(set) var numComments: Int
  private(set) var documentId: String
  
  
  init(username: String, timestamp: Date, thoughtTxt: String, numLikes: Int, numComments: Int, documentId: String) {
    self.username = username
    self.timestamp = timestamp
    self.thoughtTxt = thoughtTxt
    self.numLikes = numLikes
    self.numComments = numComments
    self.documentId = documentId
  }
  
  
  static func parseData(snapshot: QuerySnapshot?) -> [Thought] {
    
    var thoughts = [Thought]()

    guard let snap = snapshot else { return thoughts }

    for document in snap.documents {
      let data = document.data()
      let userName = data[USERNAME] as? String ?? "Anonymuos"
      let timestamp = data[TIMESTAMP] as? Date ?? Date()
      let toughtText = data[THOUGHT_TEXT] as? String ?? ""
      let numLikes = data[NUM_LIKES] as? Int ?? 0
      let numComments = data[NUM_COMMENTS] as? Int ?? 0
      let documentID = document.documentID
      
      
      let newThought = Thought(username: userName, timestamp: timestamp, thoughtTxt: toughtText, numLikes: numLikes, numComments: numComments, documentId: documentID)
      
      thoughts.append(newThought)
    }
    
    return thoughts
    
  }
  
  
}
