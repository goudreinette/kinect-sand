
// userId -> jointId -> PVector
PVector[][] lastHandPositions = new PVector[100][100]; // way too large, just for now



void drawSkeleton(int userId) {
    stroke(0);
    strokeWeight(5); 
    noStroke();
  
    fill(255, 0, 0);
    drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
    drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
}




void drawJoint(int userId, int jointID) { 
    PVector joint = new PVector();
  
    float confidence = kinect.getJointPositionSkeleton(userId, jointID, joint);
    if (confidence < 0.5) {
      return;
    }
  
    PVector convertedJoint = new PVector();
    kinect.convertRealWorldToProjective(joint, convertedJoint);
    convertedJoint.mult(2);
    
    
    
    // Weighted average!! To smooth it out... ------
    // initialize
    if (lastHandPositions[userId][jointID] == null) {
        lastHandPositions[userId][jointID] = convertedJoint.copy();
    }
    
    PVector weightedAverage = convertedJoint.lerp(lastHandPositions[userId][jointID], .7);
    
    ellipse(weightedAverage.x, weightedAverage.y, 5, 5);  
    
    lastHandPositions[userId][jointID] = weightedAverage.copy();
      
    // Add Particle !!  -------------
    // FIXME this needs to go somewhere else
    Particle p = new Particle(convertedJoint.x,convertedJoint.y, elementForUserId(userId));
    particles.add(p);
}
