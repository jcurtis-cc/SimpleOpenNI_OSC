import SimpleOpenNI.*;
import oscP5.*;
import netP5.*;

//Generate a SimpleOpenNI object
SimpleOpenNI kinect;

OscP5 oscP5;
NetAddress oscOut;


void setup() {
 kinect = new SimpleOpenNI(this);
 kinect.enableDepth();
 kinect.enableUser();// because of the version this change
 size(640, 480);
 fill(255, 0, 0);
 kinect.setMirror(true);
 
 /* start oscP5, listening for incoming messages at port 12000 */
 oscP5 = new OscP5(this,12000);
 
 oscOut = new NetAddress("127.0.0.1",33333);
 
}

void draw() {  
  kinect.update();
  image(kinect.depthImage(), 0, 0);
 
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
 
  if (userList.size() > 0) {
    
    int userId = userList.get(0);
    
    //If we detect one user we have to draw it
    if ( kinect.isTrackingSkeleton(userId)) {
    
      drawSkeleton(userId);
      OscMessage UID = new OscMessage("/userID/");
      UID.add(userId);
      oscP5.send(UID, oscOut);
      
     PVector headPos = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,headPos);
     OscMessage head = new OscMessage("/head_pos/");
     head.add(headPos.x);
     head.add(headPos.y);
     head.add(headPos.z);
     oscP5.send(head, oscOut); 
      
     // get the positions of the three joints of our arm
     PVector rightHand = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,rightHand);
     OscMessage rHand = new OscMessage("/righthand/");
     rHand.add(rightHand.x);
     rHand.add(rightHand.y);
     rHand.add(rightHand.z);
     oscP5.send(rHand, oscOut);
     
     PVector rightElbow = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_ELBOW,rightElbow);
     OscMessage rElbow = new OscMessage("/right_elbow/");
     rElbow.add(rightElbow.x);
     rElbow.add(rightElbow.y);
     rElbow.add(rightElbow.z);
     oscP5.send(rElbow, oscOut);
     
     PVector rightShoulder = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,rightShoulder);
     OscMessage rShoulder = new OscMessage("/right_shoulder/");
     rShoulder.add(rightShoulder.x);
     rShoulder.add(rightShoulder.y);
     rShoulder.add(rightShoulder.z);
     oscP5.send(rShoulder, oscOut);
     
     // we need right hip to orient the shoulder angle
     PVector rightHip = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HIP,rightHip);
     OscMessage rHip = new OscMessage("/right_hip/");
     rHip.add(rightHip.x);
     rHip.add(rightHip.y);
     rHip.add(rightHip.z);
     oscP5.send(rHip, oscOut);
     
     PVector rightKnee = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_KNEE,rightKnee);
     OscMessage rKnee = new OscMessage("/right_knee/");
     rKnee.add(rightKnee.x);
     rKnee.add(rightKnee.y);
     rKnee.add(rightKnee.z);
     oscP5.send(rKnee, oscOut);
     
     PVector rightFoot = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_FOOT,rightFoot);
     OscMessage rFoot = new OscMessage("/right_foot/");
     rFoot.add(rightFoot.x);
     rFoot.add(rightFoot.y);
     rFoot.add(rightFoot.z);
     oscP5.send(rFoot, oscOut);
     
     // get the positions of the three joints of our arm
     PVector leftHand = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,leftHand);
     OscMessage lHand = new OscMessage("/lefthand/");
     lHand.add(leftHand.x);
     lHand.add(leftHand.y);
     lHand.add(leftHand.z);
     oscP5.send(lHand, oscOut);
     
     PVector leftElbow = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_ELBOW,leftElbow);
     OscMessage lElbow = new OscMessage("/left_elbow/");
     lElbow.add(leftElbow.x);
     lElbow.add(leftElbow.y);
     lElbow.add(leftElbow.z);
     oscP5.send(lElbow, oscOut);
     
     PVector leftShoulder = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,leftShoulder);
     OscMessage lShoulder = new OscMessage("/left_shoulder/");
     lShoulder.add(leftShoulder.x);
     lShoulder.add(leftShoulder.y);
     lShoulder.add(leftShoulder.z);
     oscP5.send(lShoulder, oscOut);
     
     PVector leftHip = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HIP,leftHip);
     OscMessage lHip = new OscMessage("/left_hip/");
     lHip.add(leftHip.x);
     lHip.add(leftHip.y);
     lHip.add(leftHip.z);
     oscP5.send(lHip, oscOut);
     
     PVector leftKnee = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_KNEE,leftKnee);
     OscMessage lKnee = new OscMessage("/left_knee/");
     lKnee.add(leftKnee.x);
     lKnee.add(leftKnee.y);
     lKnee.add(leftKnee.z);
     oscP5.send(lKnee, oscOut);
     
     PVector leftFoot = new PVector();
     kinect.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_FOOT,leftFoot);
     OscMessage lFoot = new OscMessage("/left_foot/");
     lFoot.add(leftFoot.x);
     lFoot.add(leftFoot.y);
     lFoot.add(leftFoot.z);
     oscP5.send(lFoot, oscOut);
     
     // reduce our joint vectors to two dimensions
     PVector rightHand2D = new PVector(rightHand.x, rightHand.y); 
     PVector rightElbow2D = new PVector(rightElbow.x, rightElbow.y);
     PVector rightShoulder2D = new PVector(rightShoulder.x,rightShoulder.y);
     PVector rightHip2D = new PVector(rightHip.x, rightHip.y);
     // calculate the axes against which we want to measure our angles
     PVector torsoOrientation = PVector.sub(rightShoulder2D, rightHip2D); 
     PVector upperArmOrientation = PVector.sub(rightElbow2D, rightShoulder2D);
     
     // calculate the angles between our joints
     float shoulderAngle = angleOf(rightElbow2D, rightShoulder2D, torsoOrientation);
     float elbowAngle = angleOf(rightHand2D,rightElbow2D,upperArmOrientation);
     // show the angles on the screen for debugging
     fill(255,0,0);
     scale(3);
     textSize(4);
     text("shoulder: " + int(shoulderAngle) + "\n" + " elbow: " + int(elbowAngle), 20, 20);
    
     
       //ElbowAngle conditionals           
       if (elbowAngle >= 50) 
        {                           
           println("1");   
        } else 
        {                           //otherwise
          println("0");
        }   
                  
    }
  
  }

}

