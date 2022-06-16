import Foundation

struct Product: Codable {
    
    var id: Int?
    let brand: String?
    let name: String?
    let price: String?
    let priceSign: String?
    let currency: String?
    let imagePath: String?
    let productLink: String?
    let websiteLink: String?
    let productDescription: String?
    let rating: Double?
    let category: String?
    let productType: String?
    let tagList: [String]?
    let createdAt: String?
    let updatedAt: String?
    let url: String?
    let apiFeaturedImage: String?
    let productColors: [ProductColor]?
    let productColorsList: [String?]

    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case brand = "brand"
        case name = "name"
        case price = "price"
        case priceSign = "price_sign"
        case currency = "currency"
        case imagePath = "image_link"
        case productLink = "product_link"
        case websiteLink = "website_link"
        case productDescription = "description"
        case rating = "rating"
        case category = "category"
        case productType = "product_type"
        case tagList = "tag_list"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case url = "product_api_url"
        case apiFeaturedImage = "api_featured_image"
        case productColors = "product_colors"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        priceSign = try values.decodeIfPresent(String.self, forKey: .priceSign)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
        productLink = try values.decodeIfPresent(String.self, forKey: .productLink)
        websiteLink = try values.decodeIfPresent(String.self, forKey: .websiteLink)
        productDescription = try values.decodeIfPresent(String.self, forKey: .productDescription)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        productType = try values.decodeIfPresent(String.self, forKey: .productType)
        tagList = try values.decodeIfPresent([String].self, forKey: .tagList)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        apiFeaturedImage = try values.decodeIfPresent(String.self, forKey: .apiFeaturedImage)
        productColors = try values.decodeIfPresent([ProductColor].self, forKey: .productColors)
        var allColors = [String?]()
        if productColors != nil {
            for colorSet in productColors! {
                allColors.append(colorSet.hexValue)
            }
        }
        productColorsList = allColors
    }
    
    init (productRealm: ProductRealm) {
        
        self.id = productRealm.id
        self.brand = productRealm.brand
        self.name = productRealm.name
        self.price = productRealm.price
        self.priceSign = productRealm.priceSign
        self.currency = productRealm.currency
        self.imagePath = productRealm.imagePath
        self.productLink = productRealm.productLink
        self.websiteLink = productRealm.websiteLink
        self.productDescription = productRealm.productDescription
        self.rating = productRealm.rating
        self.category = productRealm.category
        self.productType = productRealm.productType
        self.tagList = nil
        self.createdAt = productRealm.createdAt
        self.updatedAt = productRealm.updatedAt
        self.url = productRealm.url
        self.apiFeaturedImage = productRealm.apiFeaturedImage
        self.productColors = nil
        self.productColorsList = Array(productRealm.productColors)
        
    }
    
}

struct ProductColor: Codable {
    
    var hexValue: String?
    let colourName: String?
    
    enum CodingKeys: String, CodingKey {
        
        case hexValue = "hex_value"
        case colourName = "colour_name"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hexValue = try values.decodeIfPresent(String.self, forKey: .hexValue)
        colourName = try values.decodeIfPresent(String.self, forKey: .colourName)
    }
}


