//
//  ViewController.swift
//  Iablonskyi Ievgenii Test Task
//
//  Created by тигренок  on 10/09/2016.
//  Copyright © 2016 Ievgenii Iablonskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variabels
    let model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://staging.salony.com/v1/salons"
        model.getDataFromUrl(url)
    }



}

