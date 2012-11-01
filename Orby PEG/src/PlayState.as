package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Perry
	 */
	public class PlayState extends FlxState
	{
		[Embed(source = "images/Background.png")] private var BackgroundImageClass:Class;
		[Embed(source = "images/Player.png")] private var PlayerImageClass:Class;
		[Embed(source = "images/RedVerticalLarge.png")] private var RedLaserImageClass:Class;
		[Embed(source = "images/Red.png")] private var RedImageClass:Class;
		[Embed(source = "images/Exit.png")] private var ExitImageClass:Class;
		
		private var player:Player;
		private var background:FlxSprite;
		private var exit:FlxSprite;
		private var playerColor:Number = 0;
		
		private var red:FlxSprite;
		private var redLaser:FlxSprite;
		
		private var redLasers:FlxGroup;
		private var greenLasers:FlxGroup;
		private var blueLasers:FlxGroup;
		private var yellowLasers:FlxGroup;
		
		override public function create():void
		{
			FlxG.flash(0xFF4b4b4b, 1);
			
			//ADD BACKGROUND
			background = new FlxSprite(0, 0, BackgroundImageClass);
			add(background);
			
			//ADD EXIT
			exit = new FlxSprite(535, 215, ExitImageClass);
			add(exit);
			
			//ADD RED COLOR
			red = new FlxSprite(140, 220, RedImageClass);
			add(red);
			
			//ADD PLAYER
			player = new Player(20, 220, 40);
			add(player);
			
			//ADD RED LASER
			redLaser = new FlxSprite(300, 0, RedLaserImageClass);
			add(redLaser);
		}
		
		override public function update():void
		{
			super.update();
			if (playerColor == 0)//white
			{
				FlxG.overlap(player, redLaser, explode);
			}
			if (FlxG.overlap(player, red))
			{
				player.changeColor(1);
				playerColor = 1;
			}
			
			if (player.getColor() == 0)
			{
				player.play("main");
			}
			else if (player.getColor() == 1)
			{
				player.play("red");
			}
			
			if (FlxG.keys.justReleased("ESCAPE")) {
				fadeToMenu();
			}
			
			FlxG.overlap(player, exit, win);
		}
		
		public function explode(playertje:Player, lasertje:FlxSprite):void
		{
			player.explode();
			FlxG.fade(0xFF000000, 1, restart);
		}
		
		public function fadeToMenu():void
		{
			FlxG.fade(0xFF4b4b4b, 1, returnToMenu);
		}
		
		public function returnToMenu():void
		{
			FlxG.switchState(new MenuState());
		}
		
		public function restart():void
		{
			FlxG.resetState();
		}
		
		public function win(playertje:Player, exitje:FlxSprite):void
		{
			FlxG.fade(0xFF000000, 1, nextLevel);
		}
		
		public function nextLevel():void
		{
			FlxG.switchState(new PlayState2());
		}
	}
}