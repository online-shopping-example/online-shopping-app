class CategoryModel {
  final String? id;
  final String name;
  final String imageUrl;
  final List<String>? productIds;

  CategoryModel({
    this.id,
    required this.name,
    this.productIds,
    required this.imageUrl,
  });

  CategoryModel copy({
    String? id,
    String? name,
    List? productId,
    String? imageUrl,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        productIds: productIds ?? this.productIds,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  static CategoryModel fromJson(
      Map<String, dynamic> json, String categoriesId) {
    return CategoryModel(
      id: categoriesId,
      name: json['name'],
      productIds: json['productsIds'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
      };
}
