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

    // MARK: - ViewController Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://staging.salony.com/v1/salons"
        model.getDataFromUrl(url)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SalonsViewController.updateUI), name: Constants.ParsingKey, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Methods
    @objc private func updateUI() {
        self.salonsTableView.reloadData()
    }



}

