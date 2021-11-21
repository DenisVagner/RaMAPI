import UIKit
import Alamofire


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // let urlString = "https://icodeschool.ru/json1.php"
        //let urlString2 = "https://rickandmortyapi.com/api/character/149"
        let urlString3 = "https://rickandmortyapi.com/api/character"
        
        AF.request(urlString3).responseJSON { response in
            do {
                let res = try JSONDecoder().decode(AllCharacters.self, from: response.data!)
                print(res.results.count)
                print(res.results.first?.name ?? "")
            } catch {
                print("ERROR!!!", error)
            }
        }
        
        
        //        guard let url = URL(string: urlString2) else { return }
        //        let task = URLSession.shared.dataTask(with: url) { (data, response, error)  in
        //            DispatchQueue.main.async {
        //                if let error = error {
        //                    print("Some error: \(error)")
        //                    return
        //                }
        //                guard let data = data else { return }
        //                do {
        //                    let resultOut = try JSONDecoder().decode(DataResponse1.self, from: data)
        //                    // print(resultOut.location.name)
        //                } catch {
        //                    print("ERROR!!!", error)
        //                }
        //
        //                // print(String(data: data, encoding: .utf8) ?? "no data")
        //            }
        //
        //        }
        //        task.resume()
        
    }
}

