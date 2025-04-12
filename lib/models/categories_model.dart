class CategoriesModel {
  final String? id;
  final String name;
  final List<String>? productIds;

  CategoriesModel({
    this.id,
    required this.name,
    required this.productIds,
  });

  CategoriesModel copy({
    String? id,
    String? name,
    List? productPath,
  }) =>
      CategoriesModel(
        id: id ?? this.id,
        name: name ?? this.name,
        productIds: productIds ?? this.productIds,
      );

  static CategoriesModel fromJson(
      Map<String, dynamic> json, String categoriesId) {
    return CategoriesModel(
      id: categoriesId,
      name: json['name'],
      productIds: json['productsIds'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
