import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_docs_clone/repository/AuthRepository.dart";
import "package:google_docs_clone/utilities/colors.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(
              Icons.add,
              color: kBlackColor,
            ),
          ),
          IconButton(
            onPressed: () => null,
            icon: Icon(
              Icons.logout,
              color: kRedColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(ref.watch(userProvider)!.email),
      ),
    );
  }
}
