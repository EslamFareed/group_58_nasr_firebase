import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_58_nasr_firebase/views/firestore_screen.dart';
import 'package:group_58_nasr_firebase/cubits/home/home_cubit.dart';
import 'package:group_58_nasr_firebase/views/login_screen.dart';
import 'firebase_options.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirestoreScreen(),
      ),
    );
  }
}
