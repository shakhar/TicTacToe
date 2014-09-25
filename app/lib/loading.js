// var cSpeed=4;
// var cTotalFrames=12;
// var cFrameWidth=65;
// var cImageSrc='assets/images/sprites.gif';

// var cImageTimeout=false;
// var cIndex=0;
// var cXpos=0;
// var cPreloaderTimeout=false;
// var SECONDS_BETWEEN_FRAMES=0;

// function startAnimation(){
//   FPS = Math.round(100/cSpeed);
//   SECONDS_BETWEEN_FRAMES = 1 / FPS;
//   cPreloaderTimeout=setTimeout('continueAnimation()', SECONDS_BETWEEN_FRAMES/1000);  
// }

// function continueAnimation(){
  
//   cXpos += cFrameWidth;
//   cIndex += 1;
   
//   if (cIndex >= cTotalFrames) {
//     cXpos =0;
//     cIndex=0;
//   }
  
//   if(document.getElementById('loaderImage'))
//     document.getElementById('loaderImage').style.backgroundPosition=(-cXpos)+'px 0';
  
//   cPreloaderTimeout=setTimeout('continueAnimation()', SECONDS_BETWEEN_FRAMES*1000);
// }

// function stopAnimation(){
//   clearTimeout(cPreloaderTimeout);
//   cPreloaderTimeout=false;
// }

// function imageLoader(s, fun)
// {
//   clearTimeout(cImageTimeout);
//   cImageTimeout=0;
//   genImage = new Image();
//   genImage.onload = function (){cImageTimeout=setTimeout(fun, 0)};
//   genImage.src=s;
// }

// new imageLoader(cImageSrc, 'startAnimation()');

// function startLoading() {
//   $("#loaderImage").show()
// }

// function stopLoading() {
//   $("#loaderImage").hide() 
// }

function startLoading() {
  $("#loaderImage").show();
  $("#loaderImage").loader("reset")
  $("#loaderImage").loader("play")
}

function stopLoading() {
  $("#loaderImage").hide()
  $("#loaderImage").loader("pause") 
}