class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;

  Product({
    required totalSize,
    required typeId,
    required offset,
    required products,
  }) {
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  final int id;
  final String? name;
  final String? description;
  final int? price;
  final int? stars;
  final String? img;
  final String? location;
  final String? createdAt;
  final String? updatedAt;
  final int? typeId;

  ProductModel({
    required this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.img,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.typeId,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String?,
        description = json['description'] as String?,
        price = json['price'] as int?,
        stars = json['stars'] as int?,
        img = json['img'] as String?,
        location = json['location'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        typeId = json['type_id'] as int?;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "stars": stars,
      "img": img,
      "location": location,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "type_id": typeId,
    };
  }
}
