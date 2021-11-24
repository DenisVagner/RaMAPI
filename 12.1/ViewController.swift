import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let networkRequest = NetworkRequest()
    var result: AllCharacters? = nil
    let urlString3 = "https://rickandmortyapi.com/api/character"
    
    //    func doRequest(){
    //        AF.request(urlString3).responseJSON { response in
    //            DispatchQueue.main.async {
    //                guard let data = response.data else { return }
    //                do {
    //                    let res: AllCharacters = try JSONDecoder().decode(AllCharacters.self, from: data)
    //                    //return res?
    //                    self.ress = res
    //                    print(res.results.count)
    //                    print(res.results.first?.name ?? "" )
    //                    var test = self.ress?.results[0].name
    //                    print(test ?? "nress nil")
    //                } catch {
    //                    print("ERROR!!!", error)
    //                }
    //
    //            }
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromNetwork()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let index = myTableView.indexPath(for: cell) {
            if let vc = segue.destination as? CharacterInfoViewController, segue.identifier == "ShowInfo" {
                vc.idInfo = result?.results[index.row].id ?? 55
            }
        }
    }
    
    func loadFromNetwork() {
        networkRequest.request(urlString: urlString3) { [weak self] (result) in
            switch result {
                
            case .success(let allcharacters):
                self?.result = allcharacters
                self?.myTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.results.count  ?? 3 //self.ress?.results.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CharacterInfoTableViewCell
        
        cell.chatacterNameLabel.text = result?.results[indexPath.row].name
        cell.characterStatusLabel.text = result?.results[indexPath.row].status
        cell.characterLastSeenLocLabel.text = result?.results[indexPath.row].location.name
        
        if let urlString8 = self.result?.results[indexPath.row].image {
            let urlImage = URL(string: urlString8)
            let queue = DispatchQueue.global(qos: .userInteractive)
            queue.async {
                if let imageData = try? Data(contentsOf: urlImage!) {
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        cell.characterImage.image = image
                    }
                }
                
            }
        }
        
        return cell
    }
}
