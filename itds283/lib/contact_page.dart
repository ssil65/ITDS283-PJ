import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CONTACT"),
        backgroundColor: const Color.fromARGB(255, 11, 0, 172),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'GR APP',
        textColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 11, 0, 172),
        email: 'test@test.com',
      ),
      backgroundColor: const Color.fromARGB(255, 7, 0, 104),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContactUs(
              cardColor: Colors.white,
              textColor: Colors.black,
              logo: const NetworkImage(
                  "https://mahidol.ac.th/temp/2019/06/logo-MU_Color.png"),
              email: 'test@test.com',
              companyName: 'GR APP',
              companyColor: Colors.yellow,
              dividerThickness: 3,
              taglineColor: Colors.yellow,
            ),
            const Image(
              image: NetworkImage(
                  "https://static.wikia.nocookie.net/tensei-shitara-slime-datta-ken/images/b/bf/Demon_Lord_Rimuru_Anime.png/revision/latest?cb=20220307101435"),
              height: 460,
              width: 460,
            )
          ],
        ),
      ),
    );
  }
}