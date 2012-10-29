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
		[Embed(source = "images/Red.png")] private var RedImageClass:Class;
		[Embed(source = "images/Exit.png")] private var ExitImageClass:Class;
		
		private var background:FlxSprite; //The background sprite.
		private var itemScale:FlxPoint; //Indicates the scale of the placable objects.
		private var editMenuBackground:FlxSprite; //The background sprite of the edit menu.
		private var buttonPlayer:FlxSprite; //The Player button.
		private var buttonExit:FlxSprite; //The Exit button.
		private var mouseTracker:FlxSprite; //A 1px sprite that follows the x and y of the mouse to check collisions.
		private var selectedButton:Number = 0; //The index number of the selected item in the edit menu.
		private var selectedItem:Number = 0; //The index number of the selected item in the field.
		private var playerused:Boolean = false; //A boolean used to check if the player has already been placed.
		private var exitused:Boolean = false; //A boolean used to check if the exit has already been placed.
		private var range:Number;
		
		private var xcounter:Number;
		private var ycounter:Number;
		private var rows:Number = 0;
		private var fixedX:Number;
		private var fixedY:Number;
		
		private var player:Player;
		private var exit:FlxSprite;
		
		function EditorState(gridnr:Number):void {
			switch (gridnr) {
				case 0:
					trace("No grid number found"); break;
				case 1:
					{
						//itemScale = 1;
						itemScale = new FlxPoint(1, 1);
						range = 40;
						background = new FlxSprite(0, 0, Grid1Class); break;
					}
				case 2:
					{
						//itemScale = 0.5;
						itemScale = new FlxPoint(0.5, 0.5);
						range = 20;
						background = new FlxSprite(0, 0, Grid2Class); break;
					}
				default:
					trace("No grid number found"); break;
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
			}
			if (FlxG.mouse.y > 40) {
				editMenuBackground.y = -36;
				buttonPlayer.y = -36;
				buttonExit.y = -36;
			}
			
			if (FlxG.mouse.justReleased()) {
				if (selectedButton != 0) {
					createObject(selectedButton);
				}
				if (selectedItem != 0) {
					trace(selectedItem + " <-");
					moveObject(selectedItem);
				}
				if (selectedButton == 0 && selectedItem == 0) {
					if (FlxG.overlap(mouseTracker, buttonPlayer)) {
						if (playerused == false) {
							selectedButton = 1;
							playerused = true;
							buttonPlayer.alpha = 0.5;
						}
					} else if (FlxG.overlap(mouseTracker, buttonExit)) {
						if (exitused == false) {
							selectedButton = 2;
							exitused = true;
							buttonExit.alpha = 0.5;
						}
					} else if (FlxG.overlap(mouseTracker, player)) {
						trace ("selectedItem before: " + selectedItem);
						selectedItem = 1;
					} else if (FlxG.overlap(mouseTracker, exit)) {
						trace ("selectedItem before: " + selectedItem);
						selectedItem = 2;
					}
				}
			}
		}
		
		public function createObject(item:Number):void {
			xcounter = FlxG.mouse.x - range/2;
			for (xcounter; xcounter > 0; xcounter = xcounter - range) 
			{
				trace ("xcounter = " + xcounter);
				if (xcounter < range+1) {
					trace ("xcounter");
					if (xcounter < range/2) {
						fixedX = rows * range;
						trace ("x = 0 kant");
					} else {
						fixedX = rows * range + range;
						trace ("x = " + range + " kant");
					}
				} else {
					rows++;
					trace ("loop #" + rows);
				}
			}
			rows = 0;
			
			ycounter = FlxG.mouse.y - range/2;
			for (ycounter; ycounter > 0; ycounter = ycounter - range) 
			{
				trace ("ycounter = " + ycounter);
				if (ycounter < range+1) {
					trace ("ycounter");
					if (ycounter < range/2) {
						fixedY = rows * range;
						trace ("y = 0 kant");
					} else {
						fixedY = rows * range + range;
						trace ("y = " + range + " kant");
					}
				} else {
					rows++;
					trace ("loop #" + rows);
				}
			}
			rows = 0;
			
			switch (item) {
				case 0:
					trace("no number given");
					break;
				case 1:
					player = new Player(fixedX, fixedY, range);
					player.scale = itemScale;
					add(player); break;
				case 2:
					exit = new FlxSprite(fixedX - 5, fixedY - 5, ExitImageClass);
					exit.scale = itemScale;
					add(exit); break;
				default:
					trace("There is no object with the current index number.");
			}
			selectedButton = 0;
		}
		
		public function moveObject(item:Number):void {
			xcounter = FlxG.mouse.x - range/2;
			for (xcounter; xcounter > 0; xcounter = xcounter - range) 
			{
				trace ("xcounter = " + xcounter);
				if (xcounter < range+1) {
					trace ("xcounter");
					if (xcounter < range/2) {
						fixedX = rows * range;
						trace ("x = 0 kant");
					} else {
						fixedX = rows * range + range;
						trace ("x = " + range + " kant");
					}
				} else {
					rows++;
					trace ("loop #" + rows);
				}
			}
			rows = 0;
			
			ycounter = FlxG.mouse.y - range/2;
			for (ycounter; ycounter > 0; ycounter = ycounter - range) 
			{
				trace ("ycounter = " + ycounter);
				if (ycounter < range+1) {
					trace ("ycounter");
					if (ycounter < range/2) {
						fixedY = rows * range;
						trace ("y = 0 kant");
					} else {
						fixedY = rows * range + range;
						trace ("y = " + range + " kant");
					}
				} else {
					rows++;
					trace ("loop #" + rows);
				}
			}
			rows = 0;
			
			switch (item) {
				case 1:
					player.x = fixedX;
					player.y = fixedY;
					selectedItem = 0;
					break;
				case 2:
					exit.x = fixedX;
					exit.y = fixedY;
					selectedItem = 0;
					break;
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