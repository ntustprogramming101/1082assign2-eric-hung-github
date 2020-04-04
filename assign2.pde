final int canvas_width=640,canvas_height=480;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;

final int BUTTON_TOP = 210;
final int BUTTON_BOTTOM = 280;
final int BUTTON_LEFT = 115;
final int BUTTON_RIGHT = 450;

int chunkSize=80;

// sun setting
final int sunInnerSize=120,sunOutterSize=10;

// grass setiing
final int grassHeight=15;

// life setting
int lifePoint;
final float lifeSpace=20,lifeSize=50;

// cabbage setting
float cabbagePosX,cabbagePosY;

// solider setting
int soliderSpeed=2,soldierPosX,soldierPosY;

// groundhog setting
float groundhogPosX,groundhogPosY;
boolean groundhogMove;
int 	groundhogMoveX,groundhogMoveY;
int groundhogFrame=15,groundhogFrameCount;

PImage backg_img;
PImage gameover_img;
PImage restartHovered_img;
PImage restartNormal_img;
PImage startHovered_img;
PImage startNormal_img;
PImage title_img;


PImage cabbage_img;
PImage groundhogDown_img;
PImage groundhogIdle_img;
PImage groundhogLeft_img;
PImage groundhogRight_img;
PImage life_img ;
PImage robot_img ;
PImage soil_img ;
PImage solider_img ;

void setup() {
	size(640, 480, P2D);
	
	// image loading
	backg_img =loadImage("img\\bg.jpg");
	cabbage_img=loadImage("img\\cabbage.png");
	gameover_img=loadImage("img\\gameover.jpg");

	groundhogDown_img= loadImage("img\\groundhogDown.png");
	groundhogIdle_img=loadImage("img\\groundhogIdle.png");
	groundhogLeft_img=loadImage("img\\groundhogLeft.png");
	groundhogRight_img=loadImage("img\\groundhogRight.png");

	life_img =loadImage("img\\life.png");
	restartHovered_img=loadImage("img\\restartHovered.png");
	restartNormal_img=loadImage("img\\restartNormal.png");

	soil_img =loadImage("img\\soil.png");
	solider_img =loadImage("img\\soldier.png");

	startHovered_img=loadImage("img\\startHovered.png");
	startNormal_img=loadImage("img\\startNormal.png");
	title_img=loadImage("img\\title.jpg");
	

	// intializng life
	lifePoint=2;

	// intializng cabbage
	cabbagePosX=((int)random(0,8))*chunkSize;
	cabbagePosY=((int)random(2,6))*chunkSize;

	// intializng solider
	soldierPosX=0;
  	soldierPosY=((int)random(2,6))*chunkSize;

	// intializng ground
	groundhogMove=false;
	groundhogMoveX=0;
	groundhogMoveY=0;
	groundhogFrameCount=0;
	groundhogPosX=4*chunkSize;
	groundhogPosY=chunkSize;
}

