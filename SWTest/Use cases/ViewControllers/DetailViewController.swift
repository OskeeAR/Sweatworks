//
//  DetailViewController.swift
//  SWTest
//
//  Created by Nacho on 12/01/2018.

import UIKit

class DetailViewController: UIViewController,DetailView{

    @IBOutlet weak var txtName:     UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtBirthday: UITextField!
    
    var delegate : ListViewProtocol?
    var userSelectedDate = Date()
    fileprivate let detailPresenter = DetailPresenter(detailService: DetailService())
    
    var mode =  EditionMode.add{
        didSet{
            if mode == .add{
                updateUI()
            }
        }
    }
    
    var selectedUser : CDUser? {
        didSet{
            self.mode = .edit
        }
    }
    
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserUIWithUser(selectedUser)
        detailPresenter.attachView(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var detailItem: CDUser? {
        didSet {
        }
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.save, style: .plain, target: self, action:#selector(didPressSave))
        let doneButton = UIBarButtonItem(title:  Constants.done, style: UIBarButtonItemStyle.plain, target: self, action:#selector(donePicker))
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        txtBirthday.inputView = datePickerView
        txtBirthday.inputAccessoryView = toolBar
        updateUI()
    }
    
    func updateUI(){
        switch mode {
        case .add:
            title = Constants.adding
            txtName.text = ""
            txtLastname.text = ""
            txtBirthday.text = Utils.convertDateToString(Date())
            userSelectedDate = Date()
        case .edit:
            title = Constants.edit
        }
    }
    
    // MARK: Helpers
    
    func loadUserUIWithUser(_ user : CDUser?){
        if let user = user {
            txtName.text = user.name
            txtLastname.text = user.lastname
            txtBirthday.text = Utils.convertDateToString(user.birthday!)
            userSelectedDate = user.birthday!
        }else{
            txtBirthday.text = Utils.convertDateToString(userSelectedDate)
        }        
    }
    
    
    // MARK: User Interaction    
    @objc func didPressSave() {
        guard let name = txtName.text, txtName.text != "" else {
            Utils.showErrorWithMsg(Constants.nameFieldError, viewController:self)
            return
        }
        
        guard let lastName = txtLastname.text, txtLastname.text != "" else {
            Utils.showErrorWithMsg(Constants.lastnameFieldError, viewController:self)
            return
        }
        
        if mode == .add{
            do{
                try detailPresenter.saveUser(userName: name, userLastName: lastName, userBirthday: userSelectedDate)
                    delegate?.updateUserList()
            }catch{
                Utils.showErrorWithMsg(Constants.errorUserAdd, viewController: self)
            }
        }else{
            if let user = selectedUser{
                user.name = name
                user.lastname = lastName
                user.birthday = userSelectedDate
                
                delegate?.updateUserList()
                do{
                    try detailPresenter.updateUser(user)
                }catch{
                    Utils.showErrorWithMsg(Constants.errorUserUpdate, viewController: self)
                }
            }
        }
        parent?.navigationController?.popViewController(animated: true)
    }
    
    @objc func donePicker() {
        txtBirthday.resignFirstResponder()
    }
 
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        txtBirthday.text = dateFormatter.string(from: sender.date)
        userSelectedDate = sender.date
    }
    
    deinit {
        print("DetailViewController was deinitilized!")
    }
}

