//
//  ViewController.swift
//  FeedrReadr-PaulJurczyk
//
//  Created by Paul Jurczyk on 12/2/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK Local Variables ---------------------------
    
    var searchQuery = ""
    var searchInitiated = Bool()
    var newEndPoint = String()
    
    
    // MARK: IBOutlets ---------------------------------------------
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: IBActions ------------------------------
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        
        searchQuery = searchTextField.text!
        let encodedText = searchQuery.addingPercentEncoding(withAllowedCharacters: urlHostAllowed)
        
        
        
        
        
        
        
        
        
        
    }
    
    
    private func fetchData(closure: @escaping (String) -> ()) {
        if searchInitiated == true {
            let endpoint = newEndPoint
            let url = URLRequest(url: URL(string: endpoint)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) { (data, response, error) in
                // TODO: add error handling
                guard let responseData = data else {
                   // self.itemTextView.text = "Error: did not receive data"
                    return
                }
                DispatchQueue.main.async {
                    closure(String(data: responseData, encoding: String.Encoding.utf8)!)
                }
            }
            task.resume()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

