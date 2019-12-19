
enum Element {
     Water,
     Fire, 
     Sand,
     
     // to-be-implemented
     Steam,
     Smoke
};



Element elementForUserId(int userId) {
    int i = userId % 3;
    if (i == 0) {
      return Element.Sand;
    }
    
    if (i == 1) {
      return Element.Water;
    }
    
    if (i == 2) {
      return Element.Fire;
    }
    
    return Element.Sand;
}
