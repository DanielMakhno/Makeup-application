/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Json4Swift_Base : Codable {
	let id : Int?
	let brand : String?
	let name : String?
	let price : String?
	let price_sign : String?
	let currency : String?
	let image_link : String?
	let product_link : String?
	let website_link : String?
	let description : String?
	let rating : String?
	let category : String?
	let product_type : String?
	let tag_list : [String]?
	let created_at : String?
	let updated_at : String?
	let product_api_url : String?
	let api_featured_image : String?
	let product_colors : [Product_colors]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case brand = "brand"
		case name = "name"
		case price = "price"
		case price_sign = "price_sign"
		case currency = "currency"
		case image_link = "image_link"
		case product_link = "product_link"
		case website_link = "website_link"
		case description = "description"
		case rating = "rating"
		case category = "category"
		case product_type = "product_type"
		case tag_list = "tag_list"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case product_api_url = "product_api_url"
		case api_featured_image = "api_featured_image"
		case product_colors = "product_colors"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		brand = try values.decodeIfPresent(String.self, forKey: .brand)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		price_sign = try values.decodeIfPresent(String.self, forKey: .price_sign)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		image_link = try values.decodeIfPresent(String.self, forKey: .image_link)
		product_link = try values.decodeIfPresent(String.self, forKey: .product_link)
		website_link = try values.decodeIfPresent(String.self, forKey: .website_link)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		rating = try values.decodeIfPresent(String.self, forKey: .rating)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		product_type = try values.decodeIfPresent(String.self, forKey: .product_type)
		tag_list = try values.decodeIfPresent([String].self, forKey: .tag_list)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		product_api_url = try values.decodeIfPresent(String.self, forKey: .product_api_url)
		api_featured_image = try values.decodeIfPresent(String.self, forKey: .api_featured_image)
		product_colors = try values.decodeIfPresent([Product_colors].self, forKey: .product_colors)
	}

}