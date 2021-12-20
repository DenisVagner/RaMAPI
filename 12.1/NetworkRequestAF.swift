//import Foundation
import Alamofire
import UIKit

class NetworkRequestAF {
    
    func requestAll(urlString: String, completion: @escaping (Result<AllCharacters, Error>) -> Void) {
        AF.request(urlString).responseJSON { response in
            
            guard let data = response.data else {
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                
                return
                
            }
            do {
                let res = try JSONDecoder().decode(AllCharacters.self, from: data)
                DispatchQueue.main.async {
                    print("network request secsess")
                    completion(.success(res))
                }
            } catch let jsonError {
                print("ERROR!!!", jsonError)
                completion(.failure(jsonError))
                
                //let alert = UIAlertController()
                //alert.present(ViewController, animated: true, completion: nil)
                
            }
        }
    }
    
    func alertPresent() {
        let ac = UIAlertController(title: "Error", message: "No inernet", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cancelAction)
       // present(ac, animated: true, completion: nil)
    }
    
    func requestOne(urlString: String, completion: @escaping (Result<CharacterInfo, Error>) -> Void) {
        AF.request(urlString).responseJSON { response in
            
            guard let data = response.data else { return }
            do {
                let res = try JSONDecoder().decode(CharacterInfo.self, from: data)
                DispatchQueue.main.async {
                    print("network request")
                    completion(.success(res))
                }
            } catch let jsonError {
                print("ERROR!!!", jsonError)
                completion(.failure(jsonError))
            }
        }
    }
}
