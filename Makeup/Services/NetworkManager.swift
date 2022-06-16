import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func loadProductList(url: String, completionBlock: @escaping(([Product]) ->())) {
        
        AF.request(url).responseJSON { response in
            
            guard let response = response.data else {
                return
            }
        
            do {
                let responseModel = try JSONDecoder().decode([Product].self, from: response)
                completionBlock(responseModel)
            } catch {
                debugPrint(error)
                
            }
        }
    }
}

