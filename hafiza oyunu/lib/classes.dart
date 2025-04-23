


class Kart {
  String onYuzuFotografYolu;
  bool acikMi;
  bool eslestiMi;

  Kart({required this.onYuzuFotografYolu, this.acikMi = false, this.eslestiMi = false});
}

bool kartlariEslesiyorMu(Kart kart1, Kart kart2) {
  return kart1.onYuzuFotografYolu == kart2.onYuzuFotografYolu;
}


