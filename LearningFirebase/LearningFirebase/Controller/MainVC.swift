//
//  ViewController.swift
//  LearningFirebase
//
//  Created by Мишустин Сергеевич on 05/01/2019.
//  Copyright © 2019 Mishustin Viktor. All rights reserved.
//

import UIKit
import Firebase

enum ThoughtCategory: String {
  case serious = "serious"
  case funny = "funny"
  case crazy = "crazy"
  case popular = "popular"
}

class MainVC: UIViewController {

  @IBOutlet private weak var segmentControl: UISegmentedControl!
  @IBOutlet private weak var tableView: UITableView!
  
  private var thoughts = [Thought]()
  private var thoughtsCollectionRef: CollectionReference!
  private var thoughtsListener: ListenerRegistration!
  private var selectedCategory = ThoughtCategory.funny.rawValue
  
  private var handle: AuthStateDidChangeListenerHandle?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.estimatedRowHeight = 80
    tableView.rowHeight = UITableView.automaticDimension
    
    thoughtsCollectionRef = Firestore.firestore().collection(THOUGHTS_REF)

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    handle = Auth.auth().addStateDidChangeListener({ auth, user in
      if user == nil {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC")
        self.present(loginVC, animated: true, completion: nil)
      } else {
        self.setListener()
      }
    })
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    guard let thoughtsListener = thoughtsListener else { return }
    thoughtsListener.remove()
  }

  
  func setListener() {
    
    if selectedCategory == ThoughtCategory.popular.rawValue {
      thoughtsListener = thoughtsCollectionRef
        .order(by: NUM_LIKES, descending: true)
        .addSnapshotListener { [weak self] query, error in
          if let error = error { debugPrint("error fetching docs: \(error)") }
          else {
            self?.thoughts.removeAll()
            self?.thoughts = Thought.parseData(snapshot: query)
            self?.tableView.reloadData()
          }
      }
    } else {
      thoughtsListener = thoughtsCollectionRef
        .whereField(CATEGORY, isEqualTo: selectedCategory)
        .order(by: TIMESTAMP, descending: true)
        .addSnapshotListener { [weak self] query, error in
          if let error = error { debugPrint("error fetching docs: \(error)") }
          else { 
            self?.thoughts.removeAll()
            self?.thoughts = Thought.parseData(snapshot: query)
            self?.tableView.reloadData()
          }
      }
    }
  }
  

  @IBAction func categoryChanged(_ sender: UISegmentedControl) {
    
    switch segmentControl.selectedSegmentIndex {
    case 0:
      selectedCategory = ThoughtCategory.funny.rawValue
    case 1:
      selectedCategory = ThoughtCategory.serious.rawValue
    case 2:
      selectedCategory = ThoughtCategory.crazy.rawValue
    default:
      selectedCategory = ThoughtCategory.popular.rawValue
    }
    
    thoughtsListener.remove()
    setListener()
    
  }
  
  @IBAction func logout(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
    } catch let error as NSError {
      debugPrint("Error \(error)")
    }
  }
  
  
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return thoughts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "thoughtCell", for: indexPath) as! ThoughtCell
    cell.configureCell(thought: thoughts[indexPath.row], delegate: self)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "toComments", sender: thoughts[indexPath.row])
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "toComments",
      let destination = segue.destination as? CommentsVC,
      let thought = sender as? Thought {
        destination.thought = thought
    }
    
  }
  
  
}

extension MainVC: ThoughtDelegate {
  func thoughtOptionsTapped(thought: Thought) {
    
    

  }
  
  
}

