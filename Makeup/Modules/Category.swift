import Foundation

struct Category {
    var name: String
    var imagePath: String?
    var urlPath: String
    
    init(name: String, imagePath: String?, urlPath: String) {
        self.name = name
        self.imagePath = imagePath
        self.urlPath = urlPath
    }
}
