import Foundation
import Alamofire

class NetworkRequestAF {
    
    func requestAF(urlString: String, completion: @escaping (Result<AllCharacters, Error>) -> Void) {
        AF.request(urlString).responseJSON { response in

            guard let data = response.data else { return }
            do {
                let res = try JSONDecoder().decode(AllCharacters.self, from: data)
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


//func doRequest (urlString: String, completion: @escaping (Result<AllCharacters, Error>) -> Void) {
//    guard let url = URL(string: urlString) else { return }
//    URLSession.shared.dataTask(with: url) { (data, response, error)  in
//        //DispatchQueue.main.async {
//        if let error = error {
//            print("Some error: \(error)")
//            completion(.failure(error))
//            return
//        }
//        guard let data = data else { return }
//        do {
//            let resultOut = try JSONDecoder().decode(AllCharacters.self, from: data)
//            DispatchQueue.main.async {
//                completion(.success(resultOut))
//            }
//
//        } catch let jsonError {
//            print("ERROR!!! cant decode: ", jsonError)
//            completion(.failure(jsonError))
//        }
//        // print(String(data: data, encoding: .utf8) ?? "no data")
//        // }
//    }.resume()
//}


