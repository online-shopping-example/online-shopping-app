import 'package:flutter/material.dart';
import 'package:online_shopping_app/admin/screens/category/add_edit_category_view.dart';
import 'package:online_shopping_app/admin/screens/category/categories_list_view.dart';

import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  // _allCategories As Stream
  late Stream<List<CategoryModel>> _allCategoriesStream;

  List<CategoryModel> _allCategories = [];

  CategoryModel? _editedCategory;
  bool _addEditedCategory = false;

  // Initialize the scrollbar controller.
  final ScrollController _scrollController = ScrollController();
  double _savedScrollOffset = 0.0; // Save the scroll offset

  @override
  void initState() {
    // TODO: implement initState
    _allCategoriesStream = CategoryController.getAllCategoriesAsStream();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*   title: const Text('All Categories'),*/
        automaticallyImplyLeading: _addEditedCategory ? false : true,
      ),
      body: _drawBody(),
      floatingActionButton: _drawFloatingActionButton(),
    );
  }

  FloatingActionButton? _drawFloatingActionButton() {
    return _addEditedCategory
        ? null
        : FloatingActionButton.extended(
            label: const Row(
              children: [
                Text(
                  'Add category',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ],
            ),
            backgroundColor: Colors.grey,
            onPressed: () {
              setState(() {
                _addEditedCategory = true;
              });
            },
          );
  }

  Widget _drawBody() {
    _scrollBarPositioning();
    return StreamBuilder<List<CategoryModel>>(
      stream: _allCategoriesStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _drawView(snapshot);
        } else if (snapshot.hasError) {
          // Handle error case
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
            ),
          );
        } else {
          // Loading indicator
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _drawView(AsyncSnapshot<List<CategoryModel>> snapshot) {
    _allCategories = snapshot.data!;
    if (_addEditedCategory) {
      return AddEditCategoryView(
        allCategories: _allCategories,
        currentCategory: _editedCategory,
        resetView: () {
          setState(() {
            _addEditedCategory = false;
            _editedCategory = null;
          });
        },
      );
    } else {
      if (_allCategories.isEmpty) {
        return const Center(
          child: Text('No Category found!'),
        );
      } else {
        return CategoriesListView(
          allCategories: _allCategories,
          onEdit: (int index) {
            setState(() {
              _addEditedCategory = true;
              _editedCategory = _allCategories[index];
            });
          },
          onElementTap: (int index) {
            /*     context.go(
              '/AddCategory${_allCategories[index].name}/${_allCategories[index].imageUrl}/${_allCategories[index].id}',
            );*/
          },
          scrollController: _scrollController,
        );
      }
    }
  }

  void _scrollBarPositioning() {
    if (_allCategories.isNotEmpty) {
      if (_addEditedCategory) {
        // Save scroll offset before leaving SubjectsListView.
        _savedScrollOffset = _scrollController.offset;
      } else {
        // Restore scroll offset when returning to SubjectsListView.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_savedScrollOffset);
        });
      }
    }
  }
}
