import Foundation
import RealmSwift

class DataSavingManager {
    
    private let realm = try? Realm()
    
    static let shared = DataSavingManager()
    
    private init() {}
    
    //MARK: Saving a product
    
    func saveProduct(product: Product) -> ProductRealm {
        
        let productRealm = ProductRealm()
        productRealm.id = product.id
        productRealm.brand = product.brand
        productRealm.name = product.name
        productRealm.price = product.price
        productRealm.priceSign = product.priceSign
        productRealm.currency = product.currency
        productRealm.imagePath = product.imagePath
        productRealm.productLink = product.productLink
        productRealm.websiteLink = product.websiteLink
        productRealm.productDescription = product.productDescription
        productRealm.rating = product.rating
        productRealm.category = product.category
        productRealm.productType = product.productType
        productRealm.createdAt = product.createdAt
        productRealm.updatedAt = product.updatedAt
        productRealm.url = product.url
        productRealm.apiFeaturedImage = product.apiFeaturedImage
        
        if product.productColorsList != nil {
            for item in product.productColorsList {
                productRealm.productColors.append(item!)
            }
        }
    
        try? realm?.write{
            realm?.add(productRealm, update: .all)
        }
        return productRealm
    }
    
    // MARK: Getting a product list
    
    func getProductsList() -> [ProductRealm] {
        var products = [ProductRealm]()
        guard let productsResults = realm?.objects(ProductRealm.self)
        else { return [] }
        for product in productsResults {
            products.append(product)
        }
        return products
    }
    
    // MARK: Remove a product from DB
    func deleteSavedProduct(savedProduct: ProductRealm){
        
        try? realm?.write{
            realm?.delete(savedProduct)
        }
    }
    
    // MARK: Checking if the product exists in DB
    func objectProductExists(id: Int) -> ProductRealm? {
         return realm?.object(ofType: ProductRealm.self, forPrimaryKey: id)
    }
}
