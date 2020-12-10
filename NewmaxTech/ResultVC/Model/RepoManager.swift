//
//  UserManager.swift
//  NewmaxTech
//
//  Created by Nodir on 09/12/20.
//

import Foundation


protocol RepoManagerDelegate {
    func didUpdateWeather(_ weatherManager: RepoManager, weather: [ArrayOfData])
    func didFailWithError(error: Error)
}


struct RepoManager {
    //"https://api.github.com/search/users?q=\(username)"
    
    var delegate: RepoManagerDelegate?
    
    func getMethod(username: String) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            print("Error: cannot create URL")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let safeData = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                self.delegate?.didUpdateWeather(self, weather: parse(data: safeData))
                
            }
        }.resume()
    }


    func parse(data: Data) -> [ArrayOfData] {
        let decoder = JSONDecoder()

        do {
            let jsonDecoded = try decoder.decode([ArrayOfData].self, from: data)
            return jsonDecoded
        } catch {
            print("error: \(error)")
        }
        print("Error")
        return []
    }
}
