//
//  Thought.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 20/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import Foundation


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
  
}
