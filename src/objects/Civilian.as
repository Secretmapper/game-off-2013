package objects 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import utils.number.randomIntegerWithinRange;
	/**
	 * ...
	 * @author Secretmapper
	 */
	public class Civilian extends Entity
	{
		protected var _sprite:MovieClip;
		protected var _money:int;
		protected var _chance:int;
		public var flip:Boolean;
		
		public function Civilian() 
		{
			super();
			_money = 0;
			_chance = 0;
		}
		
		override public function added():void 
		{
			super.added();
			sprite.stop();
			addChild(sprite);
			//sprite.scaleX = sprite.scaleY = 0.5;
			sprite.buttonMode = true;
		}
		
		override public function update():void
		{
			super.update();
			sprite.x += xAccel;
		}
		
		public function clicked():Boolean
		{
			var b:Boolean = randomIntegerWithinRange(1, 100) <= chance;
			(b) ? sprite.gotoAndStop(2) : sprite.gotoAndStop(3);
			return b;
		}
		
		public function get money():int 
		{
			return _money;
		}
		
		public function get chance():int 
		{
			return _chance;
		}
		
		public function get sprite():MovieClip 
		{
			return _sprite;
		}
	}

}