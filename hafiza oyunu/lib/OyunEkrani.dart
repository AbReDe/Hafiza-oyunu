import 'package:flutter/material.dart';
import 'classes.dart';
import 'dart:async';

class OyunEkrani extends StatefulWidget {
  const OyunEkrani({super.key});

  @override
  State<OyunEkrani> createState() => _OyunEkraniState();
}

class _OyunEkraniState extends State<OyunEkrani> {
  List<Kart> _kartlar = [];
  int _saniye = 0;
  Timer? _timer;
  List<int> _acikKartIndeksleri = []; // acık olan kartları tut
  bool _oyunDevamEdiyor = true; //oyun devam edıyomu burda kontrol et

  final Color turuncuRenk = const Color(0xFFFF9800);
  final Color acikSariRenk = const Color(0xFFFFECB3);

  @override
  void initState() {
    super.initState();
    _kartlariOlusturVeKaristir();
    _baslatZamanlayici();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _kartlariOlusturVeKaristir() {
    List<String> fotografYollari = [
      'assets/images/fotograf1.jpg',
      'assets/images/fotograf1.jpg',
      'assets/images/fotograf2.jpg',
      'assets/images/fotograf2.jpg',
      'assets/images/fotograf3.jpg',
      'assets/images/fotograf3.jpg',
      'assets/images/fotograf4.jpg',
      'assets/images/fotograf4.jpg',
      'assets/images/fotograf5.jpg',
      'assets/images/fotograf5.jpg',
      'assets/images/fotograf6.jpg',
      'assets/images/fotograf6.jpg',
      'assets/images/fotograf7.jpg',
      'assets/images/fotograf7.jpg',
      'assets/images/fotograf8.jpg',
      'assets/images/fotograf8.jpg',

    ];


    for (var yol in fotografYollari) {
      _kartlar.add(Kart(onYuzuFotografYolu: yol));
    }

    _kartlar.shuffle();
  }

  void _baslatZamanlayici() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_oyunDevamEdiyor) {
        setState(() {
          _saniye++;
        });
      }
    });
  }

  String _formatZaman(int saniye) {
    int dakika = saniye ~/ 60;
    int kalanSaniye = saniye % 60;
    return '${dakika.toString().padLeft(2, '0')}:${kalanSaniye.toString().padLeft(2, '0')}';
  }

  void _kartTiklandi(int index) {
    if (!_oyunDevamEdiyor || _kartlar[index].eslestiMi || _acikKartIndeksleri.length == 2 || _acikKartIndeksleri.contains(index)) {
      return; // kartalr dogruysa secim yapma
    }

    setState(() {
      _kartlar[index].acikMi = true;
      _acikKartIndeksleri.add(index);

      if (_acikKartIndeksleri.length == 2) {
        // İki kartı kontrol et
        if (kartlariEslesiyorMu(_kartlar[_acikKartIndeksleri[0]], _kartlar[_acikKartIndeksleri[1]])) {
          // Eşleşme başarılı
          _kartlar[_acikKartIndeksleri[0]].eslestiMi = true;
          _kartlar[_acikKartIndeksleri[1]].eslestiMi = true;
          _acikKartIndeksleri.clear(); // Eşleşen kartları sıfırla
          _oyunBittiMiKontrolEt();
        } else {
          // eşleşme olmazsa kartları tekrar cevir
          Future.delayed(const Duration(milliseconds: 1000), () {
            setState(() {
              _kartlar[_acikKartIndeksleri[0]].acikMi = false;
              _kartlar[_acikKartIndeksleri[1]].acikMi = false;
              _acikKartIndeksleri.clear(); // Açık kartları sıfırla
            });
          });
        }
      }
    });
  }

  void _oyunBittiMiKontrolEt() {
    if (_kartlar.every((kart) => kart.eslestiMi)) {
      setState(() {
        _oyunDevamEdiyor = false;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Tebrikler!'),
              content: Text('Oyunu ${_formatZaman(_saniye)} sürede tamamladınız.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Tekrar Oyna'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _kartlar = []; // kartları sil
                      _acikKartIndeksleri.clear();
                      _saniye = 0;
                      _oyunDevamEdiyor = true;
                      _kartlariOlusturVeKaristir();
                      _baslatZamanlayici();
                    });
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oyun Ekranı'),
        backgroundColor: turuncuRenk,
      ),
      backgroundColor: acikSariRenk,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _kartlar.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _kartTiklandi(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _kartlar[index].acikMi ? Colors.white : turuncuRenk,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: _kartlar[index].acikMi || _kartlar[index].eslestiMi
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            _kartlar[index].onYuzuFotografYolu,
                            fit: BoxFit.cover,
                          ),
                        )
                            : const Text(
                          '?',
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Time: ${_formatZaman(_saniye)}',
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}