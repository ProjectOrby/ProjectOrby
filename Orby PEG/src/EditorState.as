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
		[Embed(source = "images/Player.png")] private var PlayerImageClass:Class;
		[Embed(source = "images/EditMenu.png")] private var EditMenuImageClass:Class;
		[Embed(source = "images/buttonPlayer.png")] private var ButtonPlayerImageClass:Class;
		[Embed(source = "images/buttonExit.png")] private var ButtonExitImageClass:Class;
		[Embed(source = "images/Red.png")] private var RedImageClass:Class;
		[Embed(source = "images/Exit.png")] private var ExitImageClass:Class;
		
		private var background:FlxSprite; //The background sprite.
		private var itemScale:Number = 1; //Indicates the scale of the placable objects.
		private var editMenuBackground:FlxSprite; //The background sprite of the edit menu.
		private var buttonPlayer:FlxSprite; //The Player button.
		private var buttonExit:FlxSprite; //The Exit button.
		private var mouseTracker:FlxSprite; //A 1px sprite that follows the x and y of the mouse to check collisions.
		private var selectedItem:Number = 0; //The index number of the selected item in the edit menu.
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
						itemScale = 1;
						range = 40;
						background = new FlxSprite(0, 0, Grid1Class); break;
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
				if (selectedItem != 0) {
					createObject(selectedItem);
				}
				if (selectedItem == 0) {
					if (FlxG.overlap(mouseTracker, buttonPlayer)) {
						if (playerused == false) {
							selectedItem = 1;
							playerused = true;
							buttonPlayer.alpha = 0.5;
						}
					} else if (FlxG.overlap(mouseTracker, buttonExit)) {
						if (exitused == false) {
							selectedItem = 2;
							exitused = true;
							buttonExit.alpha = 0.5;
						}
					} else if (FlxG.overlap(mouseTracker, player)) {
						//lol
					}
				}
			}
		}
		
		public function createObject(item:Number):void {
			xcounter = FlxG.mouse.x - 20;
			for (xcounter; xcounter > 0; xcounter = xcounter - 40) 
			{
				trace ("xcounter = " + xcounter);
				if (xcounter < 41) {
					trace ("xcounter");
					if (xcounter < 20) {
						fixedX = rows * 40;
						trace ("x = 0 kant");
					} else {
						fixedX = rows * 40 + 40;
						trace ("x = 40 kant");
					}
				} else {
					rows++;
					trace ("loop #" + rows);
				}
			}
			rows = 0;
			
			ycounter = FlxG.mouse.y - 20;
			for (ycounter; ycounter > 0; ycounter = ycounter - 40) 
			{
				trace ("ycounter = " + ycounter);
				if (ycounter < 41) {
					trace ("ycounter");
					if (ycounter < 20) {
						fixedY = rows * 40;
						trace ("y = 0 kant");
					} else {
						fixedY = rows * 40 + 40;
						trace ("y = 40 kant");
					}
				} else {
					rows++;
					trace ("loop #" + rows);
				}
			}
			rows = 0;
			
			switch (item) {
				case 1:
					player = new Player(fixedX, fixedY, range);
					add(player); break;
				case 2:
					exit = new FlxSprite(fixedX - 5, fixedY - 5, ExitImageClass);
					add(exit); break;
				default:
					trace("There is no object with the current index number.");
			}
			selectedItem = 0;
		}
	}
}