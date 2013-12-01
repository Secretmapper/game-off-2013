package objects 
{
	import utils.number.randomIntegerWithinRange;
	/**
	 * ...
	 * @author Secretmapper
	 */
	public class CivilianOne extends Civilian
	{
		
		public function CivilianOne(flip:Boolean) 
		{
			super();
			_sprite = new Civilian1_lib();
			xAccel = 4;
			_money = 1;
			_chance = 25;
			
			this.flip = flip;
			
			
			
			if (randomIntegerWithinRange(0, 1) == 0)
				_sprite.thinie.gotoAndStop(2);
			
			if (!flip)
			{
				_sprite.thinie.scaleX *= -1;
				//_sprite.thinie.x += 170;
				
			}
			if(flip) xAccel *= -1;
		}
		
	}

}