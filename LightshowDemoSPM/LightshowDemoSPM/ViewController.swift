//
//  ViewController.swift
//  LightshowDemoSPM
//
//  Created by Alexander Mokrushin on 25.01.2024.
//  Copyright © 2024 CUE Audio, LLC. All rights reserved.
//

import UIKit
import WebViewSDK

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func navigateButtonPressed(_ sender: Any) {
        let urlString = self.urlTextField.text ?? ""
        guard urlString != "" else {
            print("Empty URL is not allowed")
            return
        }
        let sdkController = WebViewController()
        if let url = URL(string: urlString) {
            do {
                try sdkController.navigateTo(url: url)
                sdkController.modalPresentationStyle = .fullScreen
                present(sdkController, animated: true)
            } catch InvalidUrlError.runtimeError(let message){
                print("Invalid URL: \(message)")
            } catch {
                print("Error occured: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func openFileButtonPressed(_ sender: Any) {
        let sdkController = WebViewController()
        sdkController.modalPresentationStyle = .fullScreen
        present(sdkController, animated: true) {
            // Navigate to local testing page
            if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
                sdkController.navigateToFile(url: url)
            }
        }
    }
}
