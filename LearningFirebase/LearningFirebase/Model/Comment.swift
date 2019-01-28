//
//  Comment.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 27/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import Foundation
import Firebase

struct Comment {
  
  private(set) var username: String
  private(set) var timestamp: Date
  private(set) var commentTxt: String
  private(set) var documentId: String
  private(set) var userId: String
  
  
  
  init(username: String, timestamp: Date, commentTxt: String, documentId: String, userId: String) {
    self.username = username
    self.timestamp = timestamp
    self.commentTxt = commentTxt
    self.documentId = documentId
    self.userId = userId
  }
  
  
  static func parseData(snapshot: QuerySnapshot?) -> [Comment] {
    
    var comments = [Comment]()
    
    guard let snap = snapshot else { return comments }
    
    for document in snap.documents {
      let data = document.data()
      let userName = data[USERNAME] as? String ?? "Anonymuos"
      let timestamp = data[TIMESTAMP] as? Date ?? Date()
      let commentTxt = data[COMMENT_TXT] as? String ?? ""
      let documentId = document.documentID
      let userId = data[USER_ID] as? String ?? ""
      
      
      let newComment = Comment(username: userName, timestamp: timestamp, commentTxt: commentTxt, documentId: documentId, userId: userId)
      comments.append(newComment)
    }
    return comments
  }
  
  
}
