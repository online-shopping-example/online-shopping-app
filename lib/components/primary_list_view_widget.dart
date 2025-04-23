import 'package:flutter/material.dart';

class PrimaryListViewWidget extends StatelessWidget {
  final List<dynamic> allElements;
  final void Function(int index) onElementTap;
  final IconData cardIcon;
  final void Function(int index)? onEdit;

  const PrimaryListViewWidget({
    super.key,
    required this.allElements,
    required this.onElementTap,
    required this.cardIcon,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: allElements.length,
        itemBuilder: (BuildContext context, index) {
          dynamic cardTitle = cardIcon == Icons.category
              ? allElements[index].name
              : allElements[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: ListTile(
                leading: Icon(cardIcon),
                title: Text(
                  cardTitle,
                ),
                trailing: onEdit != null
                    ? IconButton(
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          onEdit!(index);
                        },
                      )
                    : null,
                onTap: () {
                  onElementTap(index);
                },
              ),
            ),
          );
        });
  }
}
