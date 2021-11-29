import UIKit
import Alamofire

// анимированно убрать выделение нажатой ячейки



class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var result: AllCharacters? = nil
    let urlString = "https://rickandmortyapi.com/api/character"
    let networkRequestAF = NetworkRequestAF()
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromNetworkAF()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let index = myTableView.indexPath(for: cell) {
            if let vc = segue.destination as? CharacterInfoViewController, segue.identifier == "ShowInfo" {
                vc.idInfo = (result?.results[index.row].id ?? 0)
            }
        }
    }
    
    func loadFromNetworkAF() {
        networkRequestAF.requestAll(urlString: urlString) { [weak self] result in
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


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.results.count  ?? 3 //self.ress?.results.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CharacterInfoTableViewCell
        
        cell.chatacterNameLabel.text = result?.results[indexPath.row].name
        cell.characterStatusLabel.text = result?.results[indexPath.row].status
        cell.characterLastSeenLocLabel.text = result?.results[indexPath.row].location.name
        
        if let urlString8 = self.result?.results[indexPath.row].image {
            if let image = self.imageCache.object(forKey: urlString8 as AnyObject) as? UIImage {
                cell.characterImage.image = image
                print("Image \(indexPath.row + 1) loaded from cache")
            } else {
                let urlImage = URL(string: urlString8)
                let queue = DispatchQueue.global(qos: .userInteractive)
                queue.async {
                    if let imageData = try? Data(contentsOf: urlImage!) {
                        DispatchQueue.main.async {
                            
                            let image = UIImage(data: imageData)
                            cell.characterImage.image = image
                            self.imageCache.setObject(image!, forKey: urlString8 as AnyObject)
                            print("Image \(indexPath.row + 1) downloaded")
                            
                        }
                    }
                    
                }
            }
            

        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