void draw() {
	switch (gameState) {
		case GAME_RUN :
			// move item is latter draw

			//set backGround
			background(backg_img);
			
			//set Soil
			image(soil_img,0,chunkSize*2);
			
			//set Sun
			fill(255,255,0);
			circle(canvas_width-50,50,sunInnerSize+sunOutterSize);
			fill(253,184,19);
			circle(canvas_width-50,50,sunInnerSize);

			//set Grass
			fill(124,204,25);
			rect(0, 2*chunkSize-grassHeight, canvas_width, grassHeight);

			//set Life----------------------------------------------
			for (int i = 0; i < lifePoint; i++) {
				image(life_img,10+i*(lifeSpace+lifeSize),10);
			}

			//set Bagge---------------------------------------------
			image(cabbage_img,cabbagePosX,cabbagePosY);

			//set Soilder-------------------------------------------
			soldierPosX+=soliderSpeed;
			if(soldierPosX>=canvas_width){
			soldierPosY=((int)random(2,6))*chunkSize;
				soldierPosX=-chunkSize;
			}
			image(solider_img, soldierPosX, soldierPosY);

			
			//set Groundhog-----------------------------------------

			// if moving
			if(groundhogMove){
				if(groundhogMoveX==1){
					groundhogPosX+=chunkSize/groundhogFrame;
					image(groundhogRight_img,groundhogPosX,groundhogPosY);
				}else if(groundhogMoveX==-1){
					groundhogPosX-=chunkSize/groundhogFrame;
					image(groundhogLeft_img,groundhogPosX,groundhogPosY);
				}else if(groundhogMoveY==1){
					groundhogPosY-=chunkSize/groundhogFrame;
					image(groundhogIdle_img,groundhogPosX,groundhogPosY);
				}else if(groundhogMoveY==-1){
					groundhogPosY+=chunkSize/groundhogFrame;
					image(groundhogDown_img,groundhogPosX,groundhogPosY);
				}

				if(groundhogFrameCount>15){
					groundhogMoveX=0;
					groundhogMoveY=0;
					groundhogFrameCount=0;
					groundhogMove=false;
				}
				groundhogFrameCount++;

			//  if idle
			}else{
				if(keyPressed){
					if(keyCode==UP&&groundhogPosY>2*chunkSize){
						groundhogMove=true;
						groundhogMoveY=1;
					}
					if(keyCode==DOWN&&groundhogPosY<5*chunkSize){
						groundhogMove=true;
						groundhogMoveY=-1;
					}
					if(keyCode==RIGHT&&groundhogPosX<chunkSize*7){
						groundhogMove=true;
						groundhogMoveX=1;
					}
					if(keyCode==LEFT&&groundhogPosX>0*chunkSize){
						groundhogMove=true;
						groundhogMoveX=-1;
					}
				}
				image(groundhogIdle_img,groundhogPosX,groundhogPosY);
			}

			//  judge----------------------------------------------

			// if eat a cabbage
			if((groundhogPosX<cabbagePosX+chunkSize&&groundhogPosX+chunkSize>cabbagePosX)&&(groundhogPosY<cabbagePosY+chunkSize&&groundhogPosY+chunkSize>cabbagePosY)){
				if(lifePoint<5){
					lifePoint++;
				}

				cabbagePosX=((int)random(0,8))*chunkSize;
				cabbagePosY=((int)random(2,6))*chunkSize;
			}
			// if crash with solider
			if((groundhogPosX<soldierPosX+chunkSize&&groundhogPosX+chunkSize>soldierPosX)&&(groundhogPosY<soldierPosY+chunkSize&&groundhogPosY+chunkSize>soldierPosY)){
				lifePoint-=1;

				groundhogMove=false;
				groundhogMoveX=0;
				groundhogMoveY=0;
				groundhogFrameCount=0;
				groundhogPosX=4*chunkSize;
				groundhogPosY=chunkSize;
			}
			//  if game over
			if(lifePoint==0){
				gameState=GAME_OVER;
			}

		break;	
		case GAME_START :
			//set background
			background(title_img);
			if(mouseX>248&&mouseX<248+144&&mouseY>360&&mouseY<360+60){
				image(startHovered_img,248,360);
				if(mousePressed){
					gameState=GAME_RUN;
				}
			}else{
				image(startNormal_img,248,360);
			}
		break;	
		case GAME_OVER :
			background(gameover_img);
			if(mouseX>248&&mouseX<248+144&&mouseY>360&&mouseY<360+60){
				image(restartHovered_img,248,360);
				if(mousePressed){
					gameState=GAME_RUN;

					// intializng life
					lifePoint=2;

					// intializng solider
					soldierPosX=0;
					soldierPosY=((int)random(2,6))*chunkSize;

					// intializng ground
					groundhogMove=false;
					groundhogMoveX=0;
					groundhogMoveY=0;
					groundhogFrameCount=0;
					groundhogPosX=4*chunkSize;
					groundhogPosY=chunkSize;
				}
			}else{
				image(restartNormal_img,248,360);
			}
		break;	
		case GAME_WIN :
			
		break;	
	}




	
}

	/*
	// laser setting
	float laser_height=10,laserL_max=40,laser_range=2*chunkSize,laser_speed=2;
	float laser_length,laser_pos;
	//intialize laser
	laser_length=10;
	laser_pos=0;
	//intialize Robot's position by randon
	robotPosX=ceil(random(5)+2);
	robotPosY=ceil(random(4)+2);
	//set Robot
	image(robot_img,robotPosX*chunkSize,robotPosY*chunkSize);
	*/

	//Robot's shoot
	/*
	fill(255,0,0);
	ellipse(robotPosX*chunkSize-laser_pos+25,robotPosY*chunkSize+37,laser_length,laser_height);
	laser_pos+=2;
	laser_length=laser_pos/(2*chunkSize+25)*40;
	if(laser_pos>2*chunkSize+25){
		laser_pos=0;
		laser_length=10;
	*/