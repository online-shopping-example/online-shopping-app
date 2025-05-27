import 'package:flutter/material.dart';
import 'package:online_shopping_app/models/product_model.dart';

import '../../../components/primary_list_view_widget.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> allProducts;
  final void Function(int) onEdit;
  final ScrollController scrollController;

  const ProductListView({
    super.key,
    required this.allProducts,
    required this.onEdit,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 5,
              right: 5,
              bottom: 50,
            ),
            child: Scrollbar(
              controller: scrollController,
              // Attach the controller
              thumbVisibility: true,
              // Always show the scrollbar
              thickness: 15,
              // Width of the scrollbar
              radius: const Radius.circular(20),
              // Rounded corners for the scrollbar
              trackVisibility: true,
              // Show the track
              child: SingleChildScrollView(
                controller: scrollController, // Attach the controller
                physics: const ScrollPhysics(),
                child: PrimaryListViewWidget(
                  allElements: allProducts,
                  cardIcon: Icons.propane_outlined,
                  onElementTap: onEdit,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Count : ${allProducts.length}',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
