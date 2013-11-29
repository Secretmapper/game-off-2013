package objects 
{
	import flash.display.Stage;
	import utils.math.Percent;
	/**
	 * ...
	 * @author Secretmapper
	 */
	public class BigBusinessMan extends Civilian
	{
		
		
		public function BigBusinessMan(flip:Boolean) 
		{
			_sprite = new Big_Businessman_lib();
			
			this.flip = flip;
			
			_money = 5;
			_chance = 5;
			xAccel = 1;
			
			if (flip)
			{
				_sprite.biggie.scaleX *= -1;
				_sprite.biggie.x += 170;
				xAccel *= -1;
			}
		}
		
		override public function added():void 
		{
			super.added();
		}
		
		override public function clicked():Boolean
		{
			return super.clicked();
		}
		
	}

}