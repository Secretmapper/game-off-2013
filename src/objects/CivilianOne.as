package objects 
{
	/**
	 * ...
	 * @author Secretmapper
	 */
	public class CivilianOne extends Civilian
	{
		
		public function CivilianOne() 
		{
			super();
			sprite = new Civilian1_lib();
			xAccel = 4;
			_money = 1;
			_chance = 25;
		}
		
	}

}