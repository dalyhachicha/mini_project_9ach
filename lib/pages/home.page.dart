import 'package:flutter/material.dart';
import 'package:mini_project_9ach/utils/constants.dart';
import 'package:mini_project_9ach/widgets/custom_appbar.widget.dart';
import 'package:mini_project_9ach/widgets/custom_drawer.widget.dart';
import 'package:mini_project_9ach/widgets/product_list.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  String searchString = "";
  List<String> selectedBadges = [];
  List<String> badgesList = [
    "Chapeau",
    "Écharpe",
    "Gants",
    "Ceinture",
    "Cravate",
    "Montre",
    "Sac à main",
    "Portefeuille",
    "Chaussettes",
    "Collants",
    "Maillot de bain",
    "Pyjama",
    "Chemise de nuit",
    "Peignoir",
    "Parapluie",
    "Bonnet",
    "Cravate papillon",
    "Bretelles",
    "Casquette",
    "Manteau",
    "Imperméable",
    "Pantalon",
    "Short",
    "Jupe",
    "Robe",
    "Blouse",
    "Veste",
    "Pull",
    "Cardigan",
    "Blouson en cuir"
  ];

  void updateSearchString(String newSearchString) {
    setState(() {
      searchString = newSearchString;
    });
  }

  void toggleBadgeSelection(String badge) {
    setState(() {
      if (selectedBadges.contains(badge)) {
        selectedBadges.remove(badge);
      } else {
        selectedBadges.add(badge);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: const CustomAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          onEditingComplete: () {
                            setState(() {
                              updateSearchString(searchController.text);
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Recherche',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            updateSearchString(searchController.text);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, bottom: 16),
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: badgesList.length,
                itemBuilder: (context, index) {
                  final badge = badgesList[index];
                  final isSelected = selectedBadges.contains(badge);

                  return GestureDetector(
                    onTap: () => toggleBadgeSelection(badge),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        label: Text(
                          badge,
                          style: TextStyle(
                            color: isSelected ? Colors.white : primaryColor,
                          ),
                        ),
                        backgroundColor: isSelected
                            ? primaryColor // Selected background color
                            : primaryColor.withAlpha(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                const Text(
                  'New Arrival',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 8,
                    color: primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Image.asset("assets/images/bar.png", scale: .7)
              ],
            ),
            ProductList(
              key: UniqueKey(),
              searchString: searchString,
              categoriesFilter: selectedBadges,
            ),
          ],
        ),
      ),
    );
  }
}
