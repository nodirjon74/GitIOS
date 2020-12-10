//
//  ResultViewController.swift
//  NewmaxTech
//
//  Created by Nodir on 09/12/20.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userInfo: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var getUserName = ""
    var repoManager = RepoManager()
    var repoData = [ArrayOfData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        repoManager.delegate = self
        repoManager.getMethod(username: getUserName)
        let nib = UINib(nibName: "RepoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "repoTableViewCell")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(repoData.count)
        return repoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoTableViewCell", for: indexPath) as! RepoTableViewCell
        let repo = repoData[indexPath.row]
        cell.repoName.text = repo.name
        cell.repoSubTitle.text = repo.description
        cell.watchersCount.text = String(repo.watchers_count)
        cell.starsCount.text = String(repo.stargazers_count)
        cell.forksCount.text = String(repo.forks_count)
        
        return cell
    }
    
    
}


extension ResultViewController: RepoManagerDelegate {
    func didUpdateWeather(_ weatherManager: RepoManager, weather: [ArrayOfData]) {
        DispatchQueue.main.async { [self] in
            if weather.isEmpty == false {
                repoData = weather
                let getData = repoData[0].owner
                username.text = getData.login
                userInfo.text = getData.url
                avatarImage.setCustomImage(getData.avatar_url)
                tableView.reloadData()
            } else {
                let alertController = UIAlertController(title: "\(getUserName)", message: "Please Enter Valid Username", preferredStyle: .actionSheet)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                self.present(alertController, animated: true, completion: nil)
            }
           
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    
}
extension UIImageView {

    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "default.png")
            return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "default.png")
            }
        }
    }
}


