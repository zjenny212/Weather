

import Foundation
struct Json4Swift_Base : Codable {
	let cnt : Float?
	let list : [List]?

	enum CodingKeys: String, CodingKey {

		case cnt = "cnt"
		case list = "list"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cnt = try values.decodeIfPresent(Float.self, forKey: .cnt)
		list = try values.decodeIfPresent([List].self, forKey: .list)
	}

}
