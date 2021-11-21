//
//  ViewController.swift
//  12.1
//
//  Created by Денис Вагнер on 16.11.2021.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://icodeschool.ru/json1.php"
        let urlString2 = "https://rickandmortyapi.com/api/character/149"
        guard let url = URL(string: urlString2) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error)  in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error: \(error)")
                    return
                }
                guard let data = data else { return }
                do {
                    let resultOut = try JSONDecoder().decode(DataResponse1.self, from: data)
                    // print(resultOut.location.name)
                } catch {
                    print("ERROR!!!", error)
                }
                
                // print(String(data: data, encoding: .utf8) ?? "no data")
            }
            
        }
        task.resume()
        AF.request("https://rickandmortyapi.com/api/character/149").responseJSON { response in
            do {
                let res = try JSONDecoder().decode(DataResponse1.self, from: response.data!)
                print(res.status)
            } catch {
                print("ERROR!!!", error)
            }
        }
    }
}

