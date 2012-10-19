package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Gijs
	 */
	public class GridState extends FlxState
	{
		[Embed(source = "images/Background.png")] private var BackgroundImageClass:Class;
		
		private var background:FlxSprite;
		private var chosengrid:Number;
		
		override public function create():void
		{
			FlxG.flash(0xff4b4b4b);
			
			//ADD BACKGROUND
			background = new FlxSprite(0, 0, BackgroundImageClass);
			add(background);
			
			var GridText:FlxText = new FlxText(0, FlxG.height / 2 + 64, FlxG.width = 640, "Select your grid:\n\nA: 16x12 points (press A)\n\nB: 32x24 points (press B)");
			GridText.setFormat(null, 16, 0xffffff, "center");
			add(GridText);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justReleased("A")) {
				chosengrid = 1;
				start();
			}
			if (FlxG.keys.justReleased("B")) {
				chosengrid = 2;
				start();
			}
			if (FlxG.keys.justReleased("ESCAPE")) {
				fadeToMenu();
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
		
		public function start():void
		{
			FlxG.fade(0xFF4b4b4b, 1, startEditor);
		}
		
		public function startEditor():void
		{
			FlxG.switchState(new EditorState(chosengrid));
		}
	}
}