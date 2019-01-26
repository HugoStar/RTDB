//
//  CommentsVC.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 26/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController {
  
  
  @IBOutlet weak var tableView: UITableView!
  
  
  @IBOutlet weak var addCommentText: UITextField!
  
  @IBOutlet weak var keyboardView: UIView!
  
  var thought: Thought!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
  @IBAction func sendComment(_ sender: UIButton) {
  }
  
}
