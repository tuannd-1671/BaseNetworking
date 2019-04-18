//
//  ViewController.swift
//  RequestURL
//
//  Created by ngo.doan.tuan on 4/18/19.
//  Copyright © 2019 ethos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getNotiApi()
    }

    func getNotiApi() {
        NotiService.getNoti {  (data, response, error) in
            guard let data = data, let response = response else { return }
            print(String(data: data, encoding: .utf8)!)
            print("\n\n\n \(response)")
        }
    }
}

