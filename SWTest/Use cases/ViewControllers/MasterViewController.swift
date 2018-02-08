//
//  MasterViewController.swift
//  SWTest
//
//  Created by Nacho on 12/01/2018.

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var detailViewController: DetailViewController?
    
    fileprivate let masterPresenter = MasterPresenter(masterService: MasterService())
    fileprivate var users = [CDUser]()
    fileprivate var selectedUser : CDUser?
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers.last as? UINavigationController)?.topViewController as? DetailViewController
            detailViewController?.delegate = self
        }
        
        setupUI()        
        masterPresenter.attachView(self)
        
        do{
            try masterPresenter.getUsers()
        }catch{
            Utils.showErrorWithMsg(Constants.errorLoadUsers, viewController: self)
        }
    }
    
    private func setupUI(){
        self.tableView.register(UINib(nibName: Constants.userCell, bundle: nil), forCellReuseIdentifier:Constants.userCell)        
        title = "Users list"
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Internal functions
    
    @objc func insertNewObject(_ sender: Any) {
        if UIDevice.current.userInterfaceIdiom == .phone {
            performSegue(withIdentifier:Constants.segueShowDetail, sender: self)
        }else{
            detailViewController?.mode = .add
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueShowDetail {
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController

            if let indexPath = tableView.indexPathForSelectedRow {
                controller.selectedUser = users[indexPath.row]
            }

            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            controller.delegate = self
            
        }
    }
}

extension MasterViewController: UserView {
    func setUsers(_ users: [CDUser]){
        self.users = users
        self.tableView.reloadData()
    }
}

extension MasterViewController  {
    
    // Mark: - TableView Datasource & Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserCell = self.tableView.dequeueReusableCell(withIdentifier: Constants.userCell) as! UserCell
        
        assert(indexPath.row < users.count, "Yikes! Trying to access out-of-bounds array")
        let user = users[indexPath.row]
        cell.configureCell(user)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = users[indexPath.row]
        
        // iPads don't allocate different ViewControllers to display details, they use only one
        // through the whole app life cycle, so we should only push a new viewController when
        // running on iPhone devices i!
        if UIDevice.current.userInterfaceIdiom == .phone {
            performSegue(withIdentifier:Constants.segueShowDetail, sender: self)
        }else{
            if let detailViewController = detailViewController {
                detailViewController.selectedUser = selectedUser
                detailViewController.loadUserUIWithUser(selectedUser)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do{
                try masterPresenter.deleteUser(users[indexPath.row])
            }catch{
                Utils.showErrorWithMsg(Constants.errorDeletion, viewController: self)
            }
        }        
    }
}
    
extension MasterViewController : ListViewProtocol {
    
    // MARK : ListViewDelegate
        
    internal func updateUserList() {
        do{
            try masterPresenter.getUsers()
        }catch{
            Utils.showErrorWithMsg(Constants.errorLoadUsers, viewController: self)
        }
    }
    
}


