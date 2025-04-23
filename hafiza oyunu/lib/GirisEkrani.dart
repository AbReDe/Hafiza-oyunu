


import 'package:flutter/material.dart';

import 'OyunEkrani.dart';

class GirisEkrani extends StatelessWidget {
  const GirisEkrani({super.key});


  final Color turuncuRenk = const Color(0xFFFF9800);
  final Color acikSariRenk = const Color(0xFFFFECB3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: acikSariRenk,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hafıza Oyunu',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: turuncuRenk,
                shadows: const <Shadow>[
                  Shadow(
                    offset: const Offset(.0, 11.0),
                    blurRadius: 50.0,

                    color: Colors.black38,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OyunEkrani()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: turuncuRenk,
                padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 15.0,
              ),
              child: const Text(
                'OYNA',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
