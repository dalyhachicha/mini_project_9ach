import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_project_9ach/utils/constants.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var userData = snapshot.data as Map<String, dynamic>;

            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          userData['email'] ?? 'john.doe@example.com',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          userData['phoneNumber'] ?? '+1234567890',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Acceuil'),
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                ListTile(
                  title: const Text('Panier'),
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  leading: const Icon(Icons.shopping_cart),
                  onTap: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                ),
                ListTile(
                  title: const Text('Favoris'),
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  leading: const Icon(Icons.favorite),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Se Deconnecter'),
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  leading: const Icon(Icons.logout),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    var userData = <String, dynamic>{};

    if (user != null) {
      String userId = user.uid;

      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists) {
          userData = userDoc.data() as Map<String, dynamic>;
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }

    return userData;
  }
}

// class CustomDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: primaryColor,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           const DrawerHeader(

//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Flexible(
//                   child: Text(
//                     'John Doe',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   child: Text(
//                     'john.doe@example.com',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   child: Text(
//                     '+1234567890',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             title: const Text('Acceuil'),
//             textColor: Colors.white,
//             iconColor: Colors.white,
//             leading: Icon(Icons.home),
//             onTap: () {
//               Navigator.pushNamed(context, '/home');
//             },
//           ),
//           ListTile(
//             title: const Text('Panier'),
//             textColor: Colors.white,
//             iconColor: Colors.white,
//             leading: Icon(Icons.shopping_cart),
//             onTap: () {
//               Navigator.pushNamed(context, '/checkout');
//             },
//           ),
//           ListTile(
//             title: const Text('Favoris'),
//             textColor: Colors.white,
//             iconColor: Colors.white,
//             leading: Icon(Icons.favorite),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             title: const Text('Se Deconnecter'),
//             textColor: Colors.white,
//             iconColor: Colors.white,
//             leading: Icon(Icons.logout),
//             onTap: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
