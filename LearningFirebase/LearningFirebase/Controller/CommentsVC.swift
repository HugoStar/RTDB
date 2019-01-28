//
//  CommentsVC.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 26/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit
import Firebase

class CommentsVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var addCommentText: UITextField!
  @IBOutlet weak var keyboardView: UIView!
  
  var thought: Thought!
  var comments: [Comment] = []
  var thoughtRef: DocumentReference!
  var userName: String!
  var commentListener: ListenerRegistration!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableView.delegate = self
      tableView.dataSource = self
      tableView.estimatedRowHeight = 80
      tableView.rowHeight = UITableView.automaticDimension
      
      
      thoughtRef = Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId)
      if let name = Auth.auth().currentUser?.displayName {
        userName = name
      }

    }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    commentListener = Firestore.firestore()
      .collection(THOUGHTS_REF).document(self.thought.documentId)
      .collection(COMMENTS_REF)
      .order(by: TIMESTAMP, descending: false)
      .addSnapshotListener({ (snapshot, error) in
      
        guard let snapshot = snapshot else { debugPrint("Error fetching comments \(error!)"); return }
        self.comments.removeAll()
        self.comments = Comment.parseData(snapshot: snapshot)
        self.tableView.reloadData()
    })

  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    commentListener.remove()
  }
  
  
  
  
  
  @IBAction func sendComment(_ sender: UIButton) {
    
    guard let commentTxt = addCommentText.text else { return }
    
    Firestore.firestore().runTransaction({ transaction, errorPointer in
      
      let thoughtDocument: DocumentSnapshot
      
      do {
        try thoughtDocument = transaction.getDocument(Firestore.firestore().collection(THOUGHTS_REF).document(self.thought.documentId))
      } catch let error as NSError {
        debugPrint("Fetch error \(error.localizedDescription)")
        return nil
      }
      guard let oldNumComments = thoughtDocument.data()![NUM_COMMENTS] as? Int else { return nil }
      transaction.updateData([NUM_COMMENTS : oldNumComments + 1], forDocument: self.thoughtRef)
      
      
      let newCommentRef = Firestore.firestore().collection(THOUGHTS_REF).document(self.thought.documentId).collection(COMMENTS_REF).document()
      transaction.setData([
        COMMENT_TXT : commentTxt,
        TIMESTAMP : FieldValue.serverTimestamp(),
        USERNAME : self.userName,
        USER_ID : Auth.auth().currentUser?.uid ?? ""
        ], forDocument: newCommentRef)

      return nil
    }) { object, error in
      if let error = error {
        debugPrint("error: \(error)")
      } else {
        self.addCommentText.text = ""
      }
    }
    
  }
  
}

extension CommentsVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell {
      let comment = comments[indexPath.row]
      cell.configureCell(comment, delegate: self)
      return cell
    }
    return UITableViewCell()
  }
  
  
}

extension CommentsVC: CommentDelegate {
  func commentOptionsTapped(comment: Comment) {
    print(comment.username)
  }
  
  
}
