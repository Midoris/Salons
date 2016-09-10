//
//  ViewController.swift
//  Iablonskyi Ievgenii Test Task
//
//  Created by тигренок  on 10/09/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import UIKit

class SalonsViewController: UIViewController {
    
    // MARK: - Variabels
    @IBOutlet weak var salonsTableView: UITableView! {
        didSet {
            salonsTableView.delegate = self
            salonsTableView.dataSource = self
        }
    }
    let model = Model()
    var refreshControl = UIRefreshControl()
    
    // MARK: - ViewController Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpController()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self) // remove an observer when an instance is deallocated
    }
    
    // MARK: - Methods
    private func setUpController() {
        model.getDataFromUrl(Constants.APIUrl)
        refreshControl.addTarget(self, action: #selector(SalonsViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        salonsTableView?.addSubview(refreshControl)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SalonsViewController.updateUI), name: Constants.ParsingKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SalonsViewController.handleErrorNotification), name: Constants.ErrorKey, object: nil)
    }
    
    @objc private func updateUI() {
        self.salonsTableView.reloadData()
        if refreshControl.refreshing {
            refreshControl.endRefreshing()
        }
    }
    
    @objc private func refresh() {
        model.getDataFromUrl(Constants.APIUrl)
    }
    
    @objc private func handleErrorNotification() {
        let errorString = "Something went wrong, please try again"
        showAlert(errorString, controller: self)
    }
    
    private func showAlert(message: NSString, controller: UIViewController){
        let alert = UIAlertController(title: "Error", message: message as String, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        controller.presentViewController(alert, animated: true, completion: nil)
    }

    
}

