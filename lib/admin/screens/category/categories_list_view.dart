import 'package:flutter/material.dart';
import 'package:online_shopping_app/components/primary_list_view_widget.dart';
import 'package:online_shopping_app/models/category_model.dart';

class CategoriesListView extends StatelessWidget {
  final List<CategoryModel> allCategories;
  final void Function(int) onEdit;
  final void Function(int) onElementTap;
  final ScrollController? scrollController;

  const CategoriesListView({
    super.key,
    required this.allCategories,
    required this.onEdit,
    required this.onElementTap,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(
              20,
            ),
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              // Always show the scrollbar
              thickness: 15,
              radius: const Radius.circular(20),
              trackVisibility: true,
              child: SingleChildScrollView(
                controller: scrollController,
                /*       physics: const ScrollPhysics(),*/
                child: PrimaryListViewWidget(
                  allElements: allCategories,
                  cardIcon: Icons.category,
                  onEdit: onEdit,
                  onElementTap: onElementTap,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'count of Categories : ${allCategories.length}',
            ),
          ),
        ),
      ],
    );
  }
}
