import Foundation
import RealmSwift


class ProductRealm: Object {
    
    @Persisted var id: Int? = nil
    @Persisted var brand: String? = nil
    @Persisted var name: String? = nil
    @Persisted var price: String? = nil
    @Persisted var priceSign: String? = nil
    @Persisted var currency: String? = nil
    @Persisted var imagePath: String? = nil
    @Persisted var productLink: String? = nil
    @Persisted var websiteLink: String? = nil
    @Persisted var productDescription: String? = nil
    @Persisted var rating: Double? = nil
    @Persisted var category: String? = nil
    @Persisted var productType: String? = nil
    @Persisted var tagList: String? = nil
    @Persisted var createdAt: String? = nil
    @Persisted var updatedAt: String? = nil
    @Persisted var url: String? = nil
    @Persisted var apiFeaturedImage : String? = nil
    @Persisted var productColors = List<String?>()

    override static func primaryKey() -> String? {
        return "id"
    }
}
