package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Gijs
	 */
	public class EditorState extends FlxState
	{
		[Embed(source = "images/HalfBackground.png")] private var Grid1Class:Class;
		[Embed(source = "images/HalfBackground2.png")] private var Grid2Class:Class;
		[Embed(source = "images/Player.png")] private var PlayerImageClass:Class;
		[Embed(source = "images/EditMenu.png")] private var EditMenuImageClass:Class;
		[Embed(source = "images/buttonPlayer.png")] private var ButtonPlayerImageClass:Class;
		[Embed(source = "images/buttonExit.png")] private var ButtonExitImageClass:Class;
		[Embed(source = "images/buttonRed.png")] private var ButtonRoodImageClass:Class;
		[Embed(source = "images/buttonGreen.png")] private var ButtonGroenImageClass:Class;
		[Embed(source = "images/buttonBlue.png")] private var ButtonBlauwImageClass:Class;
		[Embed(source = "images/buttonYellow.png")] private var ButtonGeelImageClass:Class;
		[Embed(source = "images/buttonLaserRed.png")] private var ButtonLaserRedImageClass:Class;
		[Embed(source = "images/buttonLaserGreen.png")] private var ButtonLaserGreenImageClass:Class;
		[Embed(source = "images/buttonLaserBlue.png")] private var ButtonLaserBlueImageClass:Class;
		[Embed(source = "images/buttonLaserYellow.png")] private var ButtonLaserYellowImageClass:Class;
		[Embed(source = "images/Red.png")] private var RoodImageClass:Class;
		[Embed(source = "images/Green.png")] private var GroenImageClass:Class;
		[Embed(source = "images/Blue.png")] private var BlauwImageClass:Class;
		[Embed(source = "images/Yellow.png")] private var GeelImageClass:Class;
		[Embed(source = "images/Exit.png")] private var ExitImageClass:Class;
		[Embed(source = "images/RedHorizontal.png")] private var RedLaserHorizontalClass:Class;
		[Embed(source = "images/RedVertical.png")]private var RedLaserVerticalClass:Class;
		[Embed(source = "images/GreenHorizontal.png")] private var GreenLaserHorizontalClass:Class;
		[Embed(source = "images/GreenVertical.png")]private var GreenLaserVerticalClass:Class;
		[Embed(source = "images/BlueHorizontal.png")] private var BlueLaserHorizontalClass:Class;
		[Embed(source = "images/BlueVertical.png")]private var BlueLaserVerticalClass:Class;
		[Embed(source = "images/YellowHorizontal.png")] private var YellowLaserHorizontalClass:Class;
		[Embed(source = "images/YellowVertical.png")]private var YellowLaserVerticalClass:Class;
		
		private var background:FlxSprite; //The background sprite.
		private var itemScale:FlxPoint; //Indicates the scale of the placable objects.
		private var editMenuBackground:FlxSprite; //The background sprite of the edit menu.
		private var buttonPlayer:FlxSprite; //The Player button.
		private var buttonExit:FlxSprite; //The Exit button.
		private var buttonRood:FlxSprite; //The red color button.
		private var buttonGroen:FlxSprite; //The green color button.
		private var buttonBlauw:FlxSprite; //The blue color button.
		private var buttonGeel:FlxSprite; //The yellow color button.
		private var buttonLaserRed:FlxSprite; //The red laser button.
		private var buttonLaserGreen:FlxSprite; //The green laser button.
		private var buttonLaserBlue:FlxSprite; //The blue laser button.
		private var buttonLaserYellow:FlxSprite; //The yellow laser button.
		private var mouseTracker:FlxSprite; //A 1px sprite that follows the x and y of the mouse to check collisions.
		private var selectedButton:Number = 0; //The index number of the selected item in the edit menu.
		private var playerused:Boolean = false; //A boolean used to check if the player has already been placed.
		private var exitused:Boolean = false; //A boolean used to check if the exit has already been placed.
		private var range:Number; //The distance the player moves with every keypress.
		
		//Grid variables
		private var xcounter:Number;
		private var ycounter:Number;
		private var rows:Number = 0;
		private var fixedX:Number;
		private var fixedY:Number;
		
		//Items in game
		private var player:Player;
		private var exit:FlxSprite;
		private var rood:FlxSprite;
		private var groen:FlxSprite;
		private var blauw:FlxSprite;
		private var geel:FlxSprite;
		
		//Laser variables
		private var Laserarray:Array;
		private var laserused:Boolean = false;
		private var laserpointcount:int = 0;
		private var lasercoorx:int = 0;
		private var lasercoory:int = 0;
		private var lasercoorx2:int = 0;
		private var lasercoory2:int = 0;
		private var laserlock:Boolean = false;
		private var lasergridcount:int = 0;
		private var distanceX:Number;
		private var distanceY:Number;
		//private var laservert:Boolean;
		//private var laserhor:Boolean;
		private var Laser:FlxSprite;
		private var GreenLaserVertical:FlxSprite;
		private var GreenLaserHorizontal:FlxSprite;
		
		function EditorState(gridnr:Number):void {
			switch (gridnr) {
				case 0:
					trace("No grid number found."); break;
				case 1:
					{
						itemScale = new FlxPoint(1, 1);
						range = 40;
						background = new FlxSprite(0, 0, Grid1Class); break;
					}
				case 2:
					{
						itemScale = new FlxPoint(0.5, 0.5);
						range = 20;
						background = new FlxSprite(0, 0, Grid2Class); break;
					}
				default:
					trace("No grid number found."); break;
			}
		}
		
		override public function create():void
		{
			trace("lol");
			FlxG.flash(0xFF4b4b4b, 1);
			
			//ADD BACKGROUND
			add(background);
			
			//ADD EDITMENU
			editMenuBackground = new FlxSprite(0, -36, EditMenuImageClass);
			add(editMenuBackground);
			buttonPlayer = new FlxSprite(0, -36, ButtonPlayerImageClass);
			add(buttonPlayer);
			buttonExit = new FlxSprite(40, -36, ButtonExitImageClass);
			add(buttonExit);
			buttonRood = new FlxSprite(80, -36, ButtonRoodImageClass);
			add(buttonRood);
			buttonGroen = new FlxSprite(120, -36, ButtonGroenImageClass);
			add(buttonGroen);
			buttonBlauw = new FlxSprite(160, -36, ButtonBlauwImageClass);
			add(buttonBlauw);
			buttonGeel = new FlxSprite(200, -36, ButtonGeelImageClass);
			add(buttonGeel);
			buttonLaserRed = new FlxSprite(240, -36, ButtonLaserRedImageClass);
			add(buttonLaserRed);
			buttonLaserGreen = new FlxSprite(280, -36, ButtonLaserGreenImageClass);
			add(buttonLaserGreen);
			buttonLaserBlue = new FlxSprite(320, -36, ButtonLaserBlueImageClass);
			add(buttonLaserBlue);
			buttonLaserYellow = new FlxSprite(360, -36, ButtonLaserYellowImageClass);
			add(buttonLaserYellow);
			
			//MOUSE RELATED
			mouseTracker = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
			mouseTracker.makeGraphic(1, 1, 0x00ffffff);
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			super.update();
			
			mouseTracker.x = FlxG.mouse.x;
			mouseTracker.y = FlxG.mouse.y;
			
			if (FlxG.keys.justReleased("ESCAPE")) {
				fadeToMenu();
			}
			
			if (FlxG.mouse.y < 10) {
				editMenuBackground.y = 0;
				buttonPlayer.y = 0;
				buttonExit.y = 0;
				buttonRood.y = 0;
				buttonGroen.y = 0;
				buttonBlauw.y = 0;
				buttonGeel.y = 0;
				buttonLaserRed.y = 0;
				buttonLaserGreen.y = 0;
				buttonLaserBlue.y = 0;
				buttonLaserYellow.y = 0;
			}
			if (FlxG.mouse.y > 40) {
				editMenuBackground.y = -36;
				buttonPlayer.y = -36;
				buttonExit.y = -36;
				buttonRood.y = -36;
				buttonGroen.y = -36;
				buttonBlauw.y = -36;
				buttonGeel.y = -36;
				buttonLaserRed.y = -36;
				buttonLaserGreen.y = -36;
				buttonLaserBlue.y = -36;
				buttonLaserYellow.y = -36;
			}
			
			if (FlxG.mouse.justReleased()) {
				if (selectedButton != 0) {
					createObject(selectedButton);
				}
				if (selectedButton == 0) {
					if (FlxG.overlap(mouseTracker, buttonPlayer)) {
						if (playerused == false) {
							selectedButton = 1;
							playerused = true;
							buttonPlayer.alpha = 0.5;
						} else if (playerused == true) {
							playerused = false;
							buttonPlayer.alpha = 1;
							remove(player);
						}
					} else if (FlxG.overlap(mouseTracker, buttonExit)) {
						if (exitused == false) {
							selectedButton = 2;
							exitused = true;
							buttonExit.alpha = 0.5;
						} else if (exitused == true) {
							exitused = false;
							buttonExit.alpha = 1;
							remove(exit);
						}
					} else if (FlxG.overlap(mouseTracker, buttonRood)) {
						selectedButton = 3;
						buttonRood.alpha = 0.5;
					} else if (FlxG.overlap(mouseTracker, buttonGroen)) {
						selectedButton = 4;
						buttonGroen.alpha = 0.5;
					} else if (FlxG.overlap(mouseTracker, buttonBlauw)) {
						selectedButton = 5;
						buttonBlauw.alpha = 0.5;
					} else if (FlxG.overlap(mouseTracker, buttonGeel)) {
						selectedButton = 6;
						buttonGeel.alpha = 0.5;
					} else if (FlxG.overlap(mouseTracker, buttonLaserRed)) {
						if (laserused == false) {
							selectedButton = 7;
							//laserused = true;
							buttonLaserRed.alpha = 0.5;
						}
					} else if (FlxG.overlap(mouseTracker, buttonLaserGreen)) {
						if (laserused == false) {
							selectedButton = 8;
							//laserused = true;
							buttonLaserGreen.alpha = 0.5;
						}
					} else if (FlxG.overlap(mouseTracker, buttonLaserBlue)) {
						if (laserused == false) {
							selectedButton = 9;
							//laserused = true;
							buttonLaserBlue.alpha = 0.5;
						}
					} else if (FlxG.overlap(mouseTracker, buttonLaserYellow)) {
						if (laserused == false) {
							selectedButton = 10;
							//laserused = true;
							buttonLaserYellow.alpha = 0.5;
						}
					} else {
						trace("nothing");
					}
				}
			}
		}
		
		public function createObject(item:Number):void {
			xcounter = FlxG.mouse.x - range/2;
			for (xcounter; xcounter > 0; xcounter = xcounter - range) 
			{
				//trace ("xcounter = " + xcounter);
				if (xcounter < range+1) {
					//trace ("xcounter");
					if (xcounter < range/2) {
						fixedX = rows * range;
						//trace ("x = 0 kant");
					} else {
						fixedX = rows * range + range;
						//trace ("x = " + range + " kant");
					}
				} else {
					rows++;
					//trace ("loop #" + rows);
				}
			}
			rows = 0;
			
			ycounter = FlxG.mouse.y - range/2;
			for (ycounter; ycounter > 0; ycounter = ycounter - range) 
			{
				//trace ("ycounter = " + ycounter);
				if (ycounter < range+1) {
					//trace ("ycounter");
					if (ycounter < range/2) {
						fixedY = rows * range;
						//trace ("y = 0 kant");
					} else {
						fixedY = rows * range + range;
						//trace ("y = " + range + " kant");
					}
				} else {
					rows++;
					//trace ("loop #" + rows);
				}
			}
			rows = 0;
			
			switch (item) {
				case 0:
					trace("No number given.");
					break;
				case 1:
					player = new Player(fixedX, fixedY, range);
					player.scale = itemScale;
					add(player);
					selectedButton = 0;
					break;
				case 2:
					exit = new FlxSprite(fixedX - 5, fixedY - 5, ExitImageClass);
					exit.scale = itemScale;
					add(exit);
					selectedButton = 0;
					break;
				case 3:
					rood = new FlxSprite(fixedX, fixedY, RoodImageClass);
					rood.scale = itemScale;
					add(rood);
					selectedButton = 0;
					buttonRood.alpha = 1;
					break;
				case 4:
					groen = new FlxSprite(fixedX, fixedY, GroenImageClass);
					groen.scale = itemScale;
					add(groen);
					selectedButton = 0;
					buttonGroen.alpha = 1;
					break;
				case 5:
					blauw = new FlxSprite(fixedX, fixedY, BlauwImageClass);
					blauw.scale = itemScale;
					add(blauw);
					selectedButton = 0;
					buttonBlauw.alpha = 1;
					break;
				case 6:
					geel = new FlxSprite(fixedX, fixedY, GeelImageClass);
					geel.scale = itemScale;
					add(geel);
					selectedButton = 0;
					buttonGeel.alpha = 1;
					break;
				case 7:
					Laser = new FlxSprite(fixedX, fixedY, RoodImageClass);
					if (laserpointcount == 0) {
						lasercoorx = Laser.x;
						lasercoory = Laser.y;
						Laser.scale = itemScale;
						add(Laser);
					}
					if (laserpointcount == 1) {
						lasercoorx2 = Laser.x;
						lasercoory2 = Laser.y;
					}
					if (laserpointcount < 2) {
						laserpointcount++;
					}
					if (laserpointcount == 2) {
						if (lasercoorx < lasercoorx2) {
							distanceX = lasercoorx2 - lasercoorx;
						}
						if (lasercoorx > lasercoorx2) {
							distanceX = lasercoorx - lasercoorx2;
						}
						if (lasercoory < lasercoory2) {
							distanceY = lasercoory2 - lasercoory;
						}
						if (lasercoory > lasercoory2) {
							distanceY = lasercoory - lasercoory2;
						}
						if (distanceX < distanceY) {
							lasercoorx2 = lasercoorx;
							trace("distanceX: " + distanceX + " | distanceY: " + distanceY);
						}
						if (distanceX >= distanceY) {
							lasercoory2 = lasercoory;
							trace("distanceX: " + distanceX + " | distanceY: " + distanceY);
						}
						if (lasercoory == lasercoory2 && laserlock == false) {
							laserlock = true;
							if (lasercoorx < lasercoorx2) {
								for (lasergridcount = 0; lasergridcount < (lasercoorx2 - lasercoorx) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx +(20 + lasergridcount * range ), lasercoory, RedLaserHorizontalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							if (lasercoorx > lasercoorx2) {
								for (lasergridcount = 0; lasergridcount < (lasercoorx - lasercoorx2) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx -(20 + lasergridcount * range ), lasercoory, RedLaserHorizontalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							lasergridcount = 0;
						}
						if (lasercoorx == lasercoorx2 && laserlock == false) {
							laserlock = true;
							if (lasercoory < lasercoory2) {
								for (lasergridcount = 0; lasergridcount < (lasercoory2 - lasercoory) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx, lasercoory +(20 + lasergridcount * range ), RedLaserVerticalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							if (lasercoory > lasercoory2) {
								for (lasergridcount = 0; lasergridcount < (lasercoory - lasercoory2) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx, lasercoory -(20 + lasergridcount * range ), RedLaserVerticalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							lasergridcount = 0;
						}
						Laser = new FlxSprite(lasercoorx2, lasercoory2, RoodImageClass);
						Laser.scale = itemScale;
						add(Laser);
						
						selectedButton = 0;
						laserpointcount = 0;
						buttonLaserRed.alpha = 1;
						lasercoorx = 0;
						lasercoory = 0;
						lasercoorx2 = 0;
						lasercoory2 = 0;
						distanceX = 0;
						distanceY = 0;
					}
					laserlock = false; break;
				case 8:
					Laser = new FlxSprite(fixedX, fixedY, GroenImageClass);
					if (laserpointcount == 0) {
						lasercoorx = Laser.x;
						lasercoory = Laser.y;
						Laser.scale = itemScale;
						add(Laser);
					}
					if (laserpointcount == 1) {
						lasercoorx2 = Laser.x;
						lasercoory2 = Laser.y;
					}
					if (laserpointcount < 2) {
						laserpointcount++;
					}
					if (laserpointcount == 2) {
						if (lasercoorx < lasercoorx2) {
							distanceX = lasercoorx2 - lasercoorx;
						}
						if (lasercoorx > lasercoorx2) {
							distanceX = lasercoorx - lasercoorx2;
						}
						if (lasercoory < lasercoory2) {
							distanceY = lasercoory2 - lasercoory;
						}
						if (lasercoory > lasercoory2) {
							distanceY = lasercoory - lasercoory2;
						}
						if (distanceX < distanceY) {
							lasercoorx2 = lasercoorx;
							trace("distanceX: " + distanceX + " | distanceY: " + distanceY);
						}
						if (distanceX >= distanceY) {
							lasercoory2 = lasercoory;
							trace("distanceX: " + distanceX + " | distanceY: " + distanceY);
						}
						if (lasercoory == lasercoory2 && laserlock == false) {
							laserlock = true;
							if (lasercoorx < lasercoorx2) {
								for (lasergridcount = 0; lasergridcount < (lasercoorx2 - lasercoorx) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx +(20 + lasergridcount * range ), lasercoory, GreenLaserHorizontalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							if (lasercoorx > lasercoorx2) {
								for (lasergridcount = 0; lasergridcount < (lasercoorx - lasercoorx2) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx -(20 + lasergridcount * range ), lasercoory, GreenLaserHorizontalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							lasergridcount = 0;
						}
						if (lasercoorx == lasercoorx2 && laserlock == false) {
							laserlock = true;
							if (lasercoory < lasercoory2) {
								for (lasergridcount = 0; lasergridcount < (lasercoory2 - lasercoory) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx, lasercoory +(20 + lasergridcount * range ), GreenLaserVerticalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							if (lasercoory > lasercoory2) {
								for (lasergridcount = 0; lasergridcount < (lasercoory - lasercoory2) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx, lasercoory -(20 + lasergridcount * range ), GreenLaserVerticalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							lasergridcount = 0;
						}
						Laser = new FlxSprite(lasercoorx2, lasercoory2, GroenImageClass);
						Laser.scale = itemScale;
						add(Laser);
						
						selectedButton = 0;
						laserpointcount = 0;
						buttonLaserGreen.alpha = 1;
						lasercoorx = 0;
						lasercoory = 0;
						lasercoorx2 = 0;
						lasercoory2 = 0;
						distanceX = 0;
						distanceY = 0;
					}
					laserlock = false; break;
				case 9:
					Laser = new FlxSprite(fixedX, fixedY, BlauwImageClass);
					if (laserpointcount == 0) {
						lasercoorx = Laser.x;
						lasercoory = Laser.y;
						Laser.scale = itemScale;
						add(Laser);
					}
					if (laserpointcount == 1) {
						lasercoorx2 = Laser.x;
						lasercoory2 = Laser.y;
					}
					if (laserpointcount < 2) {
						laserpointcount++;
					}
					if (laserpointcount == 2) {
						if (lasercoorx < lasercoorx2) {
							distanceX = lasercoorx2 - lasercoorx;
						}
						if (lasercoorx > lasercoorx2) {
							distanceX = lasercoorx - lasercoorx2;
						}
						if (lasercoory < lasercoory2) {
							distanceY = lasercoory2 - lasercoory;
						}
						if (lasercoory > lasercoory2) {
							distanceY = lasercoory - lasercoory2;
						}
						if (distanceX < distanceY) {
							lasercoorx2 = lasercoorx;
							trace("distanceX: " + distanceX + " | distanceY: " + distanceY);
						}
						if (distanceX >= distanceY) {
							lasercoory2 = lasercoory;
							trace("distanceX: " + distanceX + " | distanceY: " + distanceY);
						}
						if (lasercoory == lasercoory2 && laserlock == false) {
							laserlock = true;
							if (lasercoorx < lasercoorx2) {
								for (lasergridcount = 0; lasergridcount < (lasercoorx2 - lasercoorx) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx +(20 + lasergridcount * range ), lasercoory, BlueLaserHorizontalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							if (lasercoorx > lasercoorx2) {
								for (lasergridcount = 0; lasergridcount < (lasercoorx - lasercoorx2) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx -(20 + lasergridcount * range ), lasercoory, BlueLaserHorizontalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							lasergridcount = 0;
						}
						if (lasercoorx == lasercoorx2 && laserlock == false) {
							laserlock = true;
							if (lasercoory < lasercoory2) {
								for (lasergridcount = 0; lasergridcount < (lasercoory2 - lasercoory) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx, lasercoory +(20 + lasergridcount * range ), BlueLaserVerticalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							if (lasercoory > lasercoory2) {
								for (lasergridcount = 0; lasergridcount < (lasercoory - lasercoory2) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx, lasercoory -(20 + lasergridcount * range ), BlueLaserVerticalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							lasergridcount = 0;
						}
						Laser = new FlxSprite(lasercoorx2, lasercoory2, BlauwImageClass);
						Laser.scale = itemScale;
						add(Laser);
						
						selectedButton = 0;
						laserpointcount = 0;
						buttonLaserBlue.alpha = 1;
						lasercoorx = 0;
						lasercoory = 0;
						lasercoorx2 = 0;
						lasercoory2 = 0;
						distanceX = 0;
						distanceY = 0;
					}
					laserlock = false; break;
				case 10:
					Laser = new FlxSprite(fixedX, fixedY, GeelImageClass);
					if (laserpointcount == 0) {
						lasercoorx = Laser.x;
						lasercoory = Laser.y;
						Laser.scale = itemScale;
						add(Laser);
					}
					if (laserpointcount == 1) {
						lasercoorx2 = Laser.x;
						lasercoory2 = Laser.y;
					}
					if (laserpointcount < 2) {
						laserpointcount++;
					}
					if (laserpointcount == 2) {
						if (lasercoorx < lasercoorx2) {
							distanceX = lasercoorx2 - lasercoorx;
						}
						if (lasercoorx > lasercoorx2) {
							distanceX = lasercoorx - lasercoorx2;
						}
						if (lasercoory < lasercoory2) {
							distanceY = lasercoory2 - lasercoory;
						}
						if (lasercoory > lasercoory2) {
							distanceY = lasercoory - lasercoory2;
						}
						if (distanceX < distanceY) {
							lasercoorx2 = lasercoorx;
							trace("distanceX: " + distanceX + " | distanceY: " + distanceY);
						}
						if (distanceX >= distanceY) {
							lasercoory2 = lasercoory;
							trace("distanceX: " + distanceX + " | distanceY: " + distanceY);
						}
						if (lasercoory == lasercoory2 && laserlock == false) {
							laserlock = true;
							if (lasercoorx < lasercoorx2) {
								for (lasergridcount = 0; lasergridcount < (lasercoorx2 - lasercoorx) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx +(20 + lasergridcount * range ), lasercoory, YellowLaserHorizontalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							if (lasercoorx > lasercoorx2) {
								for (lasergridcount = 0; lasergridcount < (lasercoorx - lasercoorx2) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx -(20 + lasergridcount * range ), lasercoory, YellowLaserHorizontalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							lasergridcount = 0;
						}
						if (lasercoorx == lasercoorx2 && laserlock == false) {
							laserlock = true;
							if (lasercoory < lasercoory2) {
								for (lasergridcount = 0; lasergridcount < (lasercoory2 - lasercoory) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx, lasercoory +(20 + lasergridcount * range ), YellowLaserVerticalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							if (lasercoory > lasercoory2) {
								for (lasergridcount = 0; lasergridcount < (lasercoory - lasercoory2) / range; lasergridcount++) {
									Laser = new FlxSprite(lasercoorx, lasercoory -(20 + lasergridcount * range ), YellowLaserVerticalClass);
									Laser.scale = itemScale;
									add(Laser);
								}
							}
							lasergridcount = 0;
						}
						Laser = new FlxSprite(lasercoorx2, lasercoory2, GeelImageClass);
						Laser.scale = itemScale;
						add(Laser);
						
						selectedButton = 0;
						laserpointcount = 0;
						buttonLaserYellow.alpha = 1;
						lasercoorx = 0;
						lasercoory = 0;
						lasercoorx2 = 0;
						lasercoory2 = 0;
						distanceX = 0;
						distanceY = 0;
					}
					laserlock = false; break;
				default:
					trace("There is no object with the current index number.");
			}
		}
		
		public function fadeToMenu():void
		{
			FlxG.fade(0xFF4b4b4b, 1, returnToMenu);
		}
		
		public function returnToMenu():void
		{
			FlxG.switchState(new MenuState());
		}
	}
}