package
{
	import org.flixel.*;
	import flash.display.Sprite;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxSprite
	{
		[Embed(source = "images/Player.png")] public var PlayerImageClass:Class;
		
		private var currentColor:Number = 0;
		private var broken:Boolean = false;
		private var range:Number;
		
		public function Player(X:int, Y:int, speed:Number)
		{
			super(X, Y);
			range = speed;
			loadGraphic(PlayerImageClass, true, false, 40, 40);
			addAnimation("main", [0, 1, 2, 3], 5);
			addAnimation("red", [4], 1);
		}
		
		override public function update():void
		{
			if (currentColor == 0)
			{
				play("main");
			}
			else if (currentColor == 1)
			{
				play("red");
			}
			
			//movement for the player
			if (FlxG.keys.justReleased("LEFT") && broken == false)
			{
				this.x -= range;
			}
			else if (FlxG.keys.justReleased("RIGHT") && broken == false)
			{
				this.x += range;
			}
			else if (FlxG.keys.justReleased("UP") && broken == false)
			{
				this.y -= range;
			}
			else if (FlxG.keys.justReleased("DOWN") && broken == false)
			{
				this.y += range;
			}
			
			bounds();
		}
		
		public function bounds():void
		{
			if (this.x > 630)
			{
				this.x -= range;
			}
			if (this.x < 0)
			{
				this.x += range;
			}
			if (this.y > 470)
			{
				this.y -= range;
			}
			if (this.y < 0)
			{
				this.y += range;
			}
		}
		
		public function changeColor(colortje:Number):void
		{
			currentColor = colortje;
		}
		
		public function explode():void
		{
			broken = true;
		}
		
		public function getColor():Number
		{
			return color;
		}
	}
}