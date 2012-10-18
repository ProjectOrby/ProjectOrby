package
{
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		[Embed(source = "images/MenuBackground.png")] private var BackgroundImageClass:Class;
		
		private var background:FlxSprite;
		
		public function MenuState()
		{
			FlxG.flash(0xff4b4b4b, 1);
			
			background = new FlxSprite(0, 0, BackgroundImageClass);
			add(background);
			
			var newGameText:FlxText = new FlxText(0, FlxG.height / 2 + 64, FlxG.width = 640, "Press SPACE to start!\n\nPress 'E' to create a level!");
			newGameText.setFormat(null, 16, 0xffffff, "center");
			
			add(newGameText);
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("SPACE"))
				FlxG.fade(0xff4b4b4b, 1, startGame);
			
			if (FlxG.keys.justPressed("E"))
				FlxG.fade(0xff4b4b4b, 1, startEditor);
		}
		
		public function startEditor():void
		{
			FlxG.switchState(new GridState());
		}
		
		public function startGame():void
		{
			FlxG.switchState(new PlayState());
		}
	
	}

}