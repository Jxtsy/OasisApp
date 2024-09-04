import Foundation

struct PropertyDetail: Codable {
    var detail_id: Int;
    var property_id: Int;
    var descripcion: String;
    var size: String;
    var bedrooms: Int;
    var bathrooms: Int;
    var style: String;
    var special_Feature: String;
}
