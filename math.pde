


//Generate the angle
float angleOf(PVector one, PVector two, PVector axis) {
    PVector limb = PVector.sub(two, one);
    return degrees(PVector.angleBetween(limb, axis));
}
