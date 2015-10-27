size(400,400);
var Ball = function(x, y){ 
    this.x = x;
    this.y = y;
    this.up = true;
    this.left = false;
};
var bob = new Ball(100,200);
Ball.prototype.draw = function() {
     fill(255, 0, 0);
     stroke(255, 0, 0);
     ellipse(this.x,this.y,30,30);
};
Ball.prototype.move = function() {
     if(this.up === true)
     {
       this.y-=2;
     }
     else if(this.up === false)
     {
      this.y+=2;
     }
     if(this.left === true)
     {
       this.x-=2;
     }
     else
     {
      this.x+=2;
     }
};
var Brick = function(x,y){
    this.x = x;
    this.y = y;
    this.dead = false; //set to true if hit by ball
};
Brick.prototype.draw = function() {
    if(this.dead !== true) //only draw block if it hasn't been hit
    {
     fill(0, 255, 0);
     stroke(0,255,0);
     rect(this.x,this.y,80,20);
    }
};

//Because I refer to bob in this function, the checkForHit definition needs to come after bob is declared
//We're comparing bob's x and y to see if it is in the rectangular region around the brick
Brick.prototype.checkForHit = function() {
     if(bob.x > this.x - 15 && bob.x < this.x + 95 && bob.y > this.y - 15 && bob.y < this.y +35 && this.dead === false)
         {
             this.dead = true;
             bob.up = false;//ball bounces
         }
};
var bricks = []; //empty array
for(var x = 10; x < 400; x+=100 ) //x at 10, 110, 210 & 310
{
    for(var y = 10; y <= 100; y += 30) //y at 10, 40, 70, 100
    {
       bricks.push(new Brick(x,y)); //add new Bricks to the array
    }
}

var Paddle = function(){
    this.x = 200;
    this.y = 370;
};
Paddle.prototype.draw = function() {
     fill(0, 0, 255);
     stroke(0,0,255);
     rect(this.x,this.y,80,20);
};
var player = new Paddle(20);

Ball.prototype.bounce = function() {

     if(this.y > 355 && //check for bounce off paddle
        this.x > player.x && this.x < player.x + 80)
     {
        this.up = true;
     }
     if(this.x <= 15)
     {
       this.left = false;
     }
     if(this.x >= 385)
     {
      this.left = true;
     }
     if(this.y < 15)
     {
       this.up = false;
     }
     if(this.y > 385)
     {
      this.up = true;
     }
};


var draw = function() {
     background(0, 0, 0);
     player.draw();
     for(var i = 0; i < bricks.length; i++)
     {
        bricks[i].draw();
        bricks[i].checkForHit();
     }
     bob.draw();
     bob.move();
     bob.bounce();
 
};
var keyPressed = function(){
    if(key.toString() === 'a' && player.x > 0)
    {
        player.x-=10;
    }
    if(key.toString() === 'd' && player.x < 320)
    {
        player.x+=10;
    }
};


