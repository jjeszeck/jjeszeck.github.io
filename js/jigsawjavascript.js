//---------------------------------------------------------------------------------------
// TEST FOR BROWSER

// This first conditional sets 
// a flag for IE Windows, which will 
// be used in the loadImage() function.

if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion.indexOf("Windows")!=-1) 
{
var crappyBrowser = "true";
}
else
{
var crappyBrowser = "false";
}

// TEST FOR BROWSER
//---------------------------------------------------------------------------------------
// PRELOAD ARTWORK FOR NAVIGATION BUTTONS

// This section loads all the 
// round button images into memory 
// so there is no delay when you roll over them.

var navButName = new Array("home","books","misc","logos","clients","bio","contact","web");
var navButton = new Array();

for(i=0; i<navButName.length; i++)
{
navButton[i] = new Image();
navButton[i].src = "images/button/" + navButName[i] + "0.jpg";
navButton[i+navButName.length] = new Image();
navButton[i+navButName.length].src = "images/button/" + navButName[i] + "1.jpg";
navButton[i+(2*navButName.length)] = new Image();
navButton[i+(2*navButName.length)].src = "images/button/" + navButName[i] + "2.jpg";
}

// PRELOAD ARTWORK FOR NAVIGATION BUTTONS
//---------------------------------------------------------------------------------------
// ROLLOVERS FOR NAV BUTTONS

/* setButtons() returns all the buttons except the button for the current page (named in the variable pageName, which can be found on the page itself) back to their initial state.
changeButton(bName,bNum) changes the button named in bName to either the rollover state (1) or the clicked-on state (2). 
The if(document.images[navButName[i]]) condition is only there so I can use this function for the email rollover, which is only on the contact page and so would cause an error on other pages. (this is leftover from a previous version of the website, but I left it in to cover any similar case in the future.) */


function setButtons()
{
	for(i=0; i<navButName.length; i++)
	{
		if(document.images[navButName[i]])
		{
			if(navButName[i] == pageName)
			{
document.images[navButName[i]].src = "images/button/" + navButName[i] + "2.jpg";
			}
			else
			{
document.images[navButName[i]].src = "images/button/" + navButName[i] + "0.jpg";
			}
		}
	}
}

function changeButton(bName,bNum) 
{
setButtons()
	if(bName != pageName)
document.images[bName].src = "images/button/" + bName + bNum + ".jpg";
}


// ROLLOVERS FOR NAV BUTTONS
//---------------------------------------------------------------------------------------
// LOAD SPECIFIC ILLUSTRATION

// The eval() functions are necessary to turn strings 
// back into object properties. The setIllustration() 
// function uses information from the layouts[] array, 
// set on a separate page and included via php.

function setIllustration(illoNumber)
{
illustration = document.getElementById("illo" + illoNumber);
illustration.style.left = eval("layouts[txtNum].leftIllo" + illoNumber);
illustration.style.top = eval("layouts[txtNum].topIllo" + illoNumber);
illustration.style.width = eval("layouts[txtNum].widthIllo" + illoNumber);
illustration.style.height = eval("layouts[txtNum].heightIllo" + illoNumber);
illustration.src = eval("layouts[txtNum].srcIllo" + illoNumber);
illustration.style.display = "inline-block";
return illustration;
}

// layoutsLoaded is set in header.php. 
// It is necessary because some pages 
// don't have associated layouts.
// Also, this is where we deal with
// the crappyBrowser variable from the 
// top of this page. The setTimeouts() are 
// the only way I could get the crappyBrowser
// to display the images.
function loadImage()
{
if(layoutsLoaded == "true")
{
var capTxt = layouts[txtNum].name;
	if(document.getElementById(capTxt))
	{
capsOff();
document.getElementById(capTxt).style.display = "block";
	}
	if(crappyBrowser == "true")
	{
setTimeout("setIllustration(1)", 500);
		if(layouts[txtNum].srcIllo2)
		{
setTimeout("setIllustration(2)", 1000);
			if(layouts[txtNum].srcIllo3)
			{
setTimeout("setIllustration(3)", 1500);
			}
		}
	}
	else
	{
setIllustration(1);
		if(layouts[txtNum].srcIllo2)
		{
setIllustration(2);
			if(layouts[txtNum].srcIllo3)
			{
setIllustration(3);
			}
		}
	}
}
}


// Setting the images to yellow jpgs between changes
// is necessary because the program gets ahead of 
// itself and changes the dimensions before changing 
// the illustration, causing the old illustration to
// stretch out weirdly before changing to the new one.

function clearImages()
{
	if(layouts[txtNum].srcIllo1)
	{
document.getElementById("illo1").style.display = "none";
document.getElementById("illo1").src = "./images/yellow.jpg";
	}
	if(layouts[txtNum].srcIllo2)
	{
document.getElementById("illo2").style.display = "none";
document.getElementById("illo2").src = "./images/yellow.jpg";
	}
	if(layouts[txtNum].srcIllo3)
	{
document.getElementById("illo3").style.display = "none";
document.getElementById("illo3").src = "./images/yellow.jpg";
	}
}


function capsOff()
{
	for(i=0; i<layouts.length; i++)
	{
var capTxt = layouts[i].name;
document.getElementById(capTxt).style.display = "none";
	}
}


// LOAD SPECIFIC ILLUSTRATION
//---------------------------------------------------------------------------------------
// CYCLE THROUGH TEXT AND IMAGES

// Each section begins with illustration 0 and
// can be cycled forward or backward through the 
// entire list, coming back to 0.

var txtNum = 0;

function cycleIllos(direction) 
{
clearImages();
var layoutsLength = layouts.length;
	if(direction=="forward")
	{
txtNum++
		if(txtNum>=layoutsLength) 
		{
txtNum=0;
		}
	}
	else
	{
txtNum--
			if(txtNum<0) 
			{
txtNum=layoutsLength-1;
			}
	}
window.scrollTo(0,0);
loadImage();
}

// CYCLE THROUGH TEXT AND IMAGES
//---------------------------------------------------------------------------------------
// OPEN WINDOW WITH IMAGE

// This is the enlargement you get when
// you click on an illustration. 

function displayImage(imageSrc)
{
document.getElementById("imageOverlay").style.display = "block";
document.getElementById("overlayImage").src = imageSrc;
}

function killImage()
{
document.getElementById("imageOverlay").style.display = "none";
}

