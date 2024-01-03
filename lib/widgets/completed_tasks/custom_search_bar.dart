import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: const MaterialStatePropertyAll(
        Color(
          0xfff5f9fc,
        ),
      ),
      controller: searchController,
      leading: const Icon(Icons.search),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      hintText: 'Search task',
      hintStyle: const MaterialStatePropertyAll(
        TextStyle(
          color: Color(
            0xff9c9fb1,
          ),
        ),
      ),
    );
  }
}
