import UIKit

class CharacterInfoViewController: UIViewController {
    var idInfo = 0
    let networkRequest = NetworkRequest()
    var result: AllCharacters? = nil
    // let urlString = "https://icodeschool.ru/json1.php"
    //let urlString2 = "https://rickandmortyapi.com/api/character/149"
    let urlString3 = "https://rickandmortyapi.com/api/character"
    
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoNameLabel: UILabel!
    @IBOutlet weak var infoLiveStatusLabel: UILabel!
    @IBOutlet weak var infoSpeciesLabel: UILabel!
    @IBOutlet weak var infoLastLocLabel: UILabel!
    @IBOutlet weak var infoFirstSeenLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
        DispatchQueue.main.async {
            self.loadFromNetwork()
        }
        
        print("name from will appear: ", result?.results[idInfo - 1].name ?? "no name")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("id from info: ", idInfo)
        print("name from did load: ", result?.results[idInfo - 1].name ?? "no name")
        infoNameLabel.text = result?.results[idInfo - 1].name
        infoLiveStatusLabel.text = result?.results[idInfo - 1].status
        infoSpeciesLabel.text = result?.results[idInfo - 1].species
        infoLastLocLabel.text = result?.results[idInfo - 1].location.name
        
        if let urlString8 = self.result?.results[idInfo - 1].image {
            let urlImage = URL(string: urlString8)
            let imageData = try? Data(contentsOf: urlImage!)
            let image = UIImage(data: imageData!)
            infoImageView.image = image
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("name: ", result?.results[idInfo - 1].name ?? "no name")
        
    }
    
    
    func loadFromNetwork() {
        networkRequest.request(urlString: urlString3) { [weak self] (result) in
            switch result {
                
            case .success(let allcharacters):
                self?.result = allcharacters
                print("network request")
                self?.viewDidLoad()
                //self?.loadView()
                //self?.view.setNeedsLayout()
                //self?.view.layoutIfNeeded()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