void drawSkeleton(int userId) {
 
 stroke(0);
 strokeWeight(2);
 
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
 kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_LEFT_HIP);
 
 //noStroke();
 
 fill(255,0,0);
 strokeWeight(2);
 drawJoint(userId, SimpleOpenNI.SKEL_HEAD); 
 drawJoint(userId, SimpleOpenNI.SKEL_NECK);
 drawJoint(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
 drawJoint(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
 drawJoint(userId, SimpleOpenNI.SKEL_NECK);
 drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
 drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
 drawJoint(userId, SimpleOpenNI.SKEL_TORSO);
 drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
 drawJoint(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
 drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HIP);
 drawJoint(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
 drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
 drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);
 drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
 drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
 drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
}

void drawJoint(int userId, int jointID) { 
 PVector joint = new PVector();
 
 float confidence = kinect.getJointPositionSkeleton(userId, jointID,
joint);
 if(confidence < 0.5){
   return; 
 }
 PVector convertedJoint = new PVector();
 kinect.convertRealWorldToProjective(joint, convertedJoint);
 ellipse(convertedJoint.x, convertedJoint.y, 5, 5);
}

//Generate the angle
 float angleOf(PVector one, PVector two, PVector axis){
 PVector limb = PVector.sub(two, one);
 return degrees(PVector.angleBetween(limb, axis));
}

//Calibration not required

void onNewUser(SimpleOpenNI kinect, int userID){
  println("Start skeleton tracking");
  kinect.startTrackingSkeleton(userID);
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}