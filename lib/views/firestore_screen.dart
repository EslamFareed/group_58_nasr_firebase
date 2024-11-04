import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_58_nasr_firebase/cubits/home/home_cubit.dart';

class FirestoreScreen extends StatelessWidget {
  const FirestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context).getProducts();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is LoadingProductsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FailProductsState) {
            return const Center(child: Text("Error, please try again"));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(HomeCubit.get(context).products[index]["name"]),
                  subtitle: Text(HomeCubit.get(context)
                      .products[index]["price"]
                      .toString()),
                ),
              );
            },
            itemCount: HomeCubit.get(context).products.length,
          );
        },
      ),
    );
  }
}

//! Add 
//! Get all
//! get one item
//! edit
//! delete
 // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       ElevatedButton(
        //         onPressed: () {
        //           FirebaseFirestore.instance.collection("products").add({
        //             "name": "Iphone",
        //             "price": 4000,
        //           });
        //         },
        //         child: const Text("Add"),
        //       ),
        //       ElevatedButton(
        //         onPressed: () async {
        //           var data = await FirebaseFirestore.instance
        //               .collection("products")
        //               .get();
        //           for (var element in data.docs) {
        //             print(element.id);
        //             print(element.data());
        //             print("----------------------------------------");
        //           }
        //         },
        //         child: const Text("Get all"),
        //       ),
        //       ElevatedButton(
        //         onPressed: () async {
        //           var data = await FirebaseFirestore.instance
        //               .collection("products")
        //               .doc("CNKxp2LL9WKKcQlOiErY")
        //               .get();
        //           print(data.id);
        //           print(data.data());
        //         },
        //         child: const Text("Get One Item"),
        //       ),
        //       ElevatedButton(
        //         onPressed: () async {
        //           //! Update
        //           // await FirebaseFirestore.instance
        //           //     .collection("products")
        //           //     .doc("CNKxp2LL9WKKcQlOiErY")
        //           //     .update({"name": "Samsung"});
        //           //! Set
        //           // await FirebaseFirestore.instance
        //           //     .collection("products")
        //           //     .doc("CNKxp2LL9WKKcQlOiErY")
        //           //     .set({
        //           //   "name": "Samsung",
        //           //   "price": 5000,
        //           // });
        //         },
        //         child: const Text("Edit"),
        //       ),
        //       ElevatedButton(
        //         onPressed: () async {
        //           await FirebaseFirestore.instance
        //               .collection("products")
        //               .doc("CNKxp2LL9WKKcQlOiErY")
        //               .delete();
        //         },
        //         child: const Text("Delete"),
        //       ),
        //     ],
        //   ),
        // ),
       