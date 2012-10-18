package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Perry
	 */
	public class PlayState2 extends FlxState
	{
		[Embed(source = "images/HalfBackground.png")] private var BackgroundImageClass:Class;
		[Embed(source = "images/Player.png")] private var PlayerImageClass:Class;
		[Embed(source = "images/RedVertical.png")] private var RedLaserImageClass:Class;
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
			FlxG.flash(0xFF000000, 1);
			
			//ADD BACKGROUND
			background = new FlxSprite(0, 0, BackgroundImageClass);
			add(background);
			
			//ADD EXIT
			exit = new FlxSprite(515, 195, ExitImageClass);
			add(exit);
			
			//ADD RED COLOR
			red = new FlxSprite(120, 200, RedImageClass);
			add(red);
			
			//ADD RED LASER
			redLaser = new FlxSprite(310, 0, RedLaserImageClass);
			add(redLaser);
			
			//ADD PLAYER
			player = new Player(120, 200, 40);
			add(player);
		}
		
		override public function update():void
		{
			super.update();
			if (playerColor == 0)//white
			{
				FlxG.overlap(player, redLaser, explode);
			}
			if (FlxG.overlap(player, red) && FlxG.keys.justReleased("SPACE"))
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
		}
		
		public function explode(playertje:Player, tiletje:FlxSprite):void
		{
			FlxG.fade(0xFF000000, 1, restart);
		}
		
		public function restart():void
		{
			FlxG.resetState();
		}
	}
}