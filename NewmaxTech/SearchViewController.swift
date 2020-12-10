//
//  ViewController.swift
//  NewmaxTech
//
//  Created by Nodir on 09/12/20.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //navigationController?.isNavigationBarHidden = true
        setupUI()
        
    }
    
    func setupUI() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        searchField.layer.cornerRadius = 20
        searchField.layer.masksToBounds = true
        searchField.backgroundColor = .white
        searchField.placeholder = "  Search By Username"
        goButton.layer.cornerRadius = 20
        
    }
    
    
    //MARK: - Navigation

    //In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.getUserName = searchField.text!
       }
   }


    @IBAction func goButton(_ sender: UIButton) {
        if searchField.text?.isEmpty == true {
            print("Empty TextField")
            let alertController = UIAlertController(title: "\(searchField.text ?? "Empty username")", message: "Please Enter Valid Username", preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
            
        } else {
            performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
}
