package objects 
{
	/**
	 * ...
	 * @author Secretmapper
	 */
	public class CivilianTwo extends Civilian
	{
		
		public function CivilianTwo() 
		{
			super();
			sprite = new Civilian2_lib();
			xAccel = 2.5;
			_money = 1;
			_chance = 25;
		}
		
	}

}